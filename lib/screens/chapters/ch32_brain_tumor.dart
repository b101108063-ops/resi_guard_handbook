import 'package:flutter/material.dart';

class Ch32BrainTumorTile extends StatelessWidget {
  const Ch32BrainTumorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.biotech, color: Colors.purple),
      title: const Text("腦部腫瘤 (Brain Tumor)"),
      subtitle: const Text("WHO 分類、神經定位、GBM 處置"),
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
                  Tab(text: "病理分類"),
                  Tab(text: "症狀定位"),
                  Tab(text: "外科治療"),
                ],
              ),
              SizedBox(
                height: 550, // 增加高度以容納詳細資訊
                child: TabBarView(
                  children: [
                    _buildPathologyTab(),
                    _buildLocalizationTab(),
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

  // --- Tab 1: 病理分類 ---
  Widget _buildPathologyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("常見原發性腫瘤"),
          _buildInfoCard(
            "神經膠質瘤 (Glioma)",
            "佔 80%。Gr I-IV。GBM (Gr IV) 預後極差，無治療存活僅 3-4 個月。",
          ),
          _buildInfoCard("寡樹突膠質瘤", "90% 有鈣化。帶有 1p/19q co-deletion 者對化療反應佳。"),
          _buildInfoCard("腦膜瘤 (Meningioma)", "多為良性，源自蜘蛛膜帽狀細胞。與女性荷爾蒙有關。"),
          const Divider(),
          _buildSectionTitle("特殊與轉移"),
          _buildAlertCard("淋巴瘤 (PCNSL)", "與 EBV 相關。關鍵：手術僅需「立體定位切片」，廣泛切除不影響預後。"),
          _buildInfoCard("轉移性腦瘤", "來源：肺癌 (最常見)、乳癌、黑色素瘤。"),
        ],
      ),
    );
  }

  // --- Tab 2: 症狀與神經定位 ---
  Widget _buildLocalizationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("全身性症狀"),
          const Text("• 頭痛：約 50%，咳嗽或用力時加劇。\n• 癲癇：成年人初次不明原因癲癇，高度懷疑腦瘤。"),
          const Divider(height: 24),
          _buildSectionTitle("局部定位 (Localization)"),
          _buildLocalizationCard("額葉 (Frontal)", "人格改變、表達性失語症、無動機 (Abulia)。"),
          _buildLocalizationCard("顳葉 (Temporal)", "既視感 (Déjà vu)、記憶受損、視野缺損。"),
          _buildLocalizationCard("頂葉 (Parietal)", "感覺/運動受損、失認症 (Agnosia)。"),
          _buildLocalizationCard(
            "後顱窩 (Posterior Fossa)",
            "步態不穩 (Ataxia)、辨距不良、腦神經異常。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 外科處置 ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("手術原則"),
          _buildInfoCard(
            "Maximal Safe Resection",
            "目標：最大化切除並保留神經功能。若侵犯語言/運動區，改採部分切除。",
          ),
          const Divider(),
          _buildSectionTitle("輔助工具"),
          const Text(
            "• 神經導航 (Navigation)\n• 手術顯微鏡/內視鏡\n• 術中生理監測 (EEG/Cortical mapping)\n• CUSA (超音波手術抽吸器)",
          ),
          const Divider(),
          _buildSectionTitle("內科與化放療"),
          _buildInfoCard("藥物控制", "類固醇 (減輕水腫)、抗癲癇藥、降腦壓藥。"),
          _buildAlertCard("Temozolomide (Temodal)", "GBM 的標準口服化療藥，配合 CCRT 使用。"),
          const Text(
            "💡 放射性壞死：半年後發生，症狀極似復發，需類固醇消腫。",
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
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
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(content, style: const TextStyle(fontSize: 13)),
        dense: true,
      ),
    );
  }

  Widget _buildAlertCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.purple.shade50,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.purple,
          ),
        ),
        subtitle: Text(content, style: const TextStyle(fontSize: 13)),
        dense: true,
      ),
    );
  }

  Widget _buildLocalizationCard(String lobe, String symptoms) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• $lobe: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(symptoms)),
        ],
      ),
    );
  }
}
