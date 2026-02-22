import 'package:flutter/material.dart';

class Ch36SstiTile extends StatelessWidget {
  const Ch36SstiTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.healing, color: Colors.deepOrange), // 象徵傷口與皮膚感染
      title: const Text("皮膚軟組織感染 (SSTI)"),
      subtitle: const Text("敗血症、蜂窩組織炎、壞死性筋膜炎急症"),
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
                labelColor: Colors.deepOrange,
                indicatorColor: Colors.deepOrange,
                isScrollable: true,
                tabs: [
                  Tab(text: "敗血症"),
                  Tab(text: "一般感染"),
                  Tab(text: "🚨 壞死急症"),
                  Tab(text: "清創與用藥"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildSepsisTab(),
                    _buildCommonInfectionTab(),
                    _buildNecrotizingTab(),
                    _buildSurgMedTab(),
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

  // --- Tab 1: 敗血症與初步評估 ---
  Widget _buildSepsisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("敗血症 (Sepsis) 核心"),
          const Text(
            "無法控制的全身性發炎反應 (SIRS)，常伴隨促凝血特異體質，嚴重致多重器官衰竭。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("黃金標準：血液培養 (Blood Culture)"),
          _buildInfoCard(
            "採集原則",
            "只要懷疑血流感染，應在寒顫或發燒時，立即採集「三套」血液培養 (偵測率可達 99%)，以區分真正病原菌與皮膚汙染。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("治療四大基石"),
          _buildBulletPoint("1. 積極支持療法：大量輸液與升壓劑維持生命徵象。"),
          _buildBulletPoint("2. 抗生素治療：給藥前盡可能先完成血液培養。"),
          _buildBulletPoint("3. 感染源控制 (外科核心)：切開引流 (I&D)、移除植入物或異物。"),
          _buildBulletPoint("4. 潛在疾病治療：控制基本疾病 (如糖尿病)。"),
        ],
      ),
    );
  }

  // --- Tab 2: 一般皮膚與軟組織感染 ---
  Widget _buildCommonInfectionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("蜂窩性組織炎 (Cellulitis) - 非膿性"),

          const Text(
            "• 致病菌：Beta-溶血性鏈球菌與 MSSA。\n• 首選抗生素：IV Cefazolin 或 PO Cephalexin。\n• 療程：一般 5 天；嚴重/免疫抑制者 14 天。",
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 8),
          _buildInfoCard(
            "何時需涵蓋 MRSA？",
            "出現全身系統性症狀 (T > 38°C、低血壓)、具 MRSA 病史、近期住院/洗腎/長照機構、病灶鄰近人工植入物。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("丹毒 (Erysipelas)"),
          const Text(
            "以 Beta-溶血性鏈球菌為主。合併發燒給予 IV Cefazolin/Ceftriaxone。若對 Beta-lactam 過敏可改用 Clindamycin 或 Linezolid。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("膿性感染 (Purulent Infection)"),

          _buildAlertCard("外科絕對原則", "切開引流 (I&D) 是首要且絕對必要的措施！單純給抗生素無效。"),
          const Text(
            "💡 合併抗生素適應症：膿瘍 > 2cm、多發病灶、全身毒性表徵、具心內膜炎高風險者。",
            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 外科急症：壞死性筋膜炎 (極重要) ---
  Widget _buildNecrotizingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAlertCard(
            "🚨 致命急症 (Necrotizing Fasciitis)",
            "進展極快，早期清創是挽救生命與肢體的唯一途徑！糖尿病為最重要危險因子。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("臨床警戒訊號 (Red Flags)"),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Pain out of proportion (不成比例的劇痛)！",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const Text("痛覺極度劇烈，遠超過表面紅腫程度。"),
                const SizedBox(height: 8),
                Text(
                  "2. 膚色改變與水泡",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const Text("皮膚閃亮，幾天內從紅紫轉藍灰，並產生水泡與壞疽。"),
                const SizedBox(height: 8),
                Text(
                  "3. 劇痛轉為「無痛」",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const Text("表淺神經被破壞死亡後，病灶會突然不再疼痛。"),
                const SizedBox(height: 8),
                Text(
                  "4. 皮下氣體 (Crepitus)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const Text("常見於糖尿病患之多菌株感染 (Type I)。"),
              ],
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("致病菌分類"),
          _buildInfoCard("Type I (多菌株)", "厭氧菌合併腸桿菌。如會陰部 Fournier's gangrene。"),
          _buildInfoCard(
            "Type II (單一菌株)",
            "A型鏈球菌 (GAS)。海水創傷: Vibrio vulnificus；淡水: Aeromonas。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 外科清創與抗生素策略 ---
  Widget _buildSurgMedTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("清創原則 (Surgical Pearl)"),

          _buildAlertCard(
            "⚠️ 絕不為等待影像而延誤手術！",
            "臨床懷疑就應立刻進 OR 探查 (唯一確診方法)。若為等 CT/培養而延誤，死亡率逼近 100%！",
          ),
          const Text(
            "• 清創目標：廣泛移除壞死組織，直到看見邊緣有健康、會流血的組織為止。\n• Second look：24 小時後必須重新打開評估，有壞死需再次清創。\n• 重建：感染完全控制後，才進行植皮或皮瓣重建。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("經驗性抗生素組合 (極廣效)"),
          const Text(
            "必須覆蓋 Gram(+), Gram(-), 厭氧菌, GAS 與梭菌：",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildBulletPoint("Carbapenem 或 Pip-Tazo (Tazocin)"),
          _buildBulletPoint("➕ Clindamycin 600-900mg IV (抑制細菌毒素產生！)"),
          _buildBulletPoint("➕ 抗 MRSA：Vancomycin 或 Linezolid"),

          const Divider(height: 24),
          _buildSectionTitle("死亡高風險因子"),
          const Text(
            "WBC > 30,000/microL、Cr > 2.0 mg/dL、梭菌 (Clostridium) 感染、合併心臟疾病。",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
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
          color: Colors.deepOrange,
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
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
