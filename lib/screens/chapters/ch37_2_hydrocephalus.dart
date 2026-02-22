import 'package:flutter/material.dart';

class Ch37_2HydrocephalusTile extends StatelessWidget {
  const Ch37_2HydrocephalusTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.waves, color: Colors.blue), // 象徵腦脊髓液(CSF)
      title: const Text("水腦症 (Hydrocephalus)"),
      subtitle: const Text("Evans' ratio、V-P Shunt、iNPH 三聯徵"),
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
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                isScrollable: true,
                tabs: [
                  Tab(text: "分類學理"),
                  Tab(text: "臨床影像"),
                  Tab(text: "外科術式"),
                  Tab(text: "預後併發"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildClinicalTab(),
                    _buildSurgicalTab(),
                    _buildPrognosisTab(),
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

  // --- Tab 1: 分類與機轉 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("核心學理"),
          const Text(
            "• CSF 正常生產率約 0.33 毫升/分鐘。\n• 水腦症並非單一疾病，而是 CSF 在腦室中異常積累的「病症」。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("依阻塞機轉分類"),

          _buildInfoCard(
            "阻塞型 / 非交通型 (Obstructive)",
            "CSF 引流路徑受到實體阻塞 (如腫瘤、先天缺陷、IVH 腦室出血或感染)。",
          ),
          _buildInfoCard(
            "交通型 (Communicating)",
            "路徑未阻塞，但 CSF 「吸收不良」。常見於腦膜炎、SAH 後，或脈絡叢乳頭瘤 (生產過多)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("特發性常壓性水腦症 (iNPH)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "典型三聯徵 (Classic Triad) - 必考：",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text("1. 步態障礙 (磁性步態 Magnetic gait)"),
                Text("2. 失智症 (Dementia)"),
                Text("3. 尿失禁 (Urinary incontinence)"),
                SizedBox(height: 8),
                Text(
                  "※ 多發於老年人，腦室變大但顱內壓很少增加。需與阿茲海默/帕金森氏症鑑別。",
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 臨床表現與影像診斷 ---
  Widget _buildClinicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("臨床表徵"),
          _buildInfoCard("急性水腦症", "典型 IICP 徵象：頭痛、嘔吐、意識變化、視乳突水腫、目光上望麻痺 (日落眼)。"),
          _buildInfoCard(
            "嬰兒/兒童慢性期",
            "嬰兒：最關鍵指標為「頭圍擴大/囪門隆起」(因骨縫未閉合)。\n兒童：易怒、Macewen徵象、日落眼、Parinaud症候群。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("影像學標準 (CT/MRI)"),

          _buildBulletPoint("Evans' ratio (伊凡氏比值) > 0.3。 (極重要指標)"),
          _buildBulletPoint("側腦室前角膨脹：呈現典型的「米老鼠 (Mickey Mouse)」形狀。"),
          _buildBulletPoint("側腦室顳角變寬 (≥ 2 mm)。"),
          _buildBulletPoint("第三腦室變寬。"),
          _buildBulletPoint(
            "腦室周邊 CSF 滲透：影像呈現前顳角周圍低密度 (Periventricular lucency)。",
          ),
          _buildBulletPoint("顱頂處腦溝過於緊密 (Sulcal effacement)。"),
        ],
      ),
    );
  }

  // --- Tab 3: 外科處置與術式 ---
  Widget _buildSurgicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("急性處置"),
          _buildInfoCard("腦室外引流管 (EVD)", "緊急降低 IICP，同時處理基礎病理問題 (清除血腫/控制感染)。"),

          const Divider(height: 24),
          _buildSectionTitle("慢性期：腦脊髓液分流手術 (Shunting)"),

          const Text("標準治療，將引流管置於側腦室，搭配壓力控制閥門：", style: TextStyle(height: 1.5)),
          const SizedBox(height: 8),
          _buildBulletPoint("V-P Shunt (腦室腹腔引流)：臨床最常見。"),
          _buildBulletPoint("V-Pleural Shunt (心室胸膜引流)"),
          _buildBulletPoint("V-A Shunt (心房引流)"),
          _buildBulletPoint("L-P Shunt (腰椎腹腔引流)：交通型水腦短期選擇。"),

          const Divider(height: 24),
          _buildSectionTitle("內視鏡第三腦室造口術 (ETV)"),

          _buildAlertCard(
            "適應症與限制",
            "• 適應症：阻塞型水腦的替代療法 (不需植入外來管路)。刺穿第三腦室底部讓 CSF 流出。\n"
                "• 限制：新生兒及 3 個月以下嬰兒存活率極低 (通常不執行)！6 個月左右成功率才達 64%。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 術後照護與預後 ---
  Widget _buildPrognosisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("引流管 (Shunt) 併發症"),
          _buildInfoCard(
            "高失敗率與感染",
            "• 死亡率雖 < 5%，但「引流失敗率約 20%」(過度引流、阻塞或導管折疊)。\n"
                "• 感染率 5-15% (使用抗生素浸潤導管可大幅降低)。\n"
                "• 警覺：若引流管塌陷或堵塞，IICP 症狀會再次出現，延遲診斷可能致命！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("ETV 手術併發症"),
          _buildBulletPoint("下視丘損傷 / 腦垂體柄損傷。"),
          _buildBulletPoint("第 3 及 第 6 對腦神經暫時性麻痺。"),
          _buildBulletPoint("動脈損傷出血、心跳停止。"),
          _buildBulletPoint("造口再次阻塞。"),

          const Divider(height: 24),
          _buildSectionTitle("兒童長期預後"),
          const Text(
            "• 需終身追蹤 (每年神經科回診)。\n• 可能面臨發育障礙、運動/視覺功能下降。\n• 約 30% 合併癲癇發作，此類患者預後最差，智商低於 90 的機率更高。",
            style: TextStyle(height: 1.5),
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
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
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
      color: Colors.red.shade50, // 避開 const
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
            ), // 避開 const
          ],
        ),
      ),
    );
  }
}
