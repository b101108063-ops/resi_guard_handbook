import 'package:flutter/material.dart';

class Ch35_1CerebralAbscessTile extends StatelessWidget {
  const Ch35_1CerebralAbscessTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.coronavirus, color: Colors.green), // 象徵感染/細菌
      title: const Text("腦膿瘍 (Cerebral Abscess)"),
      subtitle: const Text("感染途徑、影像鑑別(DWI)、抽吸與手術"),
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
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                isScrollable: true,
                tabs: [
                  Tab(text: "病因分期"),
                  Tab(text: "臨床影像"),
                  Tab(text: "治療策略"),
                  Tab(text: "手術預後"),
                ],
              ),
              SizedBox(
                height: 550,
                child: TabBarView(
                  children: [
                    _buildPathoTab(),
                    _buildClinicalTab(),
                    _buildTreatmentTab(),
                    _buildSurgTab(),
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

  // --- Tab 1: 病因與組織分期 ---
  Widget _buildPathoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("感染途徑與致病菌"),

          _buildInfoCard(
            "1. 血行性感染 (最常見)",
            "• 成人：肺部感染 (膿胸、支氣管擴張)、牙周病、心內膜炎。\n• 孩童：50% 為發紺性心臟病 (法洛氏四重症 TOF)，右向左分流致口腔鏈球菌入腦。",
          ),
          _buildInfoCard(
            "2. 局部擴散 & 外傷",
            "• 鼻竇炎/中耳炎：易致額葉/顳葉/小腦膿瘍。\n• 術後/外傷：有 CSF 漏或異物殘留時風險高。",
          ),
          const Text(
            "💡 致病菌：鏈球菌 (Streptococcus) 最常見，但 10-60% 為多菌株。免疫低下者常為黴菌 (Toxoplasma, Aspergillus)。",
            style: TextStyle(fontSize: 13, color: Colors.blueGrey),
          ),

          const Divider(height: 24),
          _buildSectionTitle("組織學分期 (共 4 期)"),

          const Text(
            "發展至少需兩週。注意：類固醇會延緩此過程！",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildTable(
            ["時期", "天數", "特徵"],
            [
              ["早期發炎", "1-3天", "界線不清，周邊血管發炎浸潤"],
              ["晚期發炎", "4-9天", "中心開始壞死"],
              ["早期外膜", "10-13天", "血管增生，中心壞死區成形"],
              ["晚期外膜", ">14天", "膠原蛋白外膜形成，周邊膠質增生"],
            ],
          ),
        ],
      ),
    );
  }

  // --- Tab 2: 臨床與影像學診斷 ---
  Widget _buildClinicalTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("臨床表現與禁忌症"),
          const Text(
            "• 症狀：IICP (頭痛/嘔吐/嗜睡)、局部無力、癲癇。\n• 抽血：WBC 可正常，但 CRP 顯著增加 (敏感度 90%)。\n• 惡化速度：相較於腦瘤，腦膿瘍惡化極快！",
          ),
          const SizedBox(height: 8),
          _buildAlertCard(
            "🚨 絕對禁忌：腰椎穿刺 (LP)",
            "診斷價值極低 (培養陽性率僅 6-22%)，且極易引發致命的「經天幕疝脫 (Transtentorial herniation)」！",
          ),

          const Divider(height: 24),
          _buildSectionTitle("影像學鑑別診斷 (MRI 為首選)"),

          _buildInfoCard(
            "MRI 典型特徵",
            "• T1WI：薄層環狀顯影，偶見液液界面 (fluid-fluid level)。\n"
                "• DWI (擴散造影)：呈現明亮 (High signal, 擴散受限) 👉 這是鑑別腫瘤壞死區 (通常為暗) 的關鍵！\n"
                "• ADC：呈現黑暗。\n"
                "• MR-spectroscopy：Amino acids, acetate, lactate 為膿瘍特異性指標。",
          ),
        ],
      ),
    );
  }

  // --- Tab 3: 治療策略 (適應症) ---
  Widget _buildTreatmentTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("治療主軸"),
          const Text(
            "靜脈抗生素 (6-8週) + 外科介入。應盡量在給藥前取得檢體培養！",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const Divider(height: 24),
          _buildSectionTitle("單獨內科藥物適應症"),
          _buildInfoCard(
            "適用條件",
            "1. 早期：症狀 < 2 週 (發炎期 cerebritis)。\n"
                "2. 小病灶：直徑 0.8–2.5 cm (平均 1.7cm)。\n"
                "3. 高風險：麻醉風險高、深部病灶 (腦幹)、多發性、合併腦室管膜炎。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("外科手術絕對/相對適應症"),
          _buildAlertCard(
            "必須手術之情況",
            "1. 膿瘍 > 3 公分。\n"
                "2. 嚴重壓迫、IICP、神經缺損惡化。\n"
                "3. 貼近腦室 (破入腦室預後極差！)。\n"
                "4. 黴菌性膿瘍、外傷異物殘留、多腔室病灶。\n"
                "5. 內科治療無效或診斷困難。",
          ),
        ],
      ),
    );
  }

  // --- Tab 4: 手術方式與預後 ---
  Widget _buildSurgTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("外科手術方式"),

          _buildInfoCard(
            "1. 細針抽吸引流 (Aspiration)",
            "目前主流。適用多處或深部病灶。可局部麻醉+立體定位 (Stereotactic)，術中以 N/S 或抗生素沖洗。",
          ),
          _buildInfoCard(
            "2. 開顱切除 (Excision)",
            "能縮短治療期並降復發率。適用：外傷後 (清異物)、黴菌性腦膿瘍 (單純抽吸常無效)。",
          ),

          const Divider(height: 24),
          _buildSectionTitle("輔助用藥與預後"),
          const Text(
            "• 抗癲癇藥：可預防性給予。\n• 類固醇：具爭議。可消水腫，但會延緩外膜形成，拉長治療期。",
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 12),

          _buildAlertCard(
            "預後與致命指標",
            "整體死亡率降至 0-10%，但神經後遺症 (偏癱/癲癇) 比例仍高。\n"
                "💀 死亡率幾近 100% 的極差指標：\n"
                "1. 膿液已破入腦室 (Intraventricular rupture)。\n"
                "2. 器官移植後發生黴菌性腦膿瘍。",
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
          color: Colors.green,
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

  Widget _buildTable(List<String> headers, List<List<String>> data) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade300),
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2.5),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.green.shade50),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    h,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...data.map(
          (row) => TableRow(
            children: row
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cell, style: const TextStyle(fontSize: 13)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
