import 'package:flutter/material.dart';

class Ch29HipecTile extends StatelessWidget {
  const Ch29HipecTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.hub, color: Colors.blueGrey), // 象徵管路/循環
      title: const Text("腫瘤減容與溫熱化療 (CRS + HIPEC)"),
      subtitle: const Text("腹膜轉移癌、CC Score、病人篩選"),
      trailing: const Icon(Icons.chevron_right, size: 16),
      dense: true,
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DefaultTabController(
        length: 3,
        child: Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TabBar(
                labelColor: Colors.teal,
                indicatorColor: Colors.teal,
                tabs: [
                  Tab(text: "概念"),
                  Tab(text: "篩選"),
                  Tab(text: "治療"),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    _buildConceptTab(),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: _EligibilityChecklist(),
                    ),
                    _buildTreatmentTab(),
                  ],
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('關閉'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Tab 1: 治療概念 ---
  Widget _buildConceptTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("核心策略"),
          const Text(
            "針對腹膜轉移癌 (Peritoneal Carcinomatosis)。\n"
            "1. CRS (外科): 切除肉眼可見腫瘤。\n"
            "2. HIPEC (化療): 41-43°C 高溫灌注，毒殺微小病灶。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("關鍵指標"),

          _buildInfoCard(
            "CC Score (切除完整度)",
            "CC-0: 無肉眼殘留 (大腸癌目標)。\n"
                "CC-1: 殘留 < 2.5mm (闌尾低惡性度可接受)。\n"
                "CC-2/3: 殘留 > 2.5mm (預後差)。",
          ),

          _buildInfoCard(
            "PCI (腹膜腫瘤指數)",
            "將腹腔分 13 區，每區 0-3 分，總分 39。\n"
                "大腸癌來源：建議 PCI < 20。\n"
                "闌尾來源：PCI 不限 (較寬鬆)。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 治療與併發症 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("腹腔溫熱化療 (HIPEC)"),

          const Text(
            "• 溫度：41–43°C\n• 時間：30–90 分鐘\n• 方式：Open (Coliseum) vs Closed。",
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 8),
          _buildTable(
            ["癌種", "常用藥物"],
            [
              ["大腸直腸癌", "Oxaliplatin (+IV 5-FU)"],
              ["胃腸道腫瘤", "Mitomycin C"],
              ["卵巢癌", "Cisplatin"],
            ],
          ),

          const Divider(height: 24),
          _buildSectionTitle("⚠️ 術後併發症"),
          _buildAlertCard("骨髓抑制 (Marrow Suppression)", "化療吸收所致，需監測血球。"),
          _buildAlertCard("腸道廔管 (Enterocutaneous fistula)", "廣泛剝離後風險高，死亡率增加。"),
          _buildAlertCard("腹內膿瘍 / 腎功能異常", "常見併發症，需引流與水分平衡。"),

          const Divider(height: 24),
          _buildSectionTitle("預後 (Prognosis)"),
          const Text(
            "• 闌尾 LAMN (CC-0 + HIPEC)：10年存活率達 70-80%。\n• 預後因子：腫瘤組織型態、PCI 分數、CC Score。",
            style: TextStyle(height: 1.4, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(content, style: const TextStyle(fontSize: 13, height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.red.shade50,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        subtitle: Text(content, style: const TextStyle(fontSize: 13)),
        dense: true,
      ),
    );
  }

  Widget _buildTable(List<String> headers, List<List<String>> data) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.teal.shade50),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    h,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
        ),
        ...data.map(
          (row) => TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cell),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

// --- Tab 2: 病人篩選檢核表 (Interactive) ---
class _EligibilityChecklist extends StatefulWidget {
  const _EligibilityChecklist();
  @override
  State<_EligibilityChecklist> createState() => _EligibilityChecklistState();
}

class _EligibilityChecklistState extends State<_EligibilityChecklist> {
  // 病人條件
  bool _ecog = false; // ECOG 0-1
  bool _noSystemic = false; // 無遠端轉移 (肺肝骨腦)
  bool _age = false; // 年齡 < 65 (相對)
  bool _bmi = false; // BMI < 35

  // 腫瘤條件
  bool _histology = false; // 分化良好 (G1-2 / LAMN)
  bool _pci = false; // PCI 符合標準 (<20 for CRC)

  @override
  Widget build(BuildContext context) {
    bool isPass = _ecog && _noSystemic && _age && _bmi && _histology && _pci;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "病人篩選標準 (Patient Selection)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            "嚴格篩選是手術成功的關鍵。",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Divider(),

          _buildCheck("體能狀況 ECOG 0-1", _ecog, (v) => _ecog = v),
          _buildCheck("無腹腔外轉移 (肺/肝/骨)", _noSystemic, (v) => _noSystemic = v),
          _buildCheck("年齡 < 65 歲 (視生理年齡)", _age, (v) => _age = v),
          _buildCheck("BMI < 35 (非病態肥胖)", _bmi, (v) => _bmi = v),
          const Divider(),
          _buildCheck(
            "組織分化良好 (G1-2 / LAMN)",
            _histology,
            (v) => _histology = v,
          ),
          _buildCheck("PCI 指數符合標準 (CRC < 20)", _pci, (v) => _pci = v),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: isPass ? Colors.green.shade50 : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isPass ? Colors.green : Colors.orange),
            ),
            child: Column(
              children: [
                Icon(
                  isPass ? Icons.check_circle : Icons.info,
                  size: 40,
                  color: isPass ? Colors.green : Colors.orange,
                ),
                const SizedBox(height: 8),
                Text(
                  isPass ? "符合篩選標準" : "需謹慎評估",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isPass
                        ? Colors.green.shade800
                        : Colors.orange.shade900,
                  ),
                ),
                Text(
                  isPass ? "可考慮安排 CRS + HIPEC" : "存在相對禁忌症或高風險因子",
                  style: TextStyle(
                    color: isPass
                        ? Colors.green.shade800
                        : Colors.orange.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheck(String title, bool val, Function(bool) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: const TextStyle(fontSize: 14)),
      value: val,
      activeColor: Colors.teal,
      onChanged: (v) => setState(() => onChanged(v!)),
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }
}
