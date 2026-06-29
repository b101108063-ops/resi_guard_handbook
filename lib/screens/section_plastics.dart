// 檔案路徑: lib/screens/section_plastics.dart
import 'package:flutter/material.dart';
import 'chapters/Ch38_FacialTrauma.dart'; // 匯入剛才做好的顏面外傷
import 'chapters/ch39_hand_trauma.dart';
import 'chapters/ch40_burn_mgmt.dart';

class PlasticSection extends StatelessWidget {
  const PlasticSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(
          Icons.content_cut,
          color: Colors.teal,
        ), // 象徵整形外科顯微手術
        title: const Text(
          "整形外科 (Plastic)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("顏面外傷、燒燙傷、顯微重建"),
        children: [
          // ✅ 將顏面外傷歸類在這裡
          const Ch38_FacialTraumaTile(),
          const Ch39HandTraumaTile(),
          const Ch40BurnMgmtTile(),

          // 未來可以依序塞入其他 PS 章節
          // const Ch38BurnMgmtTile(),
        ],
      ),
    );
  }
}
