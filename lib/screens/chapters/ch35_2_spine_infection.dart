import 'package:flutter/material.dart';

class Ch35_2SpineInfectionTile extends StatelessWidget {
  const Ch35_2SpineInfectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.warning_amber_rounded,
        color: Colors.orange,
      ), // 象徵脊椎發炎與急症警戒
      title: const Text("脊椎感染與 SEA (Spine Infections)"),
      subtitle: const Text("硬脊膜外膿瘍、病程時間軸、緊急減壓"),
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
                  Tab(text: "病理風險"),
                  Tab(text: "臨床病程"),
                  Tab(text: "診斷評估"),
                  Tab(text: "外科處置"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildClinicalTab(),
                    _buildDiagTab(),
                    _buildTreatmentTab(),
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

  // --- Tab 1: 病理與危險因子 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("硬脊膜外膿瘍 (SEA) 學理"),

          const Text(
            "未受適當治療的脊椎炎通常會進展成 SEA。單純的 SEA 極罕見。\n• 致病菌：金黃色葡萄球菌 (S. aureus) 最常見。\n• 位置：胸椎最多 (50%)，病灶多位於後側 (82%)。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("感染途徑"),
          _buildInfoCard("血行性感染 (26-50%)", "最常見。來源：皮膚感染、靜脈藥物濫用、心內膜炎、牙周/泌尿道感染。"),
          _buildInfoCard("局部擴散 & 醫源性", "褥瘡、腰大肌膿瘍、後腹腔感染、脊椎術後或外傷。"),
          const Text(
            "💡 高達 50% 患者找不到明確感染源！",
            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
          ),

          const Divider(height: 24),
          _buildSectionTitle("高危險族群"),
          const Text(
            "1. 糖尿病 (32%) - 最高危險因子！\n2. 靜脈藥物濫用 (18%)\n3. 慢性腎衰竭 (12%)\n4. 酗酒 (10%)\n5. 免疫力低下 (類固醇/AIDS/癌症)",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 臨床表現與病程時間軸 (極重要) ---
  Widget _buildClinicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("⚠️ 惡化時間軸 (Time is Spine)"),
          const Text(
            "SEA 的神經學症狀惡化極為迅速，必須高度警覺：",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),

          _buildTimelineCard("1. 初期", "難以忍受的背痛，合併觸/壓痛。"),
          const Icon(Icons.arrow_downward, size: 16, color: Colors.grey),
          _buildTimelineCard("2. 神經根症狀 (約 3 天)", "進展至神經根痛 (Radicular pain)。"),
          const Icon(Icons.arrow_downward, size: 16, color: Colors.grey),
          _buildTimelineCard("3. 脊髓病徵 (約 4.5 天)", "肢體無力、括約肌失調 (大小便障礙)、腹脹。"),
          const Icon(Icons.arrow_downward, size: 16, color: Colors.red),
          _buildAlertCard("4. 不可逆癱瘓 (僅需 24 小時！)", "從肢體無力惡化至下肢完全癱瘓，進程極快！"),

          const Divider(height: 24),
          _buildSectionTitle("Surgical Pearls (非典型表現)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "• 發燒、盜汗並非絕對會發生。\n• 脊椎術後的 SEA 常只有局部疼痛，甚至無發燒，且 WBC 可能正常，極易延誤診斷！",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 診斷評估 ---
  Widget _buildDiagTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("影像學首選"),

          _buildInfoCard("MRI (核磁共振)", "診斷首選！可免除 LP 需求，並能與橫斷性脊髓炎或脊髓梗塞做鑑別診斷。"),

          const Divider(height: 24),
          _buildSectionTitle("實驗室檢查"),
          _buildInfoCard(
            "ESR (紅血球沉降速率)",
            "通常 > 30。比 WBC 更具參考價值 (慢性期 WBC 常為正常)。",
          ),
          _buildInfoCard(
            "血液培養 (Blood Culture)",
            "即使術前已用抗生素致手術檢體陰性，血培仍可能有陽性發現。",
          ),

          const Divider(height: 24),
          _buildAlertCard("腰椎穿刺 (LP) 之禁忌", "須極度謹慎！若操作時引流出膿液，必須立即停止，並將膿液送培養。"),
        ],
      ),
    );
  }

  // --- Tab 4: 外科處置與預後 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 外科手術介入 (Surgical Therapy)"),
          _buildInfoCard(
            "時機與目標",
            "若神經學症狀有急速惡化可能，應早期手術！目標：確立診斷、清除膿瘍/肉芽組織、加強脊椎穩定性。",
          ),
          _buildInfoCard("術式", "椎弓切除術 (Laminectomy) 減壓。若廣泛減壓致不穩定，須合併骨釘固定。"),

          const Divider(height: 24),
          _buildSectionTitle("2. 保守與抗生素治療"),
          const Text(
            "• 適應症：僅限手術風險過高、感染節數過多，或完全癱瘓已超過 3 天者。\n• 缺點：單純抗生素難以清除肉芽組織，86% 惡化者初期僅用抗生素。\n• 經驗性用藥：需覆蓋 MRSA、Gram(-) 及厭氧菌 (如 Ceftriaxone, Cefepime, Metronidazole, Vancomycin)。至少 6 週。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("3. 預後與死亡率 (Prognosis)"),
          _buildAlertCard(
            "神經恢復極限",
            "一旦完全癱瘓數小時後，極少能恢復 (例外：脊椎 TB 有 50% 恢復機率)。即便在癱瘓 6-12 小時內緊急手術，預後依然不佳。",
          ),
          const Text(
            "• 死亡率：4-31%。死因常為敗血症惡化或癱瘓併發症 (如肺栓塞 PE)。",
            style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildTimelineCard(String step, String desc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(6),
      ), // 避開 const
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ), // 避開 const
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
