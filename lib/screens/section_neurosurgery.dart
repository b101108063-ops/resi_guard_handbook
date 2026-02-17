import 'package:flutter/material.dart';
import 'chapters/ch31_neuro_exam.dart'; // 👈 必須確保路徑正確

class NeurosurgerySection extends StatelessWidget {
  const NeurosurgerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        leading: const Icon(Icons.psychology, color: Colors.purple),
        title: const Text("神經外科 (NS)", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("GCS, 顱內出血, 脊椎外傷 (Ch31-)"),
        children: [
          // ✅ 使用模組化的獨立 Tile，它自己會處理 Dialog
          const Ch31NeuroExamTile(), 
          
          // 未來新增 Ch32, Ch33 只要像這樣排下去就好
          // const NSCh32HeadInjuryTile(),
        ],
      ),
    );
  }
}