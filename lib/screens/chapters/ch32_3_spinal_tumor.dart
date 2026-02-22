import 'package:flutter/material.dart';

class Ch32_3SpinalTumorTile extends StatelessWidget {
  const Ch32_3SpinalTumorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.view_day, color: Colors.purple), // 象徵脊椎節段
      title: const Text("脊椎腫瘤 (Spinal Tumors)"),
      subtitle: const Text("依解剖位置分類、鑑別診斷與處置"),
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
                labelColor: Colors.purple,
                indicatorColor: Colors.purple,
                isScrollable: true,
                tabs: [
                  Tab(text: "脊膜外 (55%)"),
                  Tab(text: "脊膜內-髓外 (40%)"),
                  Tab(text: "脊髓內 (5%)"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildExtraduralTab(),
                    _buildIntraduralExtramedullaryTab(),
                    _buildIntramedullaryTab(),
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

  // --- Tab 1: 脊膜外 (Extradural) ---
  Widget _buildExtraduralTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("總論"),
          const Text(
            "絕大部分為「轉移性腫瘤」，原發性極罕見。\n• 溶骨性 (Osteolytic)：淋巴瘤、肺癌、乳癌。\n• 成骨性 (Osteoblastic)：前列腺癌、乳癌。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("1. 脊椎血管瘤 (Hemangioma)"),

          _buildInfoCard(
            "最常見良性原發腫瘤",
            "• 族群：年輕女性，胸腰椎最常見。\n"
                "• 影像：CT 側面直條紋，橫斷面 Polka-dot sign。\n"
                "• 症狀：極少數 (<1.2%) 因骨折或出血壓迫神經而有症狀。\n"
                "• 處置：無症狀追蹤；有症狀可 RT、栓塞或椎體成形術 (Vertebroplasty)。",
          ),

          _buildSectionTitle("2. 骨樣骨瘤 vs 骨母細胞瘤"),
          _buildInfoCard(
            "Osteoid osteoma vs Osteoblastoma",
            "組織學相同，以大小 1 cm 為界。\n"
                "• Osteoid osteoma：≤ 1 cm。\n"
                "• Osteoblastoma：> 1 cm，常侵犯椎管。\n"
                "• 處置：放射線治療無效！唯一有效為「完全切除」。",
          ),

          _buildSectionTitle("3. 脊椎骨肉瘤 (Osteosarcoma)"),
          _buildAlertCard("最常見原發惡性骨瘤", "好發 40 歲男性腰骶骨。預後極差，中位存活僅約 10 個月。"),
        ],
      ),
    );
  }

  // --- Tab 2: 脊膜內－脊髓外 (Intradural-Extramedullary) ---
  Widget _buildIntraduralExtramedullaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 腦膜瘤 (Meningioma)"),

          _buildInfoCard(
            "臨床特徵與影像",
            "• 族群：40-70 歲，女性多於男性 (4:1)。\n"
                "• 位置：胸椎絕對多數 (胸82% : 頸15% : 腰2%)。\n"
                "• 影像：MRI 呈現 Dural tail sign。\n"
                "• 處置：手術完全切除，復發率不高。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 神經鞘瘤 (Schwannoma)"),
          _buildInfoCard(
            "臨床特徵與影像",
            "• 機轉：75% 源自背側感覺神經根 (Dorsal sensory rootlets)。\n"
                "• 症狀：初期以感覺神經根症狀為主。\n"
                "• 關聯：部分伴隨神經纖維瘤病 (NF2)，此類復發率較高。\n"
                "• 處置：手術完全切除。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 脊髓內 (Intramedullary) ---
  Widget _buildIntramedullaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 室管膜瘤 (Ependymoma)"),
          _buildInfoCard(
            "臨床特徵 (佔髓內 30%)",
            "• 位置：多位於低位脊髓，>50% 在終端纖維 (Myxopapillary type)。\n"
                "• 影像：MRI 顯影明顯，常伴隨囊腫 (Cyst) 與出血。\n"
                "• 注意：可能伴隨 CSF 散播，必須全脊椎 MRI 檢查！\n"
                "• 處置：目標為完全切除。術前神經功能決定預後。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 星狀細胞瘤 (Astrocytoma)"),
          _buildInfoCard(
            "臨床特徵",
            "• 族群：30-50 歲，男性略多，胸椎最常見。\n"
                "• 分級：Low-grade 多於 High-grade (3:1)。\n"
                "• 手術挑戰：與正常脊髓邊界不清，極少能完全切除。\n"
                "• 輔助治療：High-grade 者術後需 RT + 化療。",
          ),

          const SizedBox(height: 16),
          _buildAlertCard(
            "💡 預後關鍵 (Prognosis)",
            "脊髓內腫瘤的手術預後，高度取決於「術前的神經功能狀態」。越早診斷並在神經嚴重受損前手術，恢復機會越大。",
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
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
      margin: const EdgeInsets.only(bottom: 12),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
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
      color: Colors.red.shade50,
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
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
