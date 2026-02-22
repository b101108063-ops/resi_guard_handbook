import 'package:flutter/material.dart';

class Ch33_3AVMTile extends StatelessWidget {
  const Ch33_3AVMTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.hub_outlined,
        color: Colors.redAccent,
      ), // 象徵血管團/網狀結構
      title: const Text("動靜脈畸形與血管病灶 (AVM)"),
      subtitle: const Text("血流竊取、Spetzler-Martin 分級、海綿狀血管瘤"),
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
                labelColor: Colors.redAccent,
                indicatorColor: Colors.redAccent,
                isScrollable: true,
                tabs: [
                  Tab(text: "病理與症狀"),
                  Tab(text: "分級評估"),
                  Tab(text: "治療策略"),
                  Tab(text: "其他畸形"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildGradingTab(),
                    _buildTreatmentTab(),
                    _buildOthersTab(),
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

  // --- Tab 1: 病理與症狀 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("核心血行動力學"),

          const Text(
            "• 低阻力通道：高壓動脈血直接灌入靜脈，形成畸形血管巢 (Nidus)。\n• 竊血現象 (Steal phenomenon)：血流偏向 AVM，導致周邊正常腦組織輕度缺氧。\n• 血管新生：缺氧刺激 VEGF/bEGF，使 AVM 出生後仍可能變大。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("臨床表現 (大小的反比悖論)"),
          _buildAlertCard(
            "出血 (Hemorrhage, 53%)",
            "⚠️ 小型 AVM 較容易出血！(因內部血管壓力較高)。\n初次出血死亡率 10%，後續高達 20%。",
          ),
          _buildInfoCard("癲癇 (Seizure, 46%)", "大型 AVM 較容易引發癲癇。"),
          _buildInfoCard(
            "神經缺損與伴隨病灶",
            "• 漸進性缺損 (21%)：源自實體壓迫或竊血缺氧。\n• 伴隨動脈瘤 (7.6%)：常位於供血動脈 (Feeding artery) 上。",
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 評估與分級 ---
  Widget _buildGradingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("影像學診斷"),
          const Text(
            "• CT/CTA：急診懷疑出血首選。\n• MRI/fMRI：評估病灶與功能區 (Eloquent area) 關係首選。\n• 傳統血管攝影 (Angiography)：確診 AV shunting 的黃金標準！",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("Spetzler-Martin 分級系統"),

          const Text(
            "決定手術風險與預後的最重要工具 (總分 1-5 分)：",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            "1. 大小 (Size)",
            "< 3 cm (1分)\n3-6 cm (2分)\n> 6 cm (3分)",
          ),
          _buildInfoCard(
            "2. 位置 (Location)",
            "非重要功能區 (0分)\n重要功能區 (Eloquent area) (1分)",
          ),
          _buildInfoCard(
            "3. 靜脈引流 (Venous drainage)",
            "僅表淺引流 (0分)\n包含深部引流 (1分)",
          ),
          const SizedBox(height: 8),
          const Text(
            "💡 補充：Grade 3 最具爭議，常需加入 Lawton 補充量表 (年齡、破裂與否、彌漫性) 優化決策。",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 治療策略 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("總原則"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "絕對目標是「完全阻斷 AV shunting」。部分阻斷會改變內部壓力梯度，反而增加出血率！",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("治療模式"),
          _buildInfoCard(
            "1. 顯微開顱手術 (Craniotomy)",
            "• 適應症：Grade 1-3 及部分 Grade 4。\n"
                "• ⚠️ 致命併發症：正常灌流壓突破出血 (NPPB)。切除後周邊低壓血管突遭高壓血流灌入，導致急性腦水腫或出血。",
          ),
          _buildInfoCard(
            "2. 血管內栓塞 (Embolization)",
            "• 適應症：術前/放療前輔助，減少失血與體積。\n"
                "• 缺點：單獨用於大型病灶易發生血管再通 (Recanalization)。",
          ),
          _buildInfoCard(
            "3. 立體定位放射 (SRS)",
            "• 適應症：< 3 cm 或深部無法手術者。\n"
                "• 缺點：需 2 年才能完全阻斷，空窗期仍會出血！可能造成放射性腦壞死。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("伴隨動脈瘤處理"),
          const Text(
            "若動脈瘤 > 5 mm 或位於供血動脈上，必須在治療 AVM「之前」先處理動脈瘤！",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 其他血管畸形 ---
  Widget _buildOthersTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 海綿狀血管瘤 (Cavernoma)"),

          _buildInfoCard(
            "微血管擴張",
            "• 特徵：管壁薄、血流滯留。內部無正常神經組織交錯。\n"
                "• 影像：MRI T2 呈現典型「血鐵質沉積環 (Hemosiderin ring)」。\n"
                "• 治療：若引發癲癇/出血，手術切除可根治。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 靜脈血管瘤 (DVA)"),

          _buildAlertCard(
            "⚠️ 絕對不可切除 (Surgical Pearl)",
            "• 影像：典型「水母頭 (Caput medusae)」輻射狀排列。\n"
                "• 機轉：此為正常腦組織的靜脈回流變異！若切除會導致嚴重靜脈性腦梗塞。\n"
                "• 處置：若伴隨 Cavernoma 需手術，僅可切除 Cavernoma，必須保留 DVA。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("3. 毛細血管擴張症 (Capillary Telangiectasia)"),
          const Text("微血管囊狀擴張，血管間交錯正常腦組織。幾乎完全無症狀，不需任何治療。"),
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
          color: Colors.redAccent,
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
            ),
          ],
        ),
      ),
    );
  }
}
