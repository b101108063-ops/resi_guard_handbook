import 'package:flutter/material.dart';

class Ch40BurnMgmtTile extends StatelessWidget {
  const Ch40BurnMgmtTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.local_fire_department,
        color: Colors.deepOrangeAccent,
      ), // 象徵燒燙傷
      title: const Text("燒燙傷初級照護 (Burn Mgmt)"),
      subtitle: const Text("Parkland公式、吸入性嗆傷、焦痂切開術"),
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
                  Tab(text: "面積深度"),
                  Tab(text: "輸液與呼吸"),
                  Tab(text: "外科傷口"),
                  Tab(text: "營養與感染"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildAssessmentTab(),
                    _buildResuscitationTab(),
                    _buildWoundTab(),
                    _buildNutriInfectTab(),
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

  // --- Tab 1: 燒傷深度與面積評估 (Depth & Extent) ---
  Widget _buildAssessmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("面積計算 (Rule of Nines)"),
          const Text(
            "⚠️ 僅採計二度以上之燒傷面積 (%TBSA)。\n• 成人：頭頸 9%、單側上肢 9%、軀幹正/背面各 18%、單側下肢 18%、會陰 1%。\n• 兒童：頭部佔比大需調整。\n• 簡便法：病患單一手掌大小約等於 1% TBSA。",
            style: TextStyle(height: 1.5),
          ),
          const Divider(height: 24),
          _buildSectionTitle("深度學理分類"),
          _buildInfoCard(
            "淺二度 (Superficial partial)",
            "傷及淺真皮層。單一粉紅色、疼痛、具毛細血管再充盈 (Capillary refill)。水泡與傷口通常 14 天內癒合。",
          ),
          _buildInfoCard(
            "深二度 & 三度 (Deep & Full-thickness)",
            "肉眼不易區分。皮革樣、乾硬無彈性、失去痛覺、無毛細血管再充盈。\n• 深二度需 >21 天癒合；三度無法自行癒合，需手術介入。",
          ),
          const Text(
            "💡 提示：電傷與化學灼傷通常較深，且受傷後數日內會持續惡化。",
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 體液復甦與呼吸道 (Resuscitation & Airway) ---
  Widget _buildResuscitationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("體液復甦 (Parkland Formula)"),
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
                  "公式：體重(kg) × %TBSA × 4 cc (L/R)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text("• 適用：>20% TBSA 成人。"),
                Text("• 給法：前 8 小時給一半，後 16 小時給剩餘一半。"),
                Text("• 兒童特異性 (<15kg)：肝醣存量少，輸液必須含葡萄糖 (Dextrose-containing)！"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoCard(
            "灌流黃金指標：每小時尿量",
            "成人目標 0.5 cc/kg/hr，孩童 1 cc/kg/hr。未達標增輸液，達標後逐步 Taper。",
          ),

          _buildAlertCard(
            "🚨 膠體溶液禁忌 (Colloid Therapy)",
            "絕不在前 24 小時內給予 Albumin！因早期微血管通透性極大，膠體會直接漏入間質空間加重水腫。第 2 日起才可給予。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("吸入性灼傷 (Inhalation Injury)"),
          _buildAlertCard(
            "一氧化碳處置",
            "立即給予 100% 氧氣 (將半衰期從 40分降至 20分)。\n• 氣道有疑慮應早期插管。\n• 若進展為 ARDS，採低潮氣容積策略並允許容許性高碳酸血症。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 傷口與外科處置 (Wound Management) ---
  Widget _buildWoundTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("外科急症：焦痂切開術 (Escharotomy)"),
          _buildAlertCard(
            "適應症與技術要點",
            "• 適應症：全層燒傷焦痂如束帶般阻礙灌流，引發腔室症候群 (Compartment syndrome)；或胸壁焦痂限制呼吸擴張。\n"
                "• 技術要點：切開深度「僅達焦痂」，不可切開深層筋膜，以免肌腱暴露與壞死。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("敷料與藥膏選擇"),
          _buildInfoCard("初期處置", "清水沖洗、清脫落組織、剃毛髮。避免用水療池 (Tank) 防交叉感染。"),
          _buildInfoCard(
            "局部藥膏 (Topical agents)",
            "• Silver sulfadiazine (Silvadene)：清創前預防細菌定植，維持 8-10h。副作用為白血球下降 (停藥可恢復)。\n"
                "• Mafenide acetate：焦痂穿透力極佳！但大面積使用易引發代謝性酸中毒。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 營養、感染與疼痛 (Nutri & Infection) ---
  Widget _buildNutriInfectTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("營養與代謝管理"),
          const Text(
            "• 高代謝狀態：極易造成肌肉消耗、腸壁變薄、細菌轉移及敗血症。\n• 腸道灌食：應盡早開始 (NG tube)。TPN 僅留給嚴重腸阻塞者。\n• 血糖控制：燒傷易引發胰島素阻抗，需嚴格控制血糖。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("感染監控 (Surgical Pearl)"),
          _buildInfoCard(
            "前 72 小時的陷阱",
            "出現發燒、WBC/血小板升高為正常 SIRS 反應！\n❌ 不需常規細菌培養。\n❌ 絕對不建議給予預防性廣效抗生素 (會增加黴菌/抗藥性菌株)。",
          ),
          _buildAlertCard(
            "敗血症警戒 (>72-96小時)",
            "若出現發燒突波 (Spikes)、低血壓、無法耐受灌食，應立即全面培養 (血尿痰導管傷口) 並給予標靶抗生素。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("疼痛控制"),
          const Text(
            "• 背景痛：口服長效 (Methadone, Morphine)。\n• 處置痛 (換藥時)：短效 Fentanyl 搭配 BZD 緩解焦慮。\n💡 注意：嗎啡易造成腸阻塞，務必常規搭配軟便劑！",
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
          color: Colors.deepOrange,
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
