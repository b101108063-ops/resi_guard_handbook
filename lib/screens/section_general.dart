import 'package:flutter/material.dart';
import '../logic/general_principles.dart'; // 連結邏輯層

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(
          Icons.menu_book,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: const Text(
          "Ch1-8 基礎核心能力",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("術前評估、抗生素、輸液、營養、傷口"),
        children: [
          _buildItem(
            context,
            '預防性抗生素',
            'Cefazolin 劑量計算',
            Icons.medication,
            () => showDialog(
              context: context,
              builder: (c) => const _AntibioticCalculator(),
            ),
          ),

          _buildItem(
            context,
            '輸液計算機',
            'Maintenance Fluid 計算',
            Icons.water_drop,
            () => showDialog(
              context: context,
              builder: (c) => const _FluidCalculator(),
            ),
          ),

          _buildItem(
            context,
            '術後併發症快篩',
            '吻合口滲漏評估',
            Icons.warning_amber,
            () => showDialog(
              context: context,
              builder: (c) => const _LeakAssessment(),
            ),
          ),

          _buildItem(
            context,
            '營養支持 (Nutrition)',
            '熱量蛋白、飲食質地、ICU 指引',
            Icons.restaurant_menu,
            () => showDialog(
              context: context,
              builder: (c) => const _NutritionCalculator(),
            ),
          ),

          _buildItem(
            context,
            '知情同意',
            '簽署有效性檢核',
            Icons.assignment_turned_in,
            () => showDialog(
              context: context,
              builder: (c) => const _ConsentChecklist(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    String sub,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal, size: 24),
      title: Text(title),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: onTap,
      dense: true,
    );
  }
}

// ==========================================
// 1. 抗生素計算機
// ==========================================
class _AntibioticCalculator extends StatefulWidget {
  const _AntibioticCalculator();
  @override
  State<_AntibioticCalculator> createState() => _AntibioticCalculatorState();
}

class _AntibioticCalculatorState extends State<_AntibioticCalculator> {
  final _weightController = TextEditingController();
  String _result = "";
  void _calculate() {
    if (_weightController.text.isEmpty) return;
    double weight = double.tryParse(_weightController.text) ?? 0;
    double dose = GeneralPrinciples.calculateCefazolinDose(weight);
    setState(() {
      _result = "建議劑量：${dose.toStringAsFixed(0)} g\n";
      if (weight >= 120)
        _result += "(體重 ≥ 120kg)";
      else if (weight > 80)
        _result += "(體重 > 80kg)";
      else
        _result += "(標準體重)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('預防性抗生素計算'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '病人體重',
              suffixText: 'kg',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => _calculate(),
          ),
          const SizedBox(height: 20),
          if (_result.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _result,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('關閉'),
        ),
      ],
    );
  }
}

// ==========================================
// 2. 輸液計算機
// ==========================================
class _FluidCalculator extends StatefulWidget {
  const _FluidCalculator();
  @override
  State<_FluidCalculator> createState() => _FluidCalculatorState();
}

class _FluidCalculatorState extends State<_FluidCalculator> {
  final _weightController = TextEditingController();
  String _result = "";
  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_weightController.text.isEmpty) return;
    double weight = double.tryParse(_weightController.text) ?? 0;
    var res = GeneralPrinciples.calculateMaintenanceFluid(weight);
    setState(() {
      _result =
          "每日總量: ${res['daily_ml']?.toStringAsFixed(0)} ml\n滴速: ${res['rate_ml_hr']?.toStringAsFixed(1)} ml/hr";
    });
  }

  void _showFluidList(BuildContext context) {
    var fluids = GeneralPrinciples.getFluidDatabase();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('常用輸液成分速查'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.separated(
            itemCount: fluids.length,
            separatorBuilder: (c, i) => const Divider(),
            itemBuilder: (c, i) {
              var f = fluids[i];
              Color typeColor = Colors.grey;
              if (f['type']!.contains('等張')) typeColor = Colors.green;
              if (f['type']!.contains('高張')) typeColor = Colors.red;
              if (f['type']!.contains('低張')) typeColor = Colors.orange;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  f['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            f['type']!,
                            style: TextStyle(
                              color: typeColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "成分: ${f['content']}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "用途: ${f['usage']}",
                      style: const TextStyle(fontSize: 13),
                    ),
                    if (f['warning'] != null)
                      Text(
                        "${f['warning']}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('維持輸液計算 (Maintenance)'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '依據 100/50/20 法則',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '病人體重',
                suffixText: 'kg',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _calculate(),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.search, color: Colors.teal),
              title: const Text('點滴成分與禁忌速查'),
              subtitle: const Text('N/S, L/R, 台大系列...'),
              onTap: () => _showFluidList(context),
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('關閉'),
        ),
      ],
    );
  }
}

// ==========================================
// 3. 吻合口滲漏評估
// ==========================================
class _LeakAssessment extends StatefulWidget {
  const _LeakAssessment();
  @override
  State<_LeakAssessment> createState() => _LeakAssessmentState();
}

class _LeakAssessmentState extends State<_LeakAssessment> {
  int _postOpDay = 1;
  bool _hasFever = false;
  bool _hasPeritonitis = false;
  String _drainContent = "Clear";
  String _result = "";
  void _assess() {
    String msg = GeneralPrinciples.assessAnastomoticLeak(
      postOpDay: _postOpDay,
      drainContent: _drainContent,
      hasFever: _hasFever,
      hasPeritonitis: _hasPeritonitis,
    );
    setState(() {
      _result = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('吻合口滲漏評估'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('術後天數 (POD): '),
                DropdownButton<int>(
                  value: _postOpDay,
                  items: List.generate(14, (i) => i + 1)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() {
                    _postOpDay = v!;
                  }),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('發燒 (Fever)'),
              value: _hasFever,
              onChanged: (v) => setState(() {
                _hasFever = v!;
              }),
            ),
            CheckboxListTile(
              title: const Text('腹膜炎症狀 (腹痛/反彈痛)'),
              value: _hasPeritonitis,
              onChanged: (v) => setState(() {
                _hasPeritonitis = v!;
              }),
            ),
            const Divider(),
            const Text('引流管性狀:', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile(
              title: const Text('清澈 (Clear)'),
              value: 'Clear',
              groupValue: _drainContent,
              onChanged: (v) => setState(() {
                _drainContent = v.toString();
              }),
            ),
            RadioListTile(
              title: const Text('混濁 (Turbid)'),
              value: 'Turbid',
              groupValue: _drainContent,
              onChanged: (v) => setState(() {
                _drainContent = v.toString();
              }),
            ),
            RadioListTile(
              title: const Text('糞水/膽汁樣 (Stool-like)'),
              value: 'Stool-like',
              groupValue: _drainContent,
              onChanged: (v) => setState(() {
                _drainContent = v.toString();
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _assess,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('開始評估'),
            ),
            if (_result.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _result,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _result.contains("✅") ? Colors.green : Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. 營養計算機 (Nutrition) - Updated
// ==========================================
class _NutritionCalculator extends StatefulWidget {
  const _NutritionCalculator();
  @override
  State<_NutritionCalculator> createState() => _NutritionCalculatorState();
}

class _NutritionCalculatorState extends State<_NutritionCalculator> {
  final _actualWeightCtrl = TextEditingController();
  String _condition = 'General'; // 預設一般
  Map<String, String>? _result;

  // 條件選單對應表
  final Map<String, String> _conditionMap = {
    'General': '一般術後 (General)',
    'ICU_Acute': 'ICU 急性期 (Acute Phase)',
    'ICU_Recovery': 'ICU 恢復期 (Recovery Phase)',
    'CKD_Pre': '慢性腎病 (未透析)',
    'CKD_Dialysis': '洗腎 (HD/PD)',
    'CRRT': '重症透析 (CRRT)',
  };

  void _calculate() {
    double actual = double.tryParse(_actualWeightCtrl.text) ?? 0;
    if (actual == 0) return;

    setState(() {
      _result = GeneralPrinciples.calculateAdvancedNutrition(
        weight: actual,
        condition: _condition,
      );
    });
  }

  // 顯示飲食質地 Dialog
  void _showDietTypesDialog() {
    var diets = GeneralPrinciples.getDietTypes();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('飲食質地種類'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.separated(
            itemCount: diets.length,
            separatorBuilder: (c, i) => const Divider(),
            itemBuilder: (c, i) => ListTile(
              title: Text(
                diets[i]['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(diets[i]['desc']!),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }

  // 顯示重症指引 Dialog
  void _showICUGuideDialog() {
    var topics = ['EN vs PN', 'Refeeding Syndrome', 'Gastric Residual (GRV)'];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('重症營養指引'),
        children: topics
            .map(
              (t) => ListTile(
                title: Text(t),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(t),
                      content: Text(GeneralPrinciples.getICUNutritionGuide(t)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('關閉'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('臨床營養支持'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _actualWeightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '目前體重 (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => _calculate(),
            ),
            const SizedBox(height: 15),
            const Text(
              '病人狀況 (Condition):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _condition,
              isExpanded: true,
              items: _conditionMap.entries
                  .map(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (v) {
                setState(() => _condition = v!);
                _calculate();
              },
            ),
            const SizedBox(height: 10),

            if (_result != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🔥 熱量目標: ${_result!['Calories']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "🥩 蛋白質目標: ${_result!['Protein']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text(
                      "💡 ${_result!['Note']}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showDietTypesDialog,
                    icon: const Icon(Icons.rice_bowl, size: 16),
                    label: const Text('飲食質地', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _showICUGuideDialog,
                    icon: const Icon(Icons.local_hospital, size: 16),
                    label: const Text('重症指引', style: TextStyle(fontSize: 12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('關閉'),
        ),
      ],
    );
  }
}

// ==========================================
// 5. 知情同意檢核
// ==========================================
class _ConsentChecklist extends StatefulWidget {
  const _ConsentChecklist();
  @override
  State<_ConsentChecklist> createState() => _ConsentChecklistState();
}

class _ConsentChecklistState extends State<_ConsentChecklist> {
  bool _isAdult = true;
  bool _isSedated = false;
  bool _isOriented = true;
  bool _isEmergency = false;
  Map<String, dynamic>? _result;
  void _check() {
    setState(() {
      _result = GeneralPrinciples.validateConsent(
        isAdult: _isAdult,
        isSedated: _isSedated,
        isOriented: _isOriented,
        isEmergency: _isEmergency,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
    return AlertDialog(
      title: const Text('簽署有效性檢核'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('緊急救命 (Emergency)'),
              subtitle: const Text('生命威脅情況'),
              value: _isEmergency,
              secondary: const Icon(Icons.emergency, color: Colors.red),
              onChanged: (v) => setState(() {
                _isEmergency = v;
              }),
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('已成年 (Adult)'),
              value: _isAdult,
              onChanged: (v) => setState(() {
                _isAdult = v;
              }),
            ),
            SwitchListTile(
              title: const Text('意識清楚 (Oriented)'),
              subtitle: const Text('人時地清楚'),
              value: _isOriented,
              onChanged: (v) => setState(() {
                _isOriented = v;
              }),
            ),
            SwitchListTile(
              title: const Text('受藥物影響 (Sedated)'),
              subtitle: const Text('剛打 Demerol/Morphine'),
              value: _isSedated,
              activeColor: Colors.red,
              onChanged: (v) => setState(() {
                _isSedated = v;
              }),
            ),
            const SizedBox(height: 10),
            if (_result != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _result!['canSign']
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result!['msg'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _result!['canSign']
                        ? Colors.green[800]
                        : Colors.red[800],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
