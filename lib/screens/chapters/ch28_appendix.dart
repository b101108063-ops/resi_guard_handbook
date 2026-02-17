import 'package:flutter/material.dart';

class Ch28AppendixTile extends StatelessWidget {
  const Ch28AppendixTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.medical_services_outlined,
        color: Colors.blueGrey,
      ),
      title: const Text("急性闌尾炎 (Acute Appendicitis)"),
      subtitle: const Text("診斷徵象、手術策略、特殊族群"),
      trailing: const Icon(Icons.chevron_right, size: 16),
      dense: true,
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DefaultTabController(
        length: 3,
        child: Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TabBar(
                labelColor: Colors.teal,
                indicatorColor: Colors.teal,
                tabs: [
                  Tab(text: "診斷"),
                  Tab(text: "治療"),
                  Tab(text: "特殊"),
                ],
              ),
              SizedBox(
                height: 500, // 增加高度以容納詳細資訊
                child: TabBarView(
                  children: [
                    _buildDiagnosisTab(),
                    _buildTreatmentTab(),
                    _buildSpecialTab(),
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

  // --- Tab 1: 診斷與病理 ---
  Widget _buildDiagnosisTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("解剖與機轉"),
          _buildBulletPoint("血液供應：SMA → Ileocolic a. → Appendiceal a."),
          _buildBulletPoint("機轉：管腔阻塞 (糞石/淋巴增生) → 壓力升/靜脈阻 → 缺血壞死 → 穿孔。"),
          _buildBulletPoint("菌種：G(-) (E. coli) 與 厭氧菌 (B. fragilis)。"),

          const Divider(height: 24),
          _buildSectionTitle("臨床表現 (History & PE)"),
          _buildInfoCard(
            "轉移痛 (Shifting pain)",
            "肚臍周圍鈍痛 (Visceral) → 轉移至右下腹 (Somatic)。",
          ),
          _buildInfoCard("Rovsing sign", "按壓左下腹 → 引發右下腹痛。"),
          _buildInfoCard("Obturator sign", "髖內旋痛 → 提示位於骨盆腔 (Pelvic)。"),
          _buildInfoCard("Psoas sign", "右髖伸展痛 → 提示位於後腹腔 (Retrocecal)。"),

          const Divider(height: 24),
          _buildSectionTitle("影像學診斷"),
          _buildInfoCard(
            "CT (成人首選)",
            "直徑 >7mm、壁增厚、脂肪發炎 (Stranding)、Target sign。",
          ),
          _buildInfoCard("超音波 (兒童/孕婦)", "不可壓縮 (Non-compressible) 的管狀結構。"),
        ],
      ),
    );
  }

  // --- Tab 2: 治療原則 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 單純性 (Uncomplicated)"),
          const Text(
            "• 首選：腹腔鏡闌尾切除術 (LA)。\n• 藥物：術前靜脈輸液 + 廣效抗生素。\n• 非手術治療：復發率高，僅保留給高麻醉風險者。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 複雜性/穿孔 (Perforated)"),
          const Text(
            "• 術前：加強體液復甦 (Fluid resuscitation)。\n• 手術：移除闌尾 + 清除膿瘍/糞石 + 引流管。\n• 術後：抗生素 4-7 天。需留意腹內膿瘍 (IAA)。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("3. 延遲就醫/膿瘍 (Abscess)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "🚨 立即手術併發症高！\n"
              "策略：抗生素 + CT 導引引流 (PTCD)。\n"
              "後續：發炎消退後 (6-8週) 再行 Interval Appendectomy。",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: Colors.brown,
              ),
            ),
          ),

          const SizedBox(height: 16),
          _buildSectionTitle("4. 偶發性切除 (Incidental)"),
          const Text(
            "原則上不建議順便切除，除非術中發現異常。",
            style: TextStyle(height: 1.5, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 特殊族群與腫瘤 ---
  Widget _buildSpecialTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("特殊族群"),
          _buildInfoCard("🤰 孕婦", "誤診率高。穿孔易致早產。\n腹腔鏡在各孕期皆安全。"),
          _buildInfoCard("👴 老年人", "症狀不明顯，穿孔率高 (40-70%)。\n應積極安排 CT。"),

          const Divider(height: 24),
          _buildSectionTitle("闌尾腫瘤 (Neoplasms)"),
          _buildTumorCard(
            "類癌 (Carcinoid)",
            "最常見。\n<1cm 且在尖端 → 單純切除。\n>2cm 或侵犯基部 → 右半結腸切除。",
          ),
          _buildTumorCard("黏液性 (Mucinous)", "⚠️ 術中嚴禁弄破！\n以免導致偽黏液性腹膜炎 (PMP)。"),
          _buildTumorCard("腺癌 (Adenocarcinoma)", "治療原則同右側大腸癌。"),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(content, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildTumorCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.teal.shade50,
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
}
