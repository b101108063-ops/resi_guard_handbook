import 'package:flutter/material.dart';

class Ch32_2_PituitaryTile extends StatelessWidget {
  const Ch32_2_PituitaryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.face_retouching_natural,
        color: Colors.purple,
      ), // 象徵頭面部/蝶竇
      title: const Text("腦垂體腫瘤 (Pituitary Tumor)"),
      subtitle: const Text("中風急症, TSS 手術, 尿崩症(DI)照護"),
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
                labelColor: Colors.purple,
                indicatorColor: Colors.purple,
                tabs: [
                  Tab(text: "分類/急症"),
                  Tab(text: "治療策略"),
                  Tab(text: "術後/DI"),
                ],
              ),
              SizedBox(
                height: 550, // 確保有足夠空間顯示內容與圖表
                child: TabBarView(
                  children: [
                    _buildPresentationTab(),
                    _buildTreatmentTab(),
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

  // --- Tab 1: 分類與急症 ---
  Widget _buildPresentationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("分類 (Grading)"),
          const Text(
            "• 微腺瘤 (Microadenoma): ≤ 1 公分\n• 巨腺瘤 (Macroadenoma): > 1 公分\n• 影像首選：腦部 MRI (含顯影劑)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("臨床表現 (Functioning vs Mass Effect)"),

          _buildInfoCard(
            "1. 腫塊效應 (Mass Effect)",
            "• 視神經壓迫：雙側顳側偏盲 (Bitemporal hemianopsia)。\n• 海綿竇侵犯：顱神經壓迫 (眼肌麻痺、顏面麻木)。\n• 下視丘受壓：泛垂體功能低下。",
          ),
          _buildInfoCard(
            "2. 內分泌失調 (65%)",
            "• PRL (48%)：停經、溢乳、陽痿。\n• GH (10%)：肢端肥大症、巨人症 (IGF-1 上升)。\n• ACTH (6%)：庫欣氏症 (Cushing's)。\n• TSH (<2%)：甲狀腺亢進。",
          ),

          const Divider(height: 24),
          _buildAlertCard(
            "🚨 外科急症：腦下垂體中風 (Apoplexy)",
            "機轉：巨腺瘤突發梗塞缺血或出血膨脹。\n"
                "症狀：突發劇烈頭痛、急性視覺障礙、眼肌麻痺、意識喪失。\n"
                "處置：立即給予「高劑量糖皮質素」、補充甲狀腺素，嚴重視覺障礙需緊急手術減壓！",
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 治療策略 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("藥物治療 (Pharmacotherapy)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "⚠️ 泌乳激素瘤 (Prolactinoma) 首選是「藥物治療」而非手術！",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "• PRL 瘤：Dopamine agonists (Bromocriptine 或 Cabergoline)。\n• GH 瘤：Octreotide (Somatostatin 類似物)。\n• ACTH 瘤：Ketoconazole (需監測肝功能)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("外科手術 (Surgery)"),

          _buildInfoCard(
            "經蝶竇手術 (TSS)",
            "首選術式。優點：無顏面疤痕、有機會保留正常垂體功能。適應症：多數 GH, ACTH, TSH 及非功能性腫瘤。",
          ),
          _buildInfoCard("開顱手術 (Craniotomy)", "適應症：腫瘤向蝶鞍外大幅延伸，或復發性腫瘤有嚴重沾黏。"),
          _buildInfoCard("立體定位放射 (SRS)", "加馬刀/電腦刀。作為術後輔助治療。"),
        ],
      ),
    );
  }

  // --- Tab 3: 術後與 DI 照護 (值班重點) ---
  Widget _buildPostOpTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("1. 類固醇補充 (Steroid Coverage)"),
          const Text(
            "預防暫時或永久 ACTH 分泌不足，需給予 Stress dose：\n"
            "• 術前/術中：Hydrocortisone 300 mg\n"
            "• POD 1：降至 200 mg\n"
            "• POD 2：降至 100 mg\n"
            "• 後續：改口服 Cortisone acetate 滴定維持。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("2. 尿崩症監測 (Diabetes Insipidus, DI)"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "🚨 診斷標準 (滿足其一 + 尿比重異常):",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 4),
                Text("1. 尿量 > 300 ml/hr"),
                Text("2. 連續兩小時 > 500 ml"),
                Text("3. 且尿比重 (SpG) < 1.005"),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "• 病程：典型呈三相反應 (Triphasic)：短暫 DI → SIADH → 永久 DI。多數為術後 12-36h 的短暫性 DI。\n• 處置藥物：\n  - Vasopressin: 5U SC q6h PRN.\n  - DDAVP: 0.5-1 ml (2-4 mcg) SC/IV/鼻噴劑。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("3. 其他常規"),
          const Text(
            "• TSS 術後需給予抗生素 (Unasyn) 與抗組織胺。\n• 注意鼻部壓迫止血與不可用力擤鼻涕 (防 CSF leak)。",
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
          color: Colors.purple,
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
            Text(content, style: const TextStyle(fontSize: 13, height: 1.4)),
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
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
