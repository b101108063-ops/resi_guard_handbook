import 'package:flutter/material.dart';

class Ch33_1ICHTile extends StatelessWidget {
  const Ch33_1ICHTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bloodtype, color: Colors.redAccent),
      title: const Text("出血性腦中風 (ICH)"),
      subtitle: const Text("病因機轉、血腫計算、小腦出血急症"),
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
                  Tab(text: "病因"),
                  Tab(text: "評估定位"),
                  Tab(text: "內科控制"),
                  Tab(text: "外科處置"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildEtiologyTab(),
                    _buildEvaluationTab(),
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

  // --- Tab 1: 病因與機轉 ---
  Widget _buildEtiologyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 高血壓性腦出血 (50%)"),
          const Text(
            "• 機轉：長期高血壓破壞無分支穿通動脈，形成微動脈瘤 (Charcot-Bouchard microaneurysm)。\n• 位置：殼核 (Putamen)、丘腦 (Thalamus)、小腦、橋腦。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 大腦類澱粉血管病變 (CAA)"),

          const Text(
            "• 族群：大於 70 歲老年人。\n• 特徵：反覆發生大葉性出血 (Lobar hemorrhage)。\n• 染色：偏光顯微鏡下剛果紅染色呈蘋果綠色雙折射光。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("3. 其他危險因子"),
          _buildInfoCard("抗凝血藥物", "風險增加 8-11 倍。血腫大且持續變大，死亡率高達 60-65%。"),
          _buildInfoCard("藥物濫用", "安非他命/古柯鹼。年輕人多見大葉性出血，常合併 AVM 或動脈瘤。"),
        ],
      ),
    );
  }

  // --- Tab 2: 評估與定位 ---
  Widget _buildEvaluationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("血腫擴大與水腫"),

          _buildAlertCard(
            "Spot Sign (斑點徵象)",
            "血腫通常在 3-6 小時內擴大。若 CTA 顯示 Spot sign 或 CT 密度不均，為血腫擴大高風險指標。",
          ),
          const Text(
            "• 周邊水腫：高峰在第 2 天及第 2-3 週。",
            style: TextStyle(height: 1.5, color: Colors.grey),
          ),

          const Divider(height: 24),
          _buildSectionTitle("影像血腫體積計算"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "公式：V = A × B × C / 2\n(A, B, C 為血腫在三個垂直面向的直徑)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("臨床特殊定位症狀"),
          _buildInfoCard(
            "橋腦 (Pons)",
            "Pinpoint reactive pupils (針點狀但有對光反應)。單側受損可能呈「一個半症候群」。",
          ),
          _buildInfoCard("丘腦 (Thalamus)", "對側感覺缺失、眼睛歪斜、無法上視。"),
          _buildInfoCard("大葉性 (Lobar)", "較易伴隨癲癇 (Seizure)，但存活率與神經預後較佳。"),
        ],
      ),
    );
  }

  // --- Tab 3: 內科控制 ---
  Widget _buildMedicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("血壓控制 (BP Control)"),
          _buildInfoCard(
            "目標：SBP < 140 mmHg",
            "依據 ATACH 與 INTERACT 試驗，急性期降壓安全且能防血腫擴大。\n⚠️ 若初診 SBP > 220 mmHg 需積極控制，但防降太低導致腦灌流不足。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("顱內壓控制 (ICP Control)"),
          const Text(
            "目標：ICP < 20 mmHg, CPP > 70 mmHg",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoCard("滲透壓療法", "首選 Mannitol，必要時合併利尿劑或使用高張食鹽水。"),
          _buildInfoCard("過度換氣", "目標 PaCO2 30-35 mmHg。為暫時性救援，CSF 酸鹼平衡後即失效。"),
          _buildInfoCard(
            "救援療法",
            "困難控制的 IICP 可考慮巴比妥 (Barbiturate coma) 或低溫療法 (32-35°C)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("癲癇預防"),
          const Text("大葉性出血發生率約 1.4-17%，可考慮預防性給予抗癲癇藥物一個月。"),
        ],
      ),
    );
  }

  // --- Tab 4: 外科處置 ---
  Widget _buildSurgicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("絕對手術適應症"),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "🚨 小腦出血 (Cerebellar Hemorrhage)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "符合以下任一條件需緊急手術清除血腫：",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("1. 血腫 > 3 公分"),
                Text("2. 合併阻塞性水腦症"),
                Text("3. 第四腦室出血"),
                SizedBox(height: 8),
                Text(
                  "即使陷入昏迷，在 2 小時內手術仍能有效逆轉神經損傷！",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ],
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("手術方式選擇"),
          _buildInfoCard(
            "開顱手術 (Craniotomy)",
            "選擇距離血塊最近且避開大腦重要皮層 (eloquent areas) 的路徑。",
          ),
          _buildInfoCard(
            "顱骨穿洞抽吸 (Burr hole)",
            "立體定位精準抽吸。為防再出血 (率 7.4%)，通常在出血 6 小時後進行。可搭配局部注射血栓溶解劑 (rt-PA) 液化血塊。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("ICP 監測"),
          const Text("對於昏迷的腦出血病患，置放 ICP monitor 可引導藥物治療並精確決定手術時機，降低死亡率。"),
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
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          content,
          style: const TextStyle(fontSize: 13, height: 1.4),
        ),
        dense: true,
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
            color: Colors.redAccent,
          ),
        ),
        subtitle: Text(
          content,
          style: TextStyle(
            fontSize: 13,
            height: 1.4,
            color: Colors.red.shade900,
          ),
        ),
        dense: true,
      ),
    );
  }
}
