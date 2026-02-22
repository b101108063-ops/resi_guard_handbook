import 'package:flutter/material.dart';

class Ch37_1EpilepsyTile extends StatelessWidget {
  const Ch37_1EpilepsyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bolt, color: Colors.orangeAccent), // 象徵神經不正常放電
      title: const Text("癲癇 (Epilepsy)"),
      subtitle: const Text("AEDs 原則、癲癇重積狀態(SE)急救流程"),
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
                labelColor: Colors.orange,
                indicatorColor: Colors.orange,
                isScrollable: true,
                tabs: [
                  Tab(text: "學理分類"),
                  Tab(text: "藥物(AEDs)"),
                  Tab(text: "🚨 重積狀態(SE)"),
                  Tab(text: "發作急救"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildMedsTab(),
                    _buildStatusEpilepticusTab(),
                    _buildFirstAidTab(),
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

  // --- Tab 1: 學理與分類 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("定義 (Definition)"),
          const Text(
            "• 發作 (Seizure)：神經元突然不受控制地放電，產生短暫身體表現。\n• 癲癇 (Epilepsy)：反覆發生「無端 (unprovoked)」發作的慢性腦部疾病。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("發作四階段"),
          _buildBulletPoint("1. 前驅 (Prodromal)：發作前數分鐘至數天 (頭痛、易怒)。"),
          _buildBulletPoint("2. 先兆 (Aura)：意識喪失前幾秒至幾分鐘的局部徵象 (如怪味)。"),
          _buildBulletPoint("3. 發作期 (Ictal)：實際發作階段，患者通常無記憶。"),
          _buildBulletPoint("4. 發作後 (Postictal)：深度睡眠、混亂、暫時無力，可持續數天。"),

          const Divider(height: 24),
          _buildSectionTitle("ILAE 發作分類"),

          _buildInfoCard("局部發作 (Focal)", "起源於單一半球。可擴散至雙側並伴隨意識喪失。"),
          _buildInfoCard(
            "全面發作 (Generalized)",
            "起源於雙側，通常伴隨意識喪失。\n- 強直陣攣 (Tonic-clonic)：典型大發作 (僵硬+抽搐)。\n- 失神 (Absence)：兒童好發，短暫茫然凝視。\n- 肌陣攣 (Myoclonic) / 失張力型 (Atonic, 易摔倒)。",
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 藥物治療原則 (AEDs) ---
  Widget _buildMedsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("治療時機與原則"),
          const Text(
            "• 時機：確診活動性癲癇 (1年內發生 ≥ 2次無端發作，間隔 > 24小時)。\n• 原則：單一療法優先！達最大劑量無效才加第二種藥物。",
            style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("常見抗癲癇藥物 (AEDs) 特性"),
          _buildInfoCard(
            "Phenytoin (迪芬內妥)",
            "局部及強直陣攣發作有效。\n⚠️ 注意：安全邊際窄 (Narrow window)。副作用含嗜睡、牙齦肥大。",
          ),
          _buildInfoCard(
            "Carbamazepine (癲通)",
            "局部及強直陣攣發作有效。\n🚨 絕對注意：使用前必查 HLA-B*1502 基因，防致命史蒂芬強森症候群 (SJS)！",
          ),
          _buildInfoCard(
            "Sodium Valproate (帝拔癲)",
            "全面性發作第一線。\n⚠️ 禁忌：孕婦禁用 (具致畸胎性如脊柱裂)。",
          ),
          _buildInfoCard("Phenobarbitone (苯巴比妥)", "最古老，半衰期極長，用於特發性全身型癲癇。"),
        ],
      ),
    );
  }

  // --- Tab 3: 外科急症：癲癇重積狀態 (SE) ---
  Widget _buildStatusEpilepticusTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAlertCard(
            "🚨 定義 (Status Epilepticus)",
            "抽搐發作持續 > 5 分鐘，或發生 ≥ 2次發作且期間意識未恢復基準。高死亡率急症！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("SE 急救處置流程 (Treatment Algorithm)"),
          _buildTimelineCard(
            "Step 1: 穩定生命徵象 (0-5 min)",
            "維持 ABC (Airway, Breathing, Circulation)。抽血驗電解質、血糖、ABG。",
          ),
          _buildTimelineCard(
            "Step 2: 排除低血糖",
            "若懷疑低血糖，給予 10% 葡萄糖液 + 維他命 B1 (Thiamine)。",
          ),

          const SizedBox(height: 8),
          _buildTimelineCard(
            "Step 3: 第一線終止發作 (5-20 min)",
            "給予 BZD：Diazepam (Valium) 或 Lorazepam (Ativan) IV。",
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red.shade50, // 無 const
            child: Text(
              "⚠️ 絕對禁忌：不可 IM (肌肉注射) Diazepam，吸收不可預期且易致呼吸窘迫！",
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ), // 無 const
          ),

          const SizedBox(height: 8),
          _buildTimelineCard(
            "Step 4: 第二線藥物 (20-40 min)",
            "若持續發作：Phenytoin 15-18 mg/kg IV Loading (速率 < 50 mg/min)。",
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red.shade50, // 無 const
            child: Text(
              "🚨 致命地雷：絕對不可與 Dextrose (含糖輸液) 混合，會產生沉澱！只能用 Normal Saline 稀釋。",
              style: TextStyle(
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ), // 無 const
          ),

          const SizedBox(height: 8),
          _buildTimelineCard(
            "Step 5: 第三線藥物 (40-60 min)",
            "Phenobarbitone 15 mg/kg IV Loading。密切監測呼吸血壓。",
          ),
          _buildTimelineCard(
            "Step 6: 頑固性重積狀態",
            "插管、機械通氣。使用 Midazolam 或 Thiopental 進入全身麻醉誘導昏迷。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 發作時急救 (First Aid) ---
  Widget _buildFirstAidTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("發作急救原則"),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "✅ 應該做 (Do's)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 6),
                Text("1. 保護頭部 (墊軟物)。"),
                Text("2. 將病人側翻 (復甦姿勢)，讓口水/嘔吐物流出，防嗆入氣管。"),
                Text("3. 移除周邊危險、尖銳物品。"),
                Text("4. 在旁陪伴直到意識完全恢復。"),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ), // 無 const
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "❌ 絕對不要做 (Don'ts)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                    fontSize: 16,
                  ),
                ), // 無 const
                const SizedBox(height: 6),
                const Text(
                  "1. 絕對不要把任何東西 (如毛巾、湯匙、手指) 塞入病人嘴裡！(不會咬斷舌頭，但會塞斷牙齒或窒息)",
                ),
                const Text("2. 不要試圖用力壓制或限制病人的抽搐動作 (易造成骨折)。"),
                const Text("3. 發作尚未完全清醒前，不要餵食飲料或藥物。"),
              ],
            ),
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
          color: Colors.orange,
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
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
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

  Widget _buildTimelineCard(String step, String desc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(6),
      ), // 無 const
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ), // 無 const
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
