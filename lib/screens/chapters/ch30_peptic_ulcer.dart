import 'package:flutter/material.dart';

class Ch30PepticUlcerTile extends StatelessWidget {
  const Ch30PepticUlcerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.medication_liquid,
        color: Colors.blueGrey,
      ), // 胃酸/藥物意象
      title: const Text("消化性潰瘍 (Peptic Ulcer)"),
      subtitle: const Text("Boey Score, 三點縫合, 困難斷端"),
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
                isScrollable: true, // 標籤較多，設為可滑動
                tabs: [
                  Tab(text: "總論/分類"),
                  Tab(text: "穿孔 (Boey)"),
                  Tab(text: "出血/阻塞"),
                  Tab(text: "困難斷端"),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    _buildOverviewTab(),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: _BoeyScoreCalculator(),
                    ),
                    _buildBleedingTab(),
                    _buildStumpTab(),
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

  // --- Tab 1: 總論與分類 ---
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("病理生理"),
          const Text(
            "• H. pylori：80% DU, 60% GU。\n• NSAID：老年人併發症主因。\n• 頑固性潰瘍：治療12週無效，需排除惡性、Z-E syndrome。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("Modified Johnson Classification"),
          const Text(
            "決定是否需做迷走神經切斷術 (Vagotomy)",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          _buildClassCard("Type I", "小彎側 (Lesser curvature)", "低酸", "最常見"),
          _buildClassCard("Type II", "胃體部 + 十二指腸潰瘍", "高酸", "需抗酸手術"),
          _buildClassCard("Type III", "幽門前 (Prepyloric)", "高酸", "需抗酸手術"),
          _buildClassCard("Type IV", "高位小彎 (近 GE junction)", "低酸", "手術困難"),
          _buildClassCard("Type V", "藥物引起 (NSAID)", "不一定", "多發性"),
        ],
      ),
    );
  }

  // --- Tab 3: 出血與阻塞 ---
  Widget _buildBleedingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("出血 (Hemorrhage)"),
          _buildInfoCard(
            "手術適應症",
            "1. 休克/不穩定。\n2. 內視鏡止血失敗 (>2次)。\n3. 需持續大量輸血 (>6U/day)。",
          ),

          const SizedBox(height: 8),
          const Text(
            "十二指腸潰瘍止血術式：",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            "1. Kocher Maneuver：游離十二指腸。\n2. 切開：Landmark 為 Vein of Mayo。\n3. 三點縫合 (Three-point ligation)。",
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "🧵 三點縫合重點 (GDA)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "1. 上方 (Proximal)：阻斷 GDA 來源。",
                  style: TextStyle(fontSize: 13),
                ),
                Text("2. 下方 (Distal)：阻斷反流血。", style: TextStyle(fontSize: 13)),
                Text(
                  "3. 內側 (U-stitch)：阻斷胰臟分支 (Transverse pancreatic br.)。",
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "⚠️ 警告：不可過深，避免傷及 CBD！",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 24),
          _buildSectionTitle("阻塞 (Obstruction)"),
          const Text(
            "• 術前：務必切片排除惡性。\n• 急性期：氣球擴張。\n• 手術：Antrectomy (B-II) 或 Bypass (Gastrojejunostomy)。",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 困難斷端與照護 ---
  Widget _buildStumpTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("困難十二指腸斷端 (Difficult Stump)"),
          const Text("當十二指腸嚴重纖維化無法關閉時：", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _buildInfoCard("Nissen Closure", "將前壁縫合固定於胰臟包膜上。"),
          _buildInfoCard(
            "Bancroft Closure",
            "保留胃竇漿肌層 (Seromuscular)，剝除黏膜後包埋殘端。",
          ),
          _buildInfoCard(
            "減壓 (Decompression)",
            "放置 Tube duodenostomy 引流 + 空腸餵食管 (J-tube)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("術後照護"),
          _buildBulletPoint("抗生素：穿孔視為腹內感染，需廣效覆蓋。"),
          _buildBulletPoint("營養：早期腸道營養 (J-tube) 有助癒合。"),
          _buildBulletPoint("監測：注意 Duodenal stump leakage。"),
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

  Widget _buildClassCard(String type, String loc, String acid, String note) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 6),
      color: Colors.grey.shade50,
      child: ListTile(
        visualDensity: VisualDensity.compact,
        title: Text(
          type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text("$loc\n分泌: $acid | $note"),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 4),
            Text(content, style: const TextStyle(fontSize: 13, height: 1.4)),
          ],
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
}

// --- Tab 2: Boey Score Calculator ---
class _BoeyScoreCalculator extends StatefulWidget {
  const _BoeyScoreCalculator();
  @override
  State<_BoeyScoreCalculator> createState() => _BoeyScoreCalculatorState();
}

class _BoeyScoreCalculatorState extends State<_BoeyScoreCalculator> {
  bool _shock = false; // 休克 (BP < 90)
  bool _comorbidity = false; // 嚴重心/肺/腎/肝共病
  bool _duration = false; // 症狀 > 24小時

  @override
  Widget build(BuildContext context) {
    int score = 0;
    if (_shock) score++;
    if (_comorbidity) score++;
    if (_duration) score++;

    String riskText = "";
    Color riskColor = Colors.green;
    String actionText = "";

    if (score == 0) {
      riskText = "低風險 (死亡率 < 1%)";
      actionText = "可考慮腹腔鏡修補 (Laparoscopic Repair)";
      riskColor = Colors.green;
    } else if (score == 1) {
      riskText = "中風險 (死亡率 ~10%)";
      actionText = "視情況腹腔鏡或開腹";
      riskColor = Colors.orange;
    } else {
      riskText = "高風險 (死亡率 > 45%)";
      actionText = "建議傳統開腹手術 (Open Laparotomy)";
      riskColor = Colors.red;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Boey Score (潰瘍穿孔預後因子)",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            "用於評估 30 天死亡率與術式選擇",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Divider(),

          CheckboxListTile(
            title: const Text("術前休克 (Shock, BP<90)"),
            value: _shock,
            onChanged: (v) => setState(() => _shock = v!),
          ),
          CheckboxListTile(
            title: const Text("嚴重內科共病 (ASA III-IV)"),
            value: _comorbidity,
            onChanged: (v) => setState(() => _comorbidity = v!),
          ),
          CheckboxListTile(
            title: const Text("症狀持續 > 24 小時"),
            value: _duration,
            onChanged: (v) => setState(() => _duration = v!),
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: riskColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: riskColor),
            ),
            child: Column(
              children: [
                Text(
                  "Boey Score: $score 分",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  riskText,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: riskColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  actionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: riskColor.withOpacity(0.8)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          _buildInfoBox(
            "手術要點 (Graham Patch)",
            "• 穿孔 < 1cm：直接修補或 Pedicled Omental Patch。\n"
                "• 穿孔 > 2cm：需懷疑惡性 (冷凍切片)，可能需胃切除。\n"
                "• 探查：務必打開 Lesser sac 檢查後壁。",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
