import 'package:flutter/material.dart';

class Ch33_2IschemicStrokeTile extends StatelessWidget {
  const Ch33_2IschemicStrokeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.route, color: Colors.blueAccent), // 象徵血管/血流路徑
      title: const Text("缺血性腦中風 (Ischemic Stroke)"),
      subtitle: const Text("血栓移除(EVT)、容許性高血壓、減壓手術"),
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
                labelColor: Colors.blueAccent,
                indicatorColor: Colors.blueAccent,
                isScrollable: true,
                tabs: [
                  Tab(text: "機轉影像"),
                  Tab(text: "血栓移除"),
                  Tab(text: "內科血壓"),
                  Tab(text: "外科減壓"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildEVTTab(),
                    _buildMedicalTab(),
                    _buildSurgicalTab(),
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

  // --- Tab 1: 機轉與影像 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("血行動力學與 Penumbra"),
          _buildInfoCard(
            "腦灌流 (CBF) 閾值",
            "• 正常：灰質 75-80, 白質 20-30。\n"
                "• 缺血：< 20 cc/100gm/min。\n"
                "• 死亡：< 10 cc/100gm/min。",
          ),
          const Text(
            "💡 治療最高邏輯：盡快恢復血流，拯救周邊依賴側支循環存活的「缺血半月影區 (Penumbra)」。",
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("CT 超急性期徵象 (< 6 小時)"),
          _buildBulletPoint("Hyperdense artery sign (血管中高密度血塊)"),
          _buildBulletPoint("Loss of insular ribbon (島葉腦溝變模糊)"),
          _buildBulletPoint("Loss of gray-white interface (灰白質交界模糊)"),
          _buildBulletPoint("Attenuation of lentiform nucleus (豆狀核變低密度)"),
          const SizedBox(height: 8),
          const Text(
            "※ 腦腫脹最嚴重時期為第 2 到 4 天。",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 血栓溶解與血管內治療 (EVT) ---
  Widget _buildEVTTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 靜脈血栓溶解 (iv rt-PA)"),
          const Text(
            "• 時機：發生 3 到 4.5 小時內。\n• 條件：CT無出血、BP < 185/110 mmHg。\n• 術後：24h內絕對臥床、禁食、禁插 NG/Foley，禁用抗血小板藥物。",
            style: TextStyle(height: 1.5),
          ),

          const SizedBox(height: 12),
          _buildAlertCard(
            "🚨 rt-PA 併發出血急救 (外科重點)",
            "若神經學惡化 (NIHSS ↑ ≥4分)：\n"
                "1. 立即停藥 + 安排 CT。\n"
                "2. 輸注 Cryoprecipitate 10U。\n"
                "3. 給予 Tranexamic acid (TXA) 1000mg IV。\n"
                "4. 急會診神經外科！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 動脈內血栓移除術 (EVT)"),
          _buildInfoCard(
            "大血管阻塞 (LVO) 革命性治療",
            "• < 6 小時：ICA/M1 阻塞, NIHSS ≥ 6, ASPECT ≥ 6。\n"
                "• 6-24 小時：符合 DAWN/DEFUSE 3 試驗 (Clinical/Imaging mismatch 核心小但症狀重)。\n"
                "• 目標血壓：術中及術後 24h 內 BP < 180/105 mmHg。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 內科常規與血壓控制 ---
  Widget _buildMedicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("容許性高血壓 (Permissive HTN)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "為了維持受損腦區的灌流壓 (CPP)，急性期不應隨意降血壓！",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletPoint(
            "除非收縮壓 (SBP) > 220 或 舒張壓 (DBP) > 120 mmHg，才將血壓緩慢下降 15%。",
          ),
          _buildBulletPoint("例外 (需嚴格控制)：合併急性冠心症、心衰竭、主動脈剝離或接受 rt-PA/EVT 者。"),

          const Divider(height: 24),
          _buildSectionTitle("基礎內科維持"),
          const Text(
            "• 點滴：N/S 75-125 cc/hr (避免含醣點滴及過度輸液)。\n• 藥物：Aspirin 或 Plavix。大範圍中風早期「禁用」抗凝血劑。\n• 腦壓：有 mass effect 時可使用 Mannitol。",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 外科減壓手術 (Surgical Management) ---
  Widget _buildSurgicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 小腦中風 (Cerebellar Stroke)"),
          _buildAlertCard(
            "🚨 腦幹壓迫致命風險",
            "• 水腫在 12-96h 內迅速惡化。\n"
                "• 若出現腦幹壓迫徵象 (外展神經麻痺、嗜睡、Babinski sign)，80% 會在幾天內死亡。\n"
                "• 處置：藥物無效時，應積極儘早進行 後顱窩減壓手術 (Suboccipital decompression)。小腦疝脫術後康復機會遠大於大腦！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 惡性中大腦動脈中風 (Malignant MCA)"),
          _buildInfoCard(
            "顱骨切開減壓術 (Decompressive Craniectomy)",
            "• 定義：中風範圍超過 MCA 區域 2/3。\n"
                "• 惡化時程：常在 2-4 天內進展成腦疝脫。早期 CT 可見中線偏移 8-10mm。\n"
                "• 減壓適應症：\n"
                "  1. 18-60 歲的病患。\n"
                "  2. 中風後 48 小時內進行。\n"
                "  3. 非優勢半球 (Non-dominant) 效果最佳。\n"
                "• 預後：死亡率可從 78% 降至 29%，但 >70 歲通常不建議，須與家屬詳談功能預後。",
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
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
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
      color: Colors.red.shade50, // 這裡沒有使用 const
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
            ), // 這裡沒有使用 const 且避開了 shade
            const SizedBox(height: 6),
            // 👇 這裡也拿掉了 TextStyle 前面的 const，確保 safe compile
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
