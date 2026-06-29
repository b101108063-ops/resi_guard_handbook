import 'package:flutter/material.dart';

class Ch2AntibioticsTile extends StatelessWidget {
  const Ch2AntibioticsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.vaccines, color: Colors.indigo),
      title: const Text("外科手術與抗生素使用"),
      subtitle: const Text("劑量計算、經驗性採檢、治療原則"),
      trailing: const Icon(Icons.chevron_right, size: 16),
      dense: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const _Ch2AntibioticsDialog(),
        );
      },
    );
  }
}

// 必須使用 StatefulWidget 來管理計算機的輸入狀態
class _Ch2AntibioticsDialog extends StatefulWidget {
  const _Ch2AntibioticsDialog();

  @override
  State<_Ch2AntibioticsDialog> createState() => _Ch2AntibioticsDialogState();
}

class _Ch2AntibioticsDialogState extends State<_Ch2AntibioticsDialog> {
  // 控制器 (Controllers)
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _bloodLossController = TextEditingController();

  // 狀態變數 (State variables)
  Map<String, dynamic>? _doseResult;
  Map<String, String>? _redoseResult;

  @override
  void dispose() {
    _weightController.dispose();
    _timeController.dispose();
    _bloodLossController.dispose();
    super.dispose();
  }

  // 計算 Cefazolin 術前劑量
  void _calculateDose() {
    final double? weight = double.tryParse(_weightController.text);
    if (weight == null) {
      setState(() => _doseResult = null);
      return;
    }

    setState(() {
      if (weight <= 80) {
        _doseResult = {'dose': '1 g', 'note': '≤ 80 kg'};
      } else if (weight <= 120) {
        _doseResult = {'dose': '2 g', 'note': '81-120 kg'};
      } else {
        _doseResult = {'dose': '3 g', 'note': '> 120 kg'};
      }
    });
  }

  // 評估是否需要術中追加劑量
  void _checkRedosing() {
    final double? time = double.tryParse(_timeController.text);
    final double? bloodLoss = double.tryParse(_bloodLossController.text);

    if (time == null && bloodLoss == null) return;

    final bool needsRedose =
        (time != null && time > 3) || (bloodLoss != null && bloodLoss > 1500);

    setState(() {
      if (needsRedose) {
        _redoseResult = {
          'status': '🔴 建議追加一劑',
          'reason': '因手術時間超過 3 小時或出血量超過 1500 mL',
        };
      } else {
        _redoseResult = {
          'status': '🟢 暫無須追加',
          'reason': '未達追加標準 (> 3hr 或 > 1500mL)',
        };
      }
    });
  }

  // 顯示臨床指引速查卡片
  void _showGuide(String title) {
    String content = "";
    switch (title) {
      case '給藥時機':
        content =
            "• 一般抗生素：劃刀前 60 分鐘內靜脈給予。\n• Vancomycin 或 Fluoroquinolone：建議提前至術前 120 分鐘給予。";
        break;
      case '手術分類':
        content =
            "• 清潔甲類 (疝氣/乳房)：學理可免用，若用則術前 1 劑。\n• 清潔乙類 (心臟/腦部/植入物)：術後不超過 24 小時停藥。\n• 清潔易受污染 (腸胃/泌尿/肺)：不超過 24 小時停藥。懷疑厭氧菌混合感染建議改 Cephamycin 類。";
        break;
      case '特殊手術':
        content =
            "• 大腸直腸：術前一日 19:00 與 23:00，口服 neomycin 2g + metronidazole 2g。\n• 剖腹產：劃刀前 1 小時內給 Cefazolin (不再等斷臍)。\n• 泌尿道：有菌尿症才用。TRUS 切片術前/後 12 小時各口服 Ciprofloxacin 500mg。";
        break;
      case 'MRSA風險':
        content =
            "• 預防：Vancomycin + Cefazolin。\n• 鼻腔定植 S. aureus：使用鼻內 Mupirocin 藥膏 (術前1天、術日、術後5天)，並配合 Chlorhexidine 沐浴。";
        break;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        content: Text(content, style: const TextStyle(height: 1.5)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('了解'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TabBar(
              labelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              isScrollable: true,
              tabs: [
                Tab(text: "預防與計算"),
                Tab(text: "經驗性採檢"),
                Tab(text: "治療與清創"),
              ],
            ),
            SizedBox(
              height: 550, // 固定高度避免鍵盤彈出造成溢位
              child: TabBarView(
                children: [
                  _buildCalculatorTab(),
                  _buildEmpiricalTab(),
                  _buildDefinitiveTab(),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('關閉'),
            ),
          ],
        ),
      ),
    );
  }

  // --- Tab 1: 預防性抗生素與計算機 ---
  Widget _buildCalculatorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Dosing
          const Text(
            '💊 術前劑量 (Cefazolin)',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '體重 (kg)',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => _calculateDose(),
                ),
              ),
              const SizedBox(width: 10),
              if (_doseResult != null)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _doseResult!['dose'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        _doseResult!['note'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Divider(height: 24),

          // Section 2: Re-dosing
          const Text(
            '🩸 術中追加 (Re-dosing)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _timeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '手術時間 (hr)',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _bloodLossController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '出血量 (mL)',
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkRedosing,
              child: const Text('評估是否追加'),
            ),
          ),

          if (_redoseResult != null)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: (_redoseResult!['status'] ?? '').contains("🔴")
                    ? Colors.red.shade50
                    : Colors.green.shade50,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "${_redoseResult!['status']}\n${_redoseResult!['reason']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

          const Divider(height: 24),

          // Section 3: Guidelines Action Chips
          const Text(
            '📚 臨床指引速查',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                label: const Text('給藥時機'),
                onPressed: () => _showGuide('給藥時機'),
              ),
              ActionChip(
                label: const Text('手術分類'),
                onPressed: () => _showGuide('手術分類'),
              ),
              ActionChip(
                label: const Text('特殊手術'),
                onPressed: () => _showGuide('特殊手術'),
              ),
              ActionChip(
                label: const Text('MRSA風險'),
                onPressed: () => _showGuide('MRSA風險'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 經驗性抗生素 (Empirical) ---
  Widget _buildEmpiricalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("處置前考量"),
          const Text(
            "必須綜合評估：感染部位、疑似菌種、過去抗藥紀錄、免疫抑制狀態 (類固醇)、植入物或導管、以及 MRSA/ESBL 定植史。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("常見感染之檢體採集 (給藥前必做！)"),
          _buildInfoCard(
            "軟組織感染",
            "採集膿液 (Pus) 或深部組織培養。嚴禁僅使用表面拭子 (Surface swab)！",
          ),
          _buildInfoCard("腹腔內感染 (IAI)", "抽血液培養 (B/C) + 無菌穿刺液培養。不建議直接採集引流管液。"),
          _buildInfoCard(
            "導管感染",
            "同時抽一組「周邊血」與一組「導管血」。\n💡 若導管樣本比周邊樣本「提早大於 2 小時」呈現陽性，高度懷疑為導管感染。",
          ),
          _buildInfoCard(
            "敗血症 (Sepsis)",
            "B/C、痰液、傷口分泌物 (S/S)、尿液分析 (U/A)，並安排胸部 X 光 (CXR)。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 治療性抗生素 (Definitive) ---
  Widget _buildDefinitiveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("核心原則：藥物無法取代外科引流與清創"),

          _buildInfoCard("軟組織感染", "壞死性筋膜炎、褥瘡骨髓炎：必須合併積極清創並延長抗生素療程。"),
          _buildInfoCard(
            "腹腔內感染 (IAI)",
            "形成膿瘍首要處置為「引流」。長期用 TPN 者需警覺 Candida 感染，但避免過度濫用 Fluconazole。",
          ),
          _buildInfoCard(
            "敗血症",
            "積極尋找感染源 (移除導管/植入物)。Primary bacteremia 療程約 2 週。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("嗜中性白血球低下發燒 (Neutropenic fever)"),
          const Text(
            "• 初期：使用具抗綠膿桿菌活性 (anti-Pseudomonal) 的 β-lactam。\n• 若 48 小時後仍發燒：考慮加入 Amphotericin B，並安排胸部 CT。",
            style: TextStyle(height: 1.5),
          ),

          const Divider(height: 24),
          _buildSectionTitle("避免過度治療之情況"),
          const Text(
            "❌ 無症狀之菌尿症。\n❌ 無全身症狀之尿道念珠菌感染 (Candiduria)。\n❌ 單純肺部定植菌。\n❌ 肺炎病患若無典型浸潤影像 (Infiltration)，應縮短抗生素療程。",
            style: TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }

  // --- UI Helper Components ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.indigo,
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
}
