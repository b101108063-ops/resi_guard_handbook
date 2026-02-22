import 'package:flutter/material.dart';

class Ch34_2LumbarDiscTile extends StatelessWidget {
  const Ch34_2LumbarDiscTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.accessibility_new,
        color: Colors.purple,
      ), // 象徵下背/腰椎活動
      title: const Text("腰椎間盤突出 (Lumbar Disc)"),
      subtitle: const Text("神經定位、馬尾症候群、前方血管損傷"),
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
                  Tab(text: "急症(CES)"),
                  Tab(text: "治療評估"),
                  Tab(text: "術後併發症"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildLocalizationTab(),
                    _buildCESTab(),
                    _buildManagementTab(),
                    _buildComplicationsTab(),
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

  // --- Tab 1: 神經學定位與理學檢查 ---
  Widget _buildLocalizationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("臨床病程"),
          const Text(
            "初期為下背痛，隨後轉為神經根痛 (坐骨神經痛)。\n• 加劇：咳嗽、打噴嚏、排便用力 (Straining)。\n• 緩解：彎曲膝蓋與大腿。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("腰椎神經定位 (Myotomes)"),

          _buildTable(
            ["神經根", "運動測試 (Motor)"],
            [
              ["L2", "髖關節屈曲 (Hip flexors)"],
              ["L3", "膝關節伸直 (Knee extensors)"],
              ["L4", "足背屈曲 (Ankle dorsiflexors)"],
              ["L5", "長趾伸直 (Long toe extensors) - 翹大拇趾"],
              ["S1", "足蹠屈曲 (Ankle plantar flexors) - 踩油門"],
            ],
          ),

          const Divider(height: 24),
          _buildSectionTitle("理學檢查 (Physical Exams)"),

          _buildInfoCard(
            "直腿抬高試驗 (SLRT)",
            "拉扯 L5 與 S1 神經根。較少拉扯 L4，有助於與髖關節病變做鑑別。",
          ),
          _buildInfoCard("反向直腿抬高 (Reverse SLRT)", "病患俯臥，測試高位腰椎 (L2, L3, L4)。"),
          _buildInfoCard("弓弦徵象 (Bowstring sign)", "在膕窩處按壓會引發坐骨神經痛。"),
        ],
      ),
    );
  }

  // --- Tab 2: 外科急症：馬尾症候群 (CES) ---
  Widget _buildCESTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAlertCard(
            "🚨 絕對急症：馬尾症候群 (CES)",
            "肇因於巨大中線椎間盤破裂 (最常見 L4/5) 壓迫馬尾神經。\n"
                "若延誤治療將導致永久性大小便失禁與癱瘓！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("臨床核心徵象"),
          _buildInfoCard(
            "括約肌障礙 (最一致發現)",
            "尿滯留 (Urinary retention) 常伴隨滿溢性尿失禁，及肛門括約肌張力下降 (Check anal tone!)。",
          ),
          _buildInfoCard("鞍部麻木 (Saddle anesthesia)", "會陰部周圍感覺缺損。"),
          _buildInfoCard("顯著運動無力", "雙側下肢嚴重無力，甚至進展至下半身癱瘓 (Paraplegia)。"),

          const Divider(height: 24),
          _buildSectionTitle("處置準則"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "強烈建議進行 緊急減壓手術 (Urgent decompression)！\n若中線極度緊繃，可能需經硬膜內 (Transdural) 移除。",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 治療策略與影像 ---
  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("影像學評估"),
          _buildInfoCard(
            "MRI (黃金標準)",
            "評估椎管外病灶及椎間盤信號。缺點：劇痛無法靜臥會產生假影、脊椎側彎判讀較困難。",
          ),
          _buildInfoCard("X光 (Plain X-ray)", "包含 Flexion/Extension 視角，評估穩定度。"),

          const Divider(height: 24),
          _buildSectionTitle("手術適應症 (Surgical Indications)"),
          const Text(
            "• 緊急手術：馬尾症候群 (CES)、進行性運動神經缺損 (Progressive motor deficit)。\n• 常規手術：保守治療失敗，且症狀與影像學高度吻合者。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("術式選項"),
          const Text(
            "1. 傳統微創椎間盤切除術 (Conventional microdiscectomy)\n2. 顯微內視鏡椎間盤切除術 (MED)",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 術後照護與併發症 (極重要) ---
  Widget _buildComplicationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("術後監測重點"),
          const Text(
            "• 必須常規檢查下肢 Motor power。\n• 警戒「術後血腫」壓迫：若出現會陰麻木、無法排尿、下肢無力，提示術後 CES，需緊急拆線探查！",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("嚴重術中併發症"),

          _buildAlertCard(
            "🚨 前方結構損傷 (椎間盤前方穿透)",
            "若器械穿透椎間盤前方，可能引發致命大出血或器官損傷：\n"
                "1. 大血管：主動脈 (Aorta)、腔靜脈 (IVC)、總髂動脈 (Iliac artery)。\n"
                "2. 輸尿管 (Ureters)。\n"
                "3. 腸道 (Bowel)。\n"
                "4. 交感神經幹。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("常見併發症"),
          _buildInfoCard(
            "硬腦膜破裂 (Incidental durotomy)",
            "可能導致 CSF 廔管或假性脊膜膨出。術中需縫合修補。",
          ),
          _buildInfoCard(
            "其他",
            "椎間盤炎 (Discitis)、深部靜脈血栓 (DVT)、脊椎手術失敗症候群 (Failed back syndrome)。",
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.purple,
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.red.shade50, // 無 const
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.red.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.red.shade900,
              ),
            ), // 無 const
          ],
        ),
      ),
    );
  }

  Widget _buildTable(List<String> headers, List<List<String>> data) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(3)},
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.purple.shade50),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    h,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
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
                    child: Text(cell, style: const TextStyle(fontSize: 13)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
