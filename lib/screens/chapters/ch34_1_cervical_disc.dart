import 'package:flutter/material.dart';

class Ch34_1CervicalDiscTile extends StatelessWidget {
  const Ch34_1CervicalDiscTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.airline_seat_recline_normal, color: Colors.purple), // 象徵脊椎/頸部
      title: const Text("頸椎間盤突出 (Cervical Disc)"),
      subtitle: const Text("神經學定位、ACDF 手術、術後急症"),
      trailing: const Icon(Icons.chevron_right, size: 16),
      dense: true,
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DefaultTabController(
        length: 4,
        child: Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TabBar(
                labelColor: Colors.purple,
                indicatorColor: Colors.purple,
                isScrollable: true,
                tabs: [
                  Tab(text: "神經定位"),
                  Tab(text: "特殊/影像"),
                  Tab(text: "手術策略"),
                  Tab(text: "術後/併發症"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildLocalizationTab(),
                    _buildSyndromesTab(),
                    _buildSurgicalTab(),
                    _buildComplicationsTab(),
                  ],
                ),
              ),
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('關閉')),
            ],
          ),
        ),
      ),
    );
  }

  // --- Tab 1: 神經學定位 (Clinical Localization) ---
  Widget _buildLocalizationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildSectionTitle("機轉表現"),
        const Text("• 神經根壓迫 (Radiculopathy)：沿神經分布的輻射痛、麻木與無力。\n• 脊髓病變 (Myelopathy)：直接壓迫或缺血造成，表現為下肢近端無力、痙攣 (Spasticity)、手部萎縮。", style: TextStyle(height: 1.5)),
        
        const Divider(height: 24),
        _buildSectionTitle("頸椎神經學定位 (重點必背)"),
        
        _buildTable(["神經根", "運動 (Myotome)", "感覺 (Dermatome)", "反射 (Reflex)"], [
          ["C5", "三角肌 (肩外展)", "肩部", "二頭肌"],
          ["C6", "屈肘、伸腕", "上臂、橈側前臂、拇指", "肱橈肌"],
          ["C7", "伸肘、伸指", "中指", "三頭肌"],
          ["C8", "手部抓握", "無名指、小指", "無"],
        ]),
        
        const SizedBox(height: 12),
        const Text("💡 提示：若狹窄節段以下出現反射亢進 (Hyperactive)、陣攣 (Clonus) 或 Babinski's sign 陽性，提示為上運動神經元 (脊髓) 受損。", style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
      ]),
    );
  }

  // --- Tab 2: 特殊症候群與影像學 ---
  Widget _buildSyndromesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildSectionTitle("特殊臨床症候群"),
        
        _buildInfoCard("中央髓症候群 (Central Cord Syndrome)", 
            "• 機轉：脊髓中央分水嶺區域缺血/損傷。\n"
            "• 特徵：上肢的運動與感覺缺損比下肢嚴重！手部症狀尤為明顯。"),
        _buildInfoCard("布朗-塞卡症候群 (Brown-Sequard Syndrome)", 
            "• 機轉：椎管不對稱狹窄 (半側脊髓受損)。\n"
            "• 特徵：同側運動無力 (皮質脊髓徑)、同側本體覺喪失 (後索)；對側痛覺與溫覺喪失 (脊髓丘腦徑)。"),

        const Divider(height: 24),
        _buildSectionTitle("影像學評估"),
        const Text("• MRI (首選)：評估椎管、脊髓內部異常 (去髓鞘、水腫、空洞症)，並排除腫瘤/感染。\n• X光：評估骨刺 (Osteophytic spurs) 或排列不良。\n• CT/Myelogram：MRI 禁忌時使用，提供骨骼細節。", style: TextStyle(height: 1.5)),
      ]),
    );
  }

  // --- Tab 3: 手術策略 (Surgical Approach) ---
  Widget _buildSurgicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildSectionTitle("前路手術 (Anterior Approach)"),
        const Text("適用於前方病灶 (移除骨刺或中央型突出)。", style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 8),
        
        _buildInfoCard("頸椎前路椎間盤切除與融合術 (ACDF)", 
            "• 優點：安全移除骨刺，提供局部固定。\n"
            "• 缺點：限制頸部活動，並增加相鄰節段退化壓力 (Adjacent segment disease)。"),
        _buildInfoCard("人工椎間盤置換術 (ADR)", 
            "• 目標：模擬原有椎間盤功能，保留活動度。\n"
            "• 特定併發症：異位性骨化 (Heterotopic ossification)。"),

        const Divider(height: 24),
        _buildSectionTitle("後路手術 (Posterior Approach)"),
        _buildInfoCard("適用與缺點", 
            "• 適用：後方病灶 (黃韌帶內摺)、先天狹窄、多節段疾病。\n"
            "• 缺點：前方骨刺可能持續惡化；具術後半脫位或後凸成角畸形 (Kyphotic angulation) 風險；術後疼痛較明顯。"),
      ]),
    );
  }

  // --- Tab 4: 術後照護與併發症 (值班重點) ---
  Widget _buildComplicationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildSectionTitle("術後急症 (Surgical Emergencies)"),
        _buildAlertCard("🚨 術後血腫 (Postoperative Hematoma)", 
            "前路手術 (ACDF) 後必須嚴密監測！\n"
            "• 臨床徵象：呼吸窘迫、極度吞嚥困難。\n"
            "• 影像徵象：X光顯示氣管偏移。\n"
            "• 處置：必須立即床邊拆線減壓或送進開刀房！若壓迫脊髓會出現長徑徵象 (Long tract signs)。"),

        const Divider(height: 24),
        _buildSectionTitle("神經與血管損傷"),
        _buildInfoCard("聲音沙啞 (Hoarseness)", "提示可能傷及喉返神經 (RLN) 或迷走神經造成聲帶麻痺。"),
        _buildInfoCard("Horner's Syndrome", "交感神經鏈受損 (下垂、瞳孔縮小、無汗)。"),
        _buildInfoCard("大血管損傷", "術中操作可能傷及椎動脈或頸動脈。"),

        const Divider(height: 24),
        _buildSectionTitle("其他併發症"),
        const Text("• 呼吸/消化道：術中暴露可能導致咽喉、食道或氣管穿孔；或因植入物 (Graft) 擠出導致吞嚥困難。\n• 融合失敗：植入物擠出、前方向成角變形。", style: TextStyle(height: 1.5)),
      ]),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple)),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 0, margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),
        ]),
      ),
    );
  }

  Widget _buildAlertCard(String title, String content) {
    return Card(
      elevation: 0, margin: const EdgeInsets.only(bottom: 8),
      color: Colors.red.shade50, // 避開 const
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.red.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.redAccent)),
          const SizedBox(height: 6),
          Text(content, style: TextStyle(fontSize: 13, height: 1.5, color: Colors.red.shade900)), // 避開 const
        ]),
      ),
    );
  }

  Widget _buildTable(List<String> headers, List<List<String>> data) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1.2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.purple.shade50),
          children: headers.map((h) => Padding(padding: const EdgeInsets.all(8.0), child: Text(h, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))).toList(),
        ),
        ...data.map((row) => TableRow(
          children: row.map((cell) => Padding(padding: const EdgeInsets.all(8.0), child: Text(cell, style: const TextStyle(fontSize: 12)))).toList(),
        )),
      ],
    );
  }
}