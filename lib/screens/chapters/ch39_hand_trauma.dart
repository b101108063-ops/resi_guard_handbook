import 'package:flutter/material.dart';

class Ch39HandTraumaTile extends StatelessWidget {
  const Ch39HandTraumaTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.back_hand, color: Colors.teal), // 象徵手外科
      title: const Text("手外傷與重建 (Hand Trauma)"),
      subtitle: const Text("黃金時限、組織修補、掌側感染、先天畸形"),
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
                labelColor: Colors.teal,
                indicatorColor: Colors.teal,
                isScrollable: true,
                tabs: [
                  Tab(text: "急救保存"),
                  Tab(text: "組織損傷"),
                  Tab(text: "常見疾病"),
                  Tab(text: "術後與畸形"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildEmergencyTab(),
                    _buildTissueInjuryTab(),
                    _buildCommonDiseaseTab(),
                    _buildReconstructionTab(),
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

  // --- Tab 1: 創傷急救與初步處置 (Emergency Management) ---
  Widget _buildEmergencyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("⏳ 治療黃金時限"),
          _buildAlertCard(
            "手外傷與斷肢再植時效",
            "• 一般手外傷：冬季應在 8 小時內，夏季在 6 小時內處理。\n"
                "• 斷肢/斷指再植：時限更短於 5 小時！必須爭分奪秒。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("止血與固定原則"),
          _buildInfoCard(
            "1. 止血處置",
            "• 首選：創口加壓包紮最有效。\n• 止血帶要點：選用布帶、皮帶或膠皮管，絕對不可用鐵線或金屬電線！\n• 綑紮位置：必須在上臂下段（綁在前臂無效），且每小時必須放鬆 10 分鐘。",
          ),
          _buildInfoCard(
            "2. 肢體固定",
            "• 常合倂骨折，轉運前須以木板或硬紙板托在前臂屈側並綑綁。\n🚨 警告：外露的骨骼斷端絕對不要復位！避免將汙染源帶入深層組織。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("斷肢/斷指保存 (Amputation Preservation)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "正確做法：乾淨手帕/紙張包裹 ➡️ 放入不透水塑膠袋 ➡️ 外層用碎冰覆蓋低溫冷藏。\n"
              "❌ 絕對禁忌：不可低於 0 度造成凍傷，也不可將斷肢浸泡於任何液體中！",
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 特定組織損傷之學理與處置 (Tissue-Specific Injuries) ---
  Widget _buildTissueInjuryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("屈指肌腱損傷 (Flexor Tendon)"),
          _buildInfoCard(
            "學理與術後復健",
            "• 分深、淺兩組，由腱圍/腱周組織 (Paratenon) 包繞提供營養與滑動。\n"
                "• 處置：乾淨利器傷立即接合；破碎感染傷口則待癒合後二期肌腱移植。\n"
                "• 復健核心：肌腱極易沾黏！術後數天內即需穿戴特殊支架，進行「早期限制性運動」，防止手部僵硬。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("手部神經與血管損傷"),
          _buildInfoCard(
            "神經修補 (正中、尺、橈神經)",
            "盡量以顯微手術接合，缺損則取自體神經 (如腳部) 移植。\n⚠️ 與肌腱相反：神經修補術後不需要立即運動，必須「固定約一個月」。",
          ),
          _buildInfoCard(
            "血管損傷與代償能力",
            "手部由橈動脈與尺動脈形成豐富的動脈網/動脈弓，側支循環極佳。即使尺、橈動脈完全斷裂，手的存活率仍可達約 1/3。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("全手壓碎傷 (Crush Injuries)"),
          _buildAlertCard(
            "保留組織原則",
            "盡量保留所有組織，即使歪斜也應留存供日後重建。可使用藥物挽救瀕死組織，穩定後再以皮瓣覆蓋及分期手術改善功能。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 常見手外科疾病學理與診斷 (Common Hand Diseases) ---
  Widget _buildCommonDiseaseTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("掌側化膿性感染 (Palmar Space Infections)"),
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
                  "解剖學理特徵 - 為什麼極危險？",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "手掌皮膚厚、皮下有緻密的垂直纖維束連接真皮與骨膜/腱鞘，將皮下組織分隔成「密閉小腔」。\n"
                  "一旦發生金黃色葡萄球菌感染，發炎難向四周擴散，常「向深部蔓延」引起化膿性腱鞘炎、指頭炎 (Felon) 或深間隙感染。\n"
                  "👉 臨床處置：必須積極切開引流 (I&D)！",
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("滑雪拇指 (Skier's Thumb / UCL Injury)"),
          _buildInfoCard(
            "韌帶損傷學理",
            "拇指掌指關節 (MCP joint) 尺側側副韌帶 (UCL) 損傷。該韌帶負責維持被動穩定性，受傷後會導致拇指對指力與精細捏力喪失。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("月骨與月骨周圍脫位 (Lunate Dislocation)"),
          _buildInfoCard(
            "臨床鑑別診斷",
            "• 月骨脫位 (Lunate Dislocation)：月骨本身脫離橈骨及其他腕骨的位置。\n"
                "• 月骨周圍脫位 (Perilunate Dislocation)：月骨與橈骨關係保持正常，是周圍其他腕骨發生脫位 (常合併舟狀骨骨折)。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 術後照護與先天畸形 (Post-op & Reconstruction) ---
  Widget _buildReconstructionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("手腕骨折與韌帶拉傷禁忌"),
          _buildAlertCard(
            "🚨 絕對禁忌：切忌盲目推拿/按摩",
            "手腕由八塊骨頭與複雜韌帶組成。受傷初期或症狀未明時不當推拿，會使韌帶撕裂加劇、軟骨磨損，甚至引發外傷性關節炎致骨頭融合（整隻手廢掉）。\n"
                "正確照護：前 4-5 天冰敷，之後熱敷消腫，並以繃帶或石膏固定。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("神經病變與疤痕攣縮"),
          _buildInfoCard(
            "尺神經病變與手部萎縮",
            "肘部或腕部壓迫尺神經會導致手掌肌肉萎縮與麻木。手術需鬆解神經並清除疤痕，但神經恢復極慢，通常需半年以上萎縮才漸漸改善。",
          ),
          _buildInfoCard(
            "疤痕攣縮處理 (Scar Contracture)",
            "三度燒傷或嚴重外傷後的疤痕攣縮會使深層神經血管縮短、關節變形。應及早進行分期手術放開攣縮，必要時行全層植皮或皮瓣覆蓋。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("先天畸形與類風濕關節炎 (Surgical Pearls)"),
          _buildInfoCard(
            "先天性併指症 (Syndactyly) 手術時機",
            "• 最佳時機：1 歲至 1 歲半。此時孩童能理解基本指令防亂動抓壞傷口，且能在手部發展精細動作前完成重建。\n"
                "• 特殊狀況：若為「指尖相連」，因生長速度不一會互相干擾，必須「儘早」先執行指尖分開術。",
          ),

          _buildInfoCard(
            "手部類風濕關節炎 (RA) 跨科評估",
            "• 急性期：藥物無效時，及早手術清除發炎中的滑膜組織，可大幅降低後期畸形機率。\n"
                "• ⚠️ 跨科核心考量：若患者下肢也有嚴重 RA 需依賴拐杖行走，必須「先進行下肢重建」，待不需拐杖後再開手部。否則術後拿拐杖的重力會直接摧毀剛重建好的手部結構！",
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
          color: Colors.teal,
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
