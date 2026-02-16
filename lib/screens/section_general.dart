import 'package:flutter/material.dart';
import '../logic/general_principles.dart'; // 連結核心緒論邏輯

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
            'Cefazolin 劑量、Re-dosing',
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
// 1. 抗生素計算機 & 指引
// ==========================================
class _AntibioticCalculator extends StatefulWidget {
  const _AntibioticCalculator();
  @override
  State<_AntibioticCalculator> createState() => _AntibioticCalculatorState();
}

class _AntibioticCalculatorState extends State<_AntibioticCalculator> {
  // Dosing
  final _weightController = TextEditingController();
  Map<String, dynamic>? _doseResult;

  // Re-dosing
  final _timeController = TextEditingController();
  final _bloodLossController = TextEditingController();
  Map<String, String>? _redoseResult;

  void _calculateDose() {
    double w = double.tryParse(_weightController.text) ?? 0;
    if (w > 0) {
      setState(() => _doseResult = GeneralPrinciples.calculateCefazolinDose(w));
    }
  }

  void _checkRedosing() {
    double t = double.tryParse(_timeController.text) ?? 0;
    double b = double.tryParse(_bloodLossController.text) ?? 0;
    setState(
      () => _redoseResult = GeneralPrinciples.checkRedosing(
        hours: t,
        bloodLoss: b,
      ),
    );
  }

  void _showGuide(String topic) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(topic),
        content: Text(
          GeneralPrinciples.getAntibioticGuidelines(topic),
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('預防性抗生素指引'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Dosing
              const Text(
                '💊 術前劑量 (Cefazolin)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '體重 (kg)',
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => _calculateDose(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_doseResult != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _doseResult!['dose'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            _doseResult!['note'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),

              const Divider(height: 24),

              // Section 2: Re-dosing
              const Text(
                '🩸 術中追加 (Re-dosing)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _timeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '手術時間 (hr)',
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _bloodLossController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '出血量 (mL)',
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _checkRedosing,
                  child: const Text('評估是否追加'),
                ),
              ),
              if (_redoseResult != null)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _redoseResult!['status']!.contains("🔴")
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "${_redoseResult!['status']}\n${_redoseResult!['reason']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

              const Divider(height: 24),

              // Section 3: Guidelines
              const Text(
                '📚 臨床指引速查',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    label: const Text('給藥時機'),
                    onPressed: () => _showGuide('給藥時機'),
                  ),
                  ActionChip(
                    label: const Text('手術分類'),
                    onPressed: () => _showGuide('手術分類'),
                  ),
                  ActionChip(
                    label: const Text('特殊手術'),
                    onPressed: () => _showGuide('特殊手術'),
                  ),
                  ActionChip(
                    label: const Text('MRSA'),
                    onPressed: () => _showGuide('MRSA風險'),
                  ),
                ],
              ),
            ],
          ),
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
// 2. 輸液計算機 (Fixed Null Safety Issue)
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
              // ⚠️ 修正點：使用 ?? '' 確保字串不為 null，避免 .contains() 報錯
              String typeStr = f['type'] ?? '';
              Color typeColor = Colors.grey;

              if (typeStr.contains('等張')) typeColor = Colors.green;
              if (typeStr.contains('高張')) typeColor = Colors.red;
              if (typeStr.contains('低張')) typeColor = Colors.orange;

              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  f['name'] ?? '',
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
                            typeStr,
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
                      "成分: ${f['content'] ?? ''}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "用途: ${f['usage'] ?? ''}",
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
// 4. 營養計算機 (Nutrition)
// ==========================================
class _NutritionCalculator extends StatefulWidget {
  const _NutritionCalculator();
  @override
  State<_NutritionCalculator> createState() => _NutritionCalculatorState();
}

class _NutritionCalculatorState extends State<_NutritionCalculator> {
  final _actualWeightCtrl = TextEditingController();
  String _condition = 'General';
  Map<String, String>? _result;

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
