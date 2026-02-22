import 'package:flutter/material.dart';

class Ch33_4AneurysmTile extends StatelessWidget {
  const Ch33_4AneurysmTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.bubble_chart,
        color: Colors.redAccent,
      ), // 象徵囊狀動脈瘤
      title: const Text("腦動脈瘤與 SAH (Cerebral Aneurysm)"),
      subtitle: const Text("破裂急症、神經定位、血管痙攣(Vasospasm)"),
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
                  Tab(text: "病理定位"),
                  Tab(text: "診斷分級"),
                  Tab(text: "內科/痙攣"),
                  Tab(text: "外科/栓塞"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildDiagTab(),
                    _buildMedicalTab(),
                    _buildSurgTab(),
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

  // --- Tab 1: 病理機轉與神經定位 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("分類與高風險族群"),

          const Text(
            "• 囊狀 (Saccular/Berry)：佔 90%，多在前循環分叉處。\n• 梭形 (Fusiform)：佔 7%，多在後循環，與動脈硬化有關。\n• 感染性 (Mycotic)：佔 0.5%，多源自敗血性栓塞 (MCA遠端)。\n• 高危基因：多囊腎(PCKD)、Marfan、Ehlers-Danlos IV。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("典型破裂症狀 (SAH)"),
          _buildAlertCard(
            "爆炸性雷擊頭痛 (Thunderclap headache)",
            "「這輩子沒這麼痛過！」伴隨頸部僵硬、畏光、意識改變。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("特定解剖定位徵象 (Surgical Pearls)"),
          _buildInfoCard(
            "前交通動脈 (AcoA, 34%)",
            "最常見破裂部位！壓迫視神經交叉致視野缺損；破裂易併發腦室出血 (IVH)。",
          ),
          _buildInfoCard(
            "後交通動脈 (PcoA, 23%)",
            "典型壓迫徵象：瞳孔擴大、動眼神經麻痺 (CN III palsy)、眼瞼下垂。",
          ),
          _buildInfoCard("中大腦動脈 (MCA, 20%)", "失語症、對側偏癱、半側感覺異常。"),
          _buildInfoCard("內頸動脈 (ICA, 4%)", "海綿竇段壓迫引發眼肌麻痺；破裂造成頸動脈-海綿竇廔管 (CCF)。"),
        ],
      ),
    );
  }

  // --- Tab 2: 診斷與分級 ---
  Widget _buildDiagTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("影像學診斷流程"),

          const Text(
            "1. 無顯影 CT：急診首選，可偵測 90-95% SAH。",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "2. 腰椎穿刺 (LP)：若 CT 陰性但高度懷疑，必須做 LP！",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const Text("3. CTA / MRA：快速提供 3D 形態學以利手術規劃。"),
          const Text("4. DSA (傳統血管攝影)：黃金標準！若初次陰性，建議 1-3 週後重做。"),
          const Text("5. 經顱超音波 (TCD)：術後監測血管痙攣 (Day 3-21)。"),

          const Divider(height: 24),
          _buildSectionTitle("嚴重度分級系統"),

          _buildInfoCard("Hunt and Hess Grade", "以「臨床症狀與意識狀態」為主，評估手術風險與整體預後。"),
          _buildInfoCard(
            "Fisher Grade",
            "以「CT 上的出血量與分佈」為主，專門預測發生「血管痙攣 (Vasospasm)」的風險。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 內科控制與血管痙攣 (重點) ---
  Widget _buildMedicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("術前穩定 (Pre-op)"),
          const Text(
            "• 嚴格降壓：使用 Labetalol, Nicardipine 預防再破裂。\n• 腦壓與症狀：止痛、止吐 (防嘔吐致腦壓上升)、軟便、制酸劑。\n• 止血藥：無法立即手術者，SAH 3天內可短暫用 TXA 降再出血率。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("血管痙攣處置 (Vasospasm Management)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "發生高峰：出血後 3-21 天。\n導致遲發性缺血性神經缺損 (DIND)。",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            "Nimodipine (Nimotop)",
            "鈣離子阻斷劑，SAH 發生 96h 內給予，持續 21 天。證實能減少 DIND。",
          ),
          _buildAlertCard(
            "血流動力學療法 (Surgical Pearl)",
            "動脈瘤處理完畢後，不再嚴格降壓！\n"
                "改採 Induced Hypertension (拉高血壓) 搭配 Euvolemia (維持等容積，取代傳統 Hypervolemia 避免心肺衰竭)，以保持腦灌流。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 外科手術與栓塞 ---
  Widget _buildSurgTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("未破裂動脈瘤處置"),
          const Text(
            "• < 10mm 年破裂率極低 (0.05%)。\n• 建議介入條件：< 50歲、後循環、有症狀、抽菸、家族史或 PCKD。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("治療模式比較"),

          _buildInfoCard(
            "顯微開顱夾除 (Clipping)",
            "• 優勢：直視下夾除，阻斷率高，可順便清除血塊減壓。\n"
                "• 早期手術 (48-96h內)：適用狀況佳、血腫大者。可減少血管痙攣。\n"
                "• 延遲手術 (10-14天後)：適用 Hunt & Hess 4-5 分或困難巨大動脈瘤。",
          ),

          _buildInfoCard(
            "血管內栓塞 (Coiling)",
            "• 優勢：微創，短期功能預後較佳，癲癇發生率較低。\n"
                "• 缺點：再出血與後期再治療率較高 (尤其大型動脈瘤)。\n"
                "• 輔助：寬頸動脈瘤可搭配支架 (Stent-assisted)。\n"
                "• Flow-diverter (血流導向裝置)：用於大型，但須吃 DAPT (雙重抗血小板)，增加出血風險。",
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
      color: Colors.red.shade50, // 避開 const 陷阱
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
            ), // 避開 const 陷阱
          ],
        ),
      ),
    );
  }
}
