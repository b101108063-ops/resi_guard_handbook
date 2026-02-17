import 'package:flutter/material.dart';
import 'reference_sidebar.dart'; // ✅ 1. 匯入側邊欄元件
import 'section_general.dart'; // 匯入緒論模組
import 'section_surgery.dart'; // 匯入一般外科模組
import 'section_neurosurgery.dart'; // 👈 匯入新模組

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ 2. 加入側邊欄 (EndDrawer 會從右邊滑出)
      endDrawer: const ReferenceSidebar(),

      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ResiGuard 亞東外科手冊',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '住院醫師隨身助理 v2.2', // 更新版本號
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00695C), // 醫療綠
        foregroundColor: Colors.white,
        actions: [
          // ✅ 3. 新增「參考文獻」按鈕
          // 使用 Builder 是為了讓 context 能找到 Scaffold 來打開 Drawer
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.library_books), // 書本圖示
              tooltip: '參考文獻',
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // 打開右側邊欄
              },
            ),
          ),

          // 原本的更新日誌按鈕
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: '更新日誌',
            onPressed: () => _showChangeLog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ==============================
          // 1. 資料來源宣告 (Source Attribution)
          // ==============================
          Card(
            color: Colors.teal.shade50,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.teal.shade100, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, color: Colors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '本程式內容整理自《亞東外科住院醫師手冊》\n旨在輔助臨床快速決策，細節請依現場狀況為主。',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ==============================
          // 2. Part I: 核心緒論
          // ==============================
          _buildHeader(context, "Part I: 核心緒論 (General Principles)"),
          const GeneralSection(),

          const SizedBox(height: 24),

          // ==============================
          // 3. Part II: 專科指引
          // ==============================
          _buildHeader(context, "Part II: 專科指引 (Specialties)"),
          const SurgerySection(),

          const SizedBox(height: 8),

          // 其他專科 Placeholder
          const NeurosurgerySection(), // 👈 換成這個！實體化模組
          _buildPlaceholder(context, "整形外科 (PS)", "燒傷, 顯微手術..."),
          _buildPlaceholder(context, "心臟外科 (CVS)", "ECMO, 瓣膜置換..."),

          const SizedBox(height: 40),
          const Divider(),

          // ==============================
          // 4. 底部資訊 (Footer)
          // ==============================
          Center(
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () => _showChangeLog(context),
                  icon: const Icon(Icons.history, size: 16, color: Colors.grey),
                  label: const Text(
                    "查看更新日誌 (Change Log)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Created by rockynow",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---

  Widget _buildHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildPlaceholder(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Colors.grey[50],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const Icon(Icons.lock_outline, color: Colors.grey),
        title: Text(title, style: const TextStyle(color: Colors.grey)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('此模組開發中，敬請期待！')));
        },
      ),
    );
  }

  void _showChangeLog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('更新日誌'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _LogItem(
                ver: "v2.2.0",
                date: "New Feature",
                content:
                    "新增隨身圖書館 (Reference Library)：\n- 支援離線 PDF 閱讀\n- 收錄抗生素與疝氣相關指引\n- 點擊右上角書本圖示即可開啟",
              ),
              _LogItem(
                ver: "v2.1.0",
                date: "2024-05-30",
                content:
                    "新增疝氣完整章節 (Ch25-Ch26)：\n- 腹壁疝氣 (Mesh 層次圖解)\n- 鼠蹊部疝氣 (術式決策)\n- 絞扼性疝氣急診處置",
              ),
              _LogItem(
                ver: "v2.0.0",
                date: "2024-05-28",
                content:
                    "新增肝膽胰完整章節 (Ch20-Ch23)：\n- 胰臟癌 (Whipple, POPF 計算)\n- 膽管癌 (Klatskin, PBD 引流)\n- 膽結石 (急性發作時機)\n- 門脈高壓 (Child-Pugh, HVPG)",
              ),
              // ... 舊的日誌可以保留或摺疊 ...
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('關閉'),
          ),
        ],
      ),
    );
  }
}

class _LogItem extends StatelessWidget {
  final String ver;
  final String date;
  final String content;
  const _LogItem({
    required this.ver,
    required this.date,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ver,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.4)),
        ],
      ),
    );
  }
}
