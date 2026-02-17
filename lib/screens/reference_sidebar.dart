import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // ⚠️ 關鍵：這行一定要有！

class ReferenceSidebar extends StatelessWidget {
  const ReferenceSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300, // 設定側邊欄寬度
      child: Column(
        children: [
          // 1. 標題區
          Container(
            height: 100,
            color: Colors.teal,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            alignment: Alignment.centerLeft,
            child: const Row(
              children: [
                Icon(Icons.library_books, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  "隨身圖書館",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 2. 檔案列表區
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionHeader("Ch2 抗生素與感染"),
                _buildPdfItem(
                  context,
                  "亞東抗生素指引 (院內版)",
                  "assets/pdfs/femh_surg_2025.pdf", // 請確認 assets 資料夾有此檔案
                ),
                _buildPdfItem(
                  context,
                  "Surgical Prophylaxis (ASHP)",
                  "assets/pdfs/femh_surg_2025.pdf",
                ),
                _buildSectionHeader("Ch25-26 疝氣手術"),
                _buildPdfItem(
                  context,
                  "EHS Hernia Guidelines 2024",
                  "assets/pdfs/femh_surg_2025.pdf",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 小標題樣式
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  // PDF 選項樣式
  Widget _buildPdfItem(BuildContext context, String title, String assetPath) {
    return ListTile(
      leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
      onTap: () => _openLocalPdf(context, assetPath),
    );
  }

  // 開啟邏輯
  Future<void> _openLocalPdf(BuildContext context, String assetPath) async {
    // 在 Web 版，Asset 可以直接當作網址打開
    // 路徑規則: assets/原始路徑
    String webUrl = "assets/$assetPath";

    final Uri url = Uri.parse(webUrl);

    // 這裡呼叫 launchUrl，需要最上面的 import 才能運作
    if (!await launchUrl(url)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('無法開啟檔案，請確認檔案是否存在')));
      }
    }
  }
}
