import 'package:flutter/material.dart';
import 'chapters/ch31_neuro_exam.dart'; // 👈 必須確保路徑正確
import 'chapters/ch32_brain_tumor.dart'; // 👈 匯入新檔案
import 'chapters/ch32_2_pituitarty.dart'; // 👈 匯入新檔案
import 'chapters/ch32_3_spinal_tumor.dart'; // 👈 匯入新檔案
import 'chapters/ch33_1_ich.dart';
import 'chapters/ch33_2_ischemic_stroke.dart'; // 👈 匯入新檔案
import 'chapters/ch33_3_avm.dart'; // 👈 匯入新檔案
import 'chapters/ch33_4_aneurysm.dart'; // 👈 匯入新檔案
import 'chapters/ch34_1_cervical_disc.dart'; // 👈 匯入新檔案
import 'chapters/ch34_2_lumbar_disc.dart'; // 👈 匯入新檔案
import 'chapters/ch35_1_cerebral_abscess.dart'; // 👈 匯入新檔案
import 'chapters/ch35_2_spine_infection.dart'; // 👈 匯入新檔案
import 'chapters/ch37_1_epilepsy.dart'; // 👈 匯入新檔案
import 'chapters/ch37_2_hydrocephalus.dart'; // 👈 匯入新檔案

class NeurosurgerySection extends StatelessWidget {
  const NeurosurgerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(Icons.psychology, color: Colors.purple),
        title: const Text(
          "神經外科 (NS)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("GCS, 顱內出血, 脊椎外傷 (Ch31-)"),
        children: [
          // ✅ 使用模組化的獨立 Tile，它自己會處理 Dialog
          const Ch31NeuroExamTile(),
          const Ch32BrainTumorTile(),
          const Ch32_2_PituitaryTile(),
          const Ch32_3SpinalTumorTile(),
          const Ch33_1ICHTile(),
          const Ch33_2IschemicStrokeTile(),
          const Ch33_3AVMTile(),
          const Ch33_4AneurysmTile(),
          const Ch34_1CervicalDiscTile(),
          const Ch34_2LumbarDiscTile(),
          const Ch35_1CerebralAbscessTile(),
          const Ch35_2SpineInfectionTile(),
          const Ch37_1EpilepsyTile(),
          const Ch37_2HydrocephalusTile(),
        ],
      ),
    );
  }
}
