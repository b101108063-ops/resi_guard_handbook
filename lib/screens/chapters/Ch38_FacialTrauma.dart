import 'package:flutter/material.dart';

class Ch38_FacialTraumaTile extends StatelessWidget {
  const Ch38_FacialTraumaTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.face, color: Colors.teal), // 象徵顏面與外觀重建
      title: const Text("顏面外傷 (Facial Trauma)"),
      subtitle: const Text("ATLS急救、LeFort分類、咬合重建與照護"),
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
                  Tab(text: "急救評估"),
                  Tab(text: "骨折分類"),
                  Tab(text: "手術處置"),
                  Tab(text: "術後照護"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildEmergencyTab(),
                    _buildClassificationTab(),
                    _buildSurgicalTab(),
                    _buildPostOpTab(),
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

  // --- Tab 1: 急救評估 (ATLS & Emergency) ---
  Widget _buildEmergencyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("ATLS 優先原則 (A-B-C)"),
          _buildAlertCard(
            "呼吸道 (Airway) 急症",
            "若因顏面嚴重腫脹導致插管困難，緊急時應果斷施行「環甲膜切開術 (Cricothyroidotomy)」建立呼吸道！\n"
                "待病患病況穩定 (約 24-48 小時) 後，再轉換為常規的氣管切開術 (Tracheostomy)。",
          ),

          const SizedBox(height: 8),
          _buildInfoCard(
            "循環與止血 (Circulation)",
            "頭頸部血循豐富，嚴重骨折常合併大出血。若無法有效止血，應優先考慮安排血管攝影及血管栓塞 (Angiography with embolization) 防止休克。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("軟組織傷害處置"),
          const Text(
            "• 清創與縫合：深層傷口需全身麻醉下清創，並「分層縫合」以消除死腔 (Dead space)，降低感染風險。\n• 深層探查：臉頰撕裂傷必須仔細評估「顏面神經 (Facial nerve)」與「唾液腺管 (Salivary duct)」，損傷需立即顯微修補！",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 顏面骨折分類與學理 ---
  Widget _buildClassificationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("上/中顏面骨折"),
          _buildInfoCard(
            "額骨 (Frontal bone)",
            "需區分內外骨板。若合併內板骨折需神外協同；若額竇內層破損，會使腦部與外界相通，需進行額竇閉塞手術 (Obliteration) 防感染。",
          ),
          _buildInfoCard(
            "顴骨 (Zygoma)",
            "常伴隨患側臉頰麻木 (眶下神經受損)。症狀包含眼球凹陷、張口受限、臉頰塌陷。",
          ),
          _buildInfoCard(
            "上顎骨 (Maxilla & Palate)",
            "LeFort 分類 (I, II, III)。\n⚠️ 學理定義：LeFort 必然是「雙側性」！若臨床僅單側，通常合併齶骨骨折或不完全骨折。",
          ),
          _buildInfoCard(
            "眼眶骨 & NOE 複合體",
            "• 眼眶：多為 Blow-out fracture，導致眼窩組織疝氣 (複視、眼球凹陷)。\n• NOE：表現為眼距過寬 (Telecanthus)、鼻樑側邊塌陷。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("下顏面骨折"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "下顎骨 (Mandible) - Surgical Pearl",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "下顎骨聯合處 (Symphysis) 骨折，有極高機率合併發生髁狀突骨折 (Condyle fracture)！\n理學檢查若發現「張口時耳前有壓痛點」需高度警覺，以免漏診。",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 臨床評估與手術處置 ---
  Widget _buildSurgicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("影像學診斷"),
          _buildInfoCard(
            "黃金標準：電腦斷層 (CT)",
            "必須檢視 Axial, Coronal, Sagittal 三切面，強烈建議 3D 影像重組 (3D Reconstruction) 獲取骨折整體空間概念。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("手術時機與原則"),
          _buildAlertCard(
            "核心原則：復位先於固定！",
            "Reduction before Fixation。\n固定點應選擇顏面骨骼較結實的樑柱結構 (Buttress / Pillar)。",
          ),
          const Text(
            "• 手術時機：受傷後 1-2 週，待軟組織消腫後進行 (視野佳/出血少)。不可超過 3-4 週以免初步癒合增加困難。\n• 適應症：重要功能與外觀受損 (咬合不正、複視、明顯塌陷) 無法自行改善者。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("特殊部位目標"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "上下顎骨：首要目標是回復咬合 (Restore Occlusion)！",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "術中需綁上固定器 (Arch bar)，將上下牙齒固定於正確咬合位置 (MMF) 後，再進行骨骼內固定。",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 術後照護與併發症 ---
  Widget _buildPostOpTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("傷口與消腫照護"),
          const Text(
            "• 冷熱敷：術後前 3-5 天「冰敷」(減出血腫脹)，之後改「熱敷」(促血液循環吸血塊)。\n• 口外傷口：塗抹抗生素藥膏 (5-7天拆線)。\n• 口內傷口：非酒精性漱口水；有綁 Arch bar 者建議用沖牙機清殘渣。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("抗生素使用原則"),
          _buildInfoCard("無口內傷口", "使用第一線抗生素即可 (如 Cefazolin, Clindamycin)。"),
          _buildInfoCard(
            "有口內傷口",
            "因口腔菌叢複雜，建議升級至第二線抗生素 (如 Cefmetazole, Unasyn)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("上下顎間固定 (MMF) 照護"),
          const Text(
            "維持 3 天至數週不等。核心目標為：確保骨折癒合期間「維持正確的創傷前咬合位置」。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("後遺症監測"),
          const Text(
            "疤痕攣縮、骨折不癒合、咬合不正、顏面/眶下神經麻木、複視或眼球轉動受限。若發生需及早照會眼科/牙科共同處理。",
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
