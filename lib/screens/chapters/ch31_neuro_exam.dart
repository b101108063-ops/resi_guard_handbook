import 'package:flutter/material.dart';

class Ch31NeuroExamTile extends StatelessWidget {
  const Ch31NeuroExamTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.psychology, color: Colors.blueGrey),
      // 神經學檢查意象
      title: const Text("神經理學檢查 (Neurological Exam)"),
      subtitle: const Text("GCS, 腦神經, 肌力, 反射, 小腦, 感覺"),
      trailing: const Icon(Icons.chevron_right, size: 16),
      dense: true,
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => DefaultTabController(
        length: 6,
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
                  Tab(text: "意識/認知"),
                  Tab(text: "腦神經"),
                  Tab(text: "運動/肌力"),
                  Tab(text: "反射/病灶"),
                  Tab(text: "小腦功能"),
                  Tab(text: "感覺系統"),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    _buildConsciousnessTab(),
                    _buildCranialNervesTab(),
                    _buildMotorTab(),
                    _buildReflexTab(),
                    _buildCerebellarTab(),
                    _buildSensoryTab(),
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

  // --- Tab 1: 意識與認知 ---
  Widget _buildConsciousnessTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("格拉斯哥昏迷指數 (GCS)"),
          const Text("滿分 15 分，最低 3 分", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          _buildGCSTable(),
          const Divider(height: 24),
          _buildSectionTitle("認知功能評估 (JOMAC)"),
          const Text(
            "用於意識清楚但可能有高階皮質功能障礙者",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          _buildInfoCard("J - Judgment 判斷力", "如：家裡失火怎麼辦？"),
          _buildInfoCard("O - Orientation 定向感", "人、時、地"),
          _buildInfoCard("M - Memory 記憶力", "短期：複誦三樣物品；長期：住址/電話"),
          _buildInfoCard("A - Abstract/Attention 抽象思考", "香蕉與橘子的異同"),
          _buildInfoCard("C - Calculation 計算力", "100 減 7 連續五次"),
        ],
      ),
    );
  }

  Widget _buildGCSTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.teal),
          children: [
            Text(
              "分數",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "睜眼 (E)",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "說話 (V)",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "運動 (M)",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        _buildGCSRow("6", "-", "-", "Obey commands 聽從指令"),
        _buildGCSRow(
          "5",
          "Spontaneous 主動",
          "Oriented 有條理",
          "Localize pain 定位痛點",
        ),
        _buildGCSRow("4", "To speech 呼喚", "Confused 混亂", "Withdrawal 回縮"),
        _buildGCSRow(
          "3",
          "To pain 痛刺激",
          "Inappropriate words 單字",
          "Decorticate 去皮質/彎曲",
        ),
        _buildGCSRow(
          "2",
          "To pain 痛刺激",
          "Unintelligible sounds 發聲",
          "Decerebrate 去大腦/伸張",
        ),
        _buildGCSRow("1", "None 無", "None 無", "None 無"),
      ],
    );
  }

  TableRow _buildGCSRow(String score, String eye, String verbal, String motor) {
    return TableRow(
      children: [
        Text(score, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(eye),
        Text(verbal),
        Text(motor),
      ],
    );
  }

  // --- Tab 2: 腦神經 ---
  Widget _buildCranialNervesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("腦神經檢查重點"),
          _buildCNRow("I", "Olfactory 嗅覺", "嗅覺（排除鼻塞因素）"),
          _buildCNRow("II", "Optic 視神經", "視力、視野、光反射 (CN II 傳入，CN III 傳出)"),
          _buildCNRow("III", "Oculomotor 動眼神經", "大部分眼球運動、提眼瞼、瞳孔收縮"),
          _buildCNRow("IV", "Trochlear 滑車神經", "上斜肌，向內下方看"),
          _buildCNRow(
            "V",
            "Trigeminal 三叉神經",
            "臉部觸覺/痛覺、咀嚼肌、角膜反射 (CN V 傳入，CN VII 傳出)",
          ),
          _buildCNRow("VI", "Abducens 外展神經", "外直肌，向外看"),
          _buildCNRow("VII", "Facial 面神經", "表情肌。中樞性保留額頭皺紋，周邊性全臉麻痺"),
          _buildCNRow("VIII", "Vestibulocochlear 聽神經", "聽力與平衡"),
          _buildCNRow("IX", "Glossopharyngeal 舌咽神經", "懸壅垂、吞嚥、嘔吐反射"),
          _buildCNRow("X", "Vagus 迷走神經", "懸壅垂偏向健側"),
          _buildCNRow("XI", "Accessory 副神經", "聳肩、轉頭"),
          _buildCNRow("XII", "Hypoglossal 舌下神經", "伸舌頭偏向患側、有無萎縮/肌束顫動"),
        ],
      ),
    );
  }

  Widget _buildCNRow(String cn, String name, String desc) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 4),
      color: Colors.blue.shade50,
      child: ListTile(
        dense: true,
        leading: CircleAvatar(
          radius: 14,
          backgroundColor: Colors.teal,
          child: Text(
            cn,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        subtitle: Text(desc, style: const TextStyle(fontSize: 11)),
      ),
    );
  }

  // --- Tab 3: 運動系統 ---
  Widget _buildMotorTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("肌力分級 (MRC Grading)"),
          _buildInfoCard("5 分", "正常肌力，可對抗最大阻力"),
          _buildInfoCard("4 分", "可對抗重力及部分阻力"),
          _buildInfoCard("3 分", "僅可對抗重力，無法抵抗外力"),
          _buildInfoCard("2 分", "無重力下可水平移動"),
          _buildInfoCard("1 分", "僅有肌肉收縮，無關節活動"),
          _buildInfoCard("0 分", "無任何收縮"),
          const Divider(height: 24),
          _buildSectionTitle("關鍵肌節 (Myotomes)"),
          const Text(
            "上肢",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          _buildMyotomeRow("C5", "三角肌 Deltoid", "肩外展"),
          _buildMyotomeRow("C6", "二頭肌 Biceps", "肘彎曲"),
          _buildMyotomeRow("C7", "三頭肌 Triceps", "肘伸直"),
          _buildMyotomeRow("C8", "屈指深肌", "手指彎曲"),
          _buildMyotomeRow("T1", "小指外展肌", "手指外展"),
          const SizedBox(height: 8),
          const Text(
            "下肢",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          _buildMyotomeRow("L2", "髂腰肌", "髖彎曲"),
          _buildMyotomeRow("L3", "股四頭肌", "膝伸直"),
          _buildMyotomeRow("L4", "脛前肌", "足背屈 Dorsiflexion"),
          _buildMyotomeRow("L5", "伸拇長肌", "腳拇指伸直"),
          _buildMyotomeRow("S1", "腓腸肌", "足蹠屈 Plantarflexion"),
        ],
      ),
    );
  }

  Widget _buildMyotomeRow(String level, String muscle, String action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              level,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(muscle, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              action,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 反射與病灶定位 ---
  Widget _buildReflexTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("上運動神經元 (UMN) vs 下運動神經元 (LMN)"),
          const SizedBox(height: 8),
          _buildReflexTable(),
          const Divider(height: 24),
          _buildSectionTitle("深腱反射 (DTR) 對應"),
          _buildInfoCard("C5/C6", "Biceps 反射 (肘彎曲)"),
          _buildInfoCard("C7", "Triceps 反射 (肘伸直)"),
          _buildInfoCard("L4", "Knee 反射 (膝蓋)"),
          _buildInfoCard("S1", "Ankle 反射 (踝關節)"),
          const Divider(height: 24),
          _buildSectionTitle("特殊反射"),
          _buildInfoCard("Hoffman sign", "C7-C8，UMN 徵象"),
          _buildInfoCard("Bulbocavernosus reflex", "S2-S4，評估 spinal shock"),
          _buildInfoCard("Babinski sign", "UMN 病理反射"),
        ],
      ),
    );
  }

  Widget _buildReflexTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.teal),
          children: [
            Text(
              "徵象",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "UMN",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "LMN",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        _buildReflexRow("位置", "腦皮質、腦幹、脊髓白質", "脊髓前角、神經根、周邊神經"),
        _buildReflexRow("肌力", "無力", "無力"),
        _buildReflexRow("肌肉萎縮", "輕微 (廢用性)", "明顯 (++)"),
        _buildReflexRow("肌束震顫", "無", "有 (+)"),
        _buildReflexRow("深腱反射", "增強 (Hyperreflexia)", "減弱或消失 (Hyporeflexia)"),
        _buildReflexRow("肌肉張力", "痙攣 (Spasticity)", "鬆弛 (Flaccidity)"),
        _buildReflexRow("病理反射", "Babinski (+)", "無"),
      ],
    );
  }

  TableRow _buildReflexRow(String sign, String umn, String lmn) {
    return TableRow(
      children: [
        Text(
          sign,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(umn, style: const TextStyle(fontSize: 11)),
        Text(lmn, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  // --- Tab 5: 小腦功能 ---
  Widget _buildCerebellarTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("小腦功能障礙口诀：HANDS tremor"),
          const Text(
            "病灶通常位於同側",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          _buildInfoCard("H - Hypotonia", "張力減退"),
          _buildInfoCard(
            "A - Ataxia",
            "運動失調。Romberg's test、Tandem gait、Heel-shin test",
          ),
          _buildInfoCard("N - Nystagmus", "眼球震顫"),
          _buildInfoCard("D - Dysmetria", "辨距力不良。Finger-nose-finger test"),
          _buildInfoCard("S - Speech", "語言障礙 (Scanning speech，發音單調斷續)"),
          _buildInfoCard("Tremor", "意向性震顫 (Intention tremor)，動作中顫抖，靜止時消失"),
        ],
      ),
    );
  }

  // --- Tab 6: 感覺系統 ---
  Widget _buildSensoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("感覺傳導路徑"),
          _buildInfoCard(
            "脊髓視丘徑 Spinothalamic tract",
            "痛覺、溫覺、輕觸覺。在脊髓進入後隨即交叉至對側上升",
          ),
          _buildInfoCard("後索 Dorsal columns", "本體覺、震動覺、精細觸覺。在同側上升至延腦才交叉"),
          const Divider(height: 24),
          _buildSectionTitle("重要皮節定位 (Dermatome)"),
          _buildMyotomeRow("T4", "乳頭連線", ""),
          _buildMyotomeRow("T10", "肚臍", ""),
          _buildMyotomeRow("T12", "腹股溝韌帶", ""),
          _buildMyotomeRow("L4", "膝蓋/小腿內側", ""),
          _buildMyotomeRow("S1", "足外側/腳底", ""),
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

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 6),
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(content, style: const TextStyle(fontSize: 12, height: 1.3)),
          ],
        ),
      ),
    );
  }
}
