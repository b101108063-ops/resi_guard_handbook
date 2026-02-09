import 'package:flutter/material.dart';
import '../logic/specialties/general_surgery.dart'; // 連結一般外科邏輯

class SurgerySection extends StatelessWidget {
  const SurgerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: const Icon(Icons.medical_services, color: Colors.blueGrey),
        title: const Text(
          "一般外科 (GS)",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("甲乳、胃腸、肝膽、移植"),
        children: [
          // Ch9: 甲狀腺
          _buildItem(
            context,
            '甲狀腺手術適應症',
            '結節 > 4cm, 壓迫症狀...',
            Icons.list_alt,
            () => _showThyroidIndicationDialog(context),
          ),
          _buildItem(
            context,
            '🚨 術後血腫急救 (SOS)',
            '頸部腫脹呼吸困難處置',
            Icons.emergency,
            () => _showThyroidEmergencyDialog(context),
            isEmergency: true,
          ),
          _buildItem(
            context,
            '副甲狀腺評估',
            '腎性亢進 iPTH > 800',
            Icons.monitor_heart,
            () => _showParathyroidDialog(context),
          ),

          // Ch10: 乳房
          _buildItem(
            context,
            '良性乳房疾病指引',
            '纖維腺瘤、囊腫、乳腺炎...',
            Icons.female,
            () => _showBreastDialog(context),
          ),

          // Ch12: GERD
          _buildItem(
            context,
            '胃食道逆流 & 裂孔疝氣',
            'Nissen vs Partial 決策',
            Icons.loop,
            () => _showGerdDialog(context),
          ),

          // Ch13: 良性胃腫瘤
          _buildItem(
            context,
            '良性胃腫瘤 & GIST',
            '鑑別診斷與手術時機',
            Icons.science,
            () => _showBenignGastricDialog(context),
          ),

          // Ch14: 胃癌
          _buildItem(
            context,
            '胃癌手術決策',
            '全胃 vs 次全胃、化療時機',
            Icons.restaurant,
            () => _showGastricCancerDialog(context),
          ),

          // Ch15: 代謝減重
          _buildItem(
            context,
            '代謝減重手術 (MBS)',
            'SG vs RYGB 決策',
            Icons.monitor_weight,
            () => _showBariatricDialog(context),
          ),

          // Ch16: 肝臟良性
          _buildItem(
            context,
            '肝臟良性腫瘤',
            '血管瘤, FNH, HCA 鑑別',
            Icons.donut_large,
            () => _showLiverTumorDialog(context),
          ),

          // Ch17: 肝臟惡性 (HCC)
          _buildItem(
            context,
            '惡性肝腫瘤 (HCC)',
            'ICG 切除評估、BCLC 指引',
            Icons.coronavirus,
            () => _showHCCDialog(context),
          ),

          // Ch18: 肝臟移植
          _buildItem(
            context,
            '肝臟移植 (LT)',
            'Milan Criteria & GRWR',
            Icons.diversity_1,
            () => _showLTDialog(context),
          ),

          // Ch20: 門靜脈高壓
          _buildItem(
            context,
            '門靜脈高壓 (Portal HTN)',
            'Child-Pugh, HVPG, 腹水',
            Icons.water,
            () => _showPortalHTNDialog(context),
          ),

          // Ch21: 膽囊與膽道
          _buildItem(
            context,
            '膽囊與總膽管結石',
            '急性發作時機、CBD處置',
            Icons.grain,
            () => _showBiliaryDialog(context),
          ),

          // Ch22: 膽管癌
          _buildItem(
            context,
            '膽管癌 (CCA)',
            'Klatskin, PBD 引流指引',
            Icons.account_tree,
            () => _showCCADialog(context),
          ),

          // Ch23: 胰臟癌 (New!)
          _buildItem(
            context,
            '胰臟癌 (Pancreatic Cancer)',
            'Whipple, POPF 胰漏計算',
            Icons.pie_chart, // 胰臟形狀
            () => _showPancreaticDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    String sub,
    IconData icon,
    VoidCallback onTap, {
    bool isEmergency = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isEmergency ? Colors.red : Colors.blueGrey),
      title: Text(
        title,
        style: TextStyle(
          color: isEmergency ? Colors.red[800] : Colors.black87,
          fontWeight: isEmergency ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: onTap,
      dense: true,
      tileColor: isEmergency ? Colors.red[50] : null,
    );
  }

  void _showResultDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        content: Text(content, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('確定'),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // Dialog 實作區
  // ==========================================

  // --- Ch9 ---
  void _showThyroidIndicationDialog(BuildContext context) {
    var list = GeneralSurgeryLogic.getThyroidIndications();
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('甲狀腺手術適應症'),
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: list
                  .map(
                    (t) => ListTile(
                      leading: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.teal,
                      ),
                      title: Text(t, style: const TextStyle(fontSize: 15)),
                      dense: true,
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('關閉'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showThyroidEmergencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('術後頸部腫脹評估'),
        content: const Text('1. 頸部明顯腫脹\n2. 呼吸困難或躁動\n3. 傷口滲血'),
        backgroundColor: Colors.red[50],
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.assessThyroidPostOp(
                isNeckSwelling: true,
                isRespiratoryDistress: true,
                isBleeding: true,
              );
              _showResultDialog(context, res['status'], res['action']);
            },
            child: const Text('是 (有症狀)', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('否'),
          ),
        ],
      ),
    );
  }

  void _showParathyroidDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('腎性副甲狀腺亢進評估'),
        content: const Text('情境：洗腎病人, iPTH = 950, 伴隨骨痛'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.checkRenalHyperparathyroidism(
                iPTH: 950,
                hasSymptoms: true,
              );
              _showResultDialog(
                context,
                res['result']!,
                "${res['detail']}\n\n${GeneralSurgeryLogic.getHungryBoneWarning()}",
              );
            },
            child: const Text('評估'),
          ),
        ],
      ),
    );
  }

  // --- Ch10 ---
  void _showBreastDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('良性乳房疾病'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🔥 乳腺炎 (Mastitis)'),
                leading: const Icon(Icons.whatshot, color: Colors.redAccent),
                onTap: () {
                  Navigator.pop(ctx);
                  _showMastitisDialog(context);
                },
              ),
              const Divider(),
              ...[
                '纖維腺瘤 (Fibroadenoma)',
                '纖維囊腫 (Fibrocystic)',
                '乳房囊腫 (Cyst)',
                '乳突瘤 (Papilloma)',
                '男性女乳症 (Gynecomastia)',
              ].map(
                (d) => ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.teal,
                  ),
                  title: Text(d),
                  onTap: () {
                    Navigator.pop(ctx);
                    _showResultDialog(
                      context,
                      d,
                      GeneralSurgeryLogic.getBreastDiseaseGuide(d),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMastitisDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('乳腺炎處置'),
        content: const Text('病人是否哺乳中？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.manageMastitis(isLactational: true);
              _showResultDialog(context, res['type']!, res['action']!);
            },
            child: const Text('是'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.manageMastitis(
                isLactational: false,
              );
              _showResultDialog(context, res['type']!, res['action']!);
            },
            child: const Text('否'),
          ),
        ],
      ),
    );
  }

  // --- Ch12 ---
  void _showGerdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('GERD 診療指引'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('✂️ 手術術式決策'),
                subtitle: const Text('Manometry'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showFundoplicationDecision(context);
                },
              ),
              ListTile(
                title: const Text('🔍 術前評估工具'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showDiagnosticList(context);
                },
              ),
              ListTile(
                title: const Text('🗻 裂孔疝氣分類'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showHerniaDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFundoplicationDecision(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('抗逆流手術決策'),
        content: const Text('食道蠕動功能 (Peristalsis)？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.chooseFundoplication(
                isPeristalsisNormal: true,
              );
              _showResultDialog(context, res['technique']!, res['desc']!);
            },
            child: const Text('正常'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.chooseFundoplication(
                isPeristalsisNormal: false,
              );
              _showResultDialog(context, res['technique']!, res['desc']!);
            },
            child: const Text('不良'),
          ),
        ],
      ),
    );
  }

  void _showDiagnosticList(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('術前評估工具'),
        children:
            [
                  '24小時 pH 監測',
                  '食道壓力測量 (Manometry)',
                  '上消化道內視鏡 (EGD)',
                  '鋇劑攝影 (Esophagography)',
                ]
                .map(
                  (t) => ListTile(
                    title: Text(t),
                    subtitle: Text(
                      GeneralSurgeryLogic.getGerdDiagnosticGuide(t),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  void _showHerniaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('裂孔疝氣分類'),
        children:
            [
              'Type I (Sliding)',
              'Type II (Paraesophageal)',
              'Type III (Mixed)',
              'Type IV (Complex)',
            ].map((t) {
              var info = GeneralSurgeryLogic.classifyHiatalHernia(t);
              return ListTile(
                title: Text(t),
                subtitle: Text("${info['desc']}\n👉 ${info['action']}"),
              );
            }).toList(),
      ),
    );
  }

  // --- Ch13 ---
  void _showBenignGastricDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('良性胃腫瘤'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🔬 腫瘤分類'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showTumorClassDialog(context);
                },
              ),
              ListTile(
                title: const Text('⚖️ 適應症判斷'),
                onTap: () {
                  Navigator.pop(ctx);
                  var res = GeneralSurgeryLogic.checkBenignTumorSurgery(
                    sizeCm: 2.5,
                    isSymptomatic: false,
                    isGistSuspected: true,
                    isGrowthRapid: false,
                  );
                  _showResultDialog(
                    context,
                    res['needSurgery'] ? '建議手術' : '建議追蹤',
                    "範例 (2.5cm GIST):\n${res['reason']}\n\n${res['action']}",
                  );
                },
              ),
              ListTile(
                title: const Text('🚫 GIST 禁忌'),
                leading: const Icon(Icons.do_not_touch, color: Colors.red),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    'GIST 手術關鍵',
                    GeneralSurgeryLogic.getGistSurgicalPrinciples(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTumorClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('腫瘤分類'),
        children:
            [
                  '增生性息肉 (Hyperplastic)',
                  '腺瘤性息肉 (Adenomatous)',
                  '胃底腺息肉 (Fundic gland)',
                  'GIST (間質瘤)',
                  '異位胰臟 (Ectopic Pancreas)',
                ]
                .map(
                  (t) => ListTile(
                    title: Text(t),
                    subtitle: Text(GeneralSurgeryLogic.getGastricTumorInfo(t)),
                    dense: true,
                  ),
                )
                .toList(),
      ),
    );
  }

  // --- Ch14 ---
  void _showGastricCancerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('胃癌 (Gastric Cancer)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🔪 術式選擇'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showGastricSurgeryDialog(context);
                },
              ),
              ListTile(
                title: const Text('💊 治療策略'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showGastricStrategyDialog(context);
                },
              ),
              ListTile(
                title: const Text('🚨 術後滲漏評估'),
                onTap: () {
                  Navigator.pop(ctx);
                  var msg = GeneralSurgeryLogic.checkGastricPostOp(
                    postOpDay: 4,
                    hasFever: true,
                    isDrainAmylaseHigh: true,
                    isDrainDirty: true,
                  );
                  _showResultDialog(context, '高風險警示', msg);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGastricSurgeryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('腫瘤位置'),
        children: ['Proximal 1/3 (近端)', 'Middle 1/3 (中端)', 'Distal 1/3 (遠端)']
            .map(
              (loc) => ListTile(
                title: Text(loc),
                onTap: () {
                  Navigator.pop(ctx);
                  var res = GeneralSurgeryLogic.decideGastricSurgery(
                    location: loc,
                  );
                  _showResultDialog(
                    context,
                    res['procedure']!,
                    "重建：${res['reconstruction']}\n\n注意：${res['note']}",
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }

  void _showGastricStrategyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('臨床分期'),
        content: const Text('是否為局部晚期 (cT3/4 或 N+)？'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.getGastricTreatmentPlan(
                isMetastatic: false,
                isLocallyAdvanced: true,
              );
              _showResultDialog(context, res['strategy']!, res['detail']!);
            },
            child: const Text('是'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              var res = GeneralSurgeryLogic.getGastricTreatmentPlan(
                isMetastatic: false,
                isLocallyAdvanced: false,
              );
              _showResultDialog(context, res['strategy']!, res['detail']!);
            },
            child: const Text('否'),
          ),
        ],
      ),
    );
  }

  // --- Ch15 ---
  void _showBariatricDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('代謝及減重手術'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('📚 術式介紹'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBariatricInfoDialog(context);
                },
              ),
              ListTile(
                title: const Text('🤔 術式決策 (互動)'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBariatricDecisionDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBariatricInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('減重術式'),
        children:
            [
                  '袖狀胃切除 (SG)',
                  '胃繞道 (RYGB)',
                  '單吻合胃繞道 (OAGB)',
                  'SASI 手術',
                  '胃內水球 (IGB)',
                ]
                .map(
                  (t) => ListTile(
                    title: Text(t),
                    subtitle: Text(
                      GeneralSurgeryLogic.getBariatricProcedureInfo(t),
                    ),
                    dense: true,
                  ),
                )
                .toList(),
      ),
    );
  }

  void _showBariatricDecisionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('術式決策'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('情境 A: 嚴重 GERD'),
              onTap: () {
                Navigator.pop(ctx);
                var res = GeneralSurgeryLogic.recommendBariatricProcedure(
                  hasSevereGERD: true,
                  hasUncontrolledT2DM: false,
                  needGastricSurveillance: false,
                );
                _showResultDialog(
                  context,
                  res['recommendation']!,
                  res['reason']!,
                );
              },
            ),
            ListTile(
              title: const Text('情境 B: 需照胃鏡'),
              onTap: () {
                Navigator.pop(ctx);
                var res = GeneralSurgeryLogic.recommendBariatricProcedure(
                  hasSevereGERD: false,
                  hasUncontrolledT2DM: true,
                  needGastricSurveillance: true,
                );
                _showResultDialog(
                  context,
                  res['recommendation']!,
                  res['reason']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Ch16 ---
  void _showLiverTumorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('肝臟良性腫瘤'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🩻 MRI 鑑別'),
                leading: const Icon(Icons.image_search, color: Colors.purple),
                onTap: () {
                  Navigator.pop(ctx);
                  _showLiverImagingDialog(context);
                },
              ),
              ListTile(
                title: const Text('⚖️ 適應症計算'),
                leading: const Icon(Icons.calculate, color: Colors.teal),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _LiverTumorCalculator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLiverImagingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('MRI 影像特徵'),
        children: ['肝臟血管瘤 (Hemangioma)', '局部結節性增生 (FNH)', '肝細胞腺瘤 (HCA)']
            .map(
              (t) => ListTile(
                title: Text(t),
                subtitle: Text(GeneralSurgeryLogic.getLiverImagingFeatures(t)),
                dense: true,
              ),
            )
            .toList(),
      ),
    );
  }

  // --- Ch17 ---
  void _showHCCDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('惡性肝腫瘤 (HCC)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🩻 典型影像'),
                subtitle: const Text('Washout'),
                leading: const Icon(Icons.image_search, color: Colors.blue),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    'HCC 影像特徵',
                    GeneralSurgeryLogic.getHCCImagingFeatures(),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('🔪 可切除評估 (ICG)'),
                subtitle: const Text('Makuuchi Criteria'),
                leading: const Icon(Icons.content_cut, color: Colors.redAccent),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _ResectabilityCalculator(),
                  );
                },
              ),
              ListTile(
                title: const Text('🌳 BCLC 策略'),
                leading: const Icon(Icons.account_tree, color: Colors.green),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBCLCDialog(context);
                },
              ),
              ListTile(
                title: const Text('💊 藥物治療'),
                leading: const Icon(Icons.medication, color: Colors.purple),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    '全身性藥物',
                    GeneralSurgeryLogic.getSystemicTherapyInfo(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBCLCDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('BCLC 分期治療'),
        children:
            [
                  'Stage 0 (Very Early)',
                  'Stage A (Early)',
                  'Stage B (Intermediate)',
                  'Stage C (Advanced)',
                  'Stage D (Terminal)',
                ]
                .map(
                  (s) => ListTile(
                    title: Text(s),
                    onTap: () {
                      var res = GeneralSurgeryLogic.getHCCTreatmentStrategy(s);
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(s),
                          content: Text(
                            "病人：${res['patient']}\n\n治療：${res['treatment']}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('了解'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  // --- Ch18 ---
  void _showLTDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('肝臟移植 (Liver Transplant)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('📚 適應症與禁忌'),
                leading: const Icon(Icons.menu_book, color: Colors.blue),
                onTap: () {
                  Navigator.pop(ctx);
                  _showLTInfoDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('📏 移植標準 (Milan/UCSF)'),
                leading: const Icon(Icons.straighten, color: Colors.teal),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _HCCCriteriaCalculator(),
                  );
                },
              ),
              ListTile(
                title: const Text('⚖️ 活體捐贈 (GRWR)'),
                leading: const Icon(Icons.scale, color: Colors.orange),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _GRWRCalculator(),
                  );
                },
              ),
              ListTile(
                title: const Text('💊 免疫抑制'),
                leading: const Icon(Icons.medication, color: Colors.purple),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    '免疫抑制',
                    GeneralSurgeryLogic.getLTIndicationsInfo('免疫抑制'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLTInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('移植指引'),
        children: ['適應症 (Indications)', '禁忌症 (Contraindications)']
            .map(
              (t) => ListTile(
                title: Text(
                  t,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(GeneralSurgeryLogic.getLTIndicationsInfo(t)),
              ),
            )
            .toList(),
      ),
    );
  }

  // --- Ch20 ---
  void _showPortalHTNDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('門靜脈高壓 (Portal HTN)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('🧮 Child-Pugh 分級'),
                leading: const Icon(Icons.calculate, color: Colors.blue),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _ChildPughCalculator(),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('🌡️ HVPG 壓力解讀'),
                leading: const Icon(Icons.speed, color: Colors.redAccent),
                onTap: () {
                  Navigator.pop(ctx);
                  _showHVPGDialog(context);
                },
              ),
              ListTile(
                title: const Text('🩸 急性出血處置'),
                leading: const Icon(Icons.bloodtype, color: Colors.red),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    '急性出血標準流程',
                    GeneralSurgeryLogic.getVaricealBleedingProtocol(),
                  );
                },
              ),
              ListTile(
                title: const Text('💧 腹水利尿劑計算'),
                leading: const Icon(Icons.water_drop, color: Colors.teal),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _AscitesCalculator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHVPGDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('HVPG 臨床意義'),
        children: [5.0, 8.0, 10.0, 14.0]
            .map(
              (v) => ListTile(
                title: Text("${v.toInt()} mmHg"),
                subtitle: Text(GeneralSurgeryLogic.interpretHVPG(v)),
                leading: Icon(
                  Icons.circle,
                  color: v >= 12
                      ? Colors.red
                      : (v >= 10 ? Colors.orange : Colors.green),
                  size: 12,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // --- Ch21 ---
  void _showBiliaryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('膽囊與總膽管結石'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('📚 手術適應症'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBiliaryIndicationsDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('🔍 診斷工具比較'),
                subtitle: const Text('US, CT, MRCP, ERCP'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showBiliaryDiagnosticDialog(context);
                },
              ),
              ListTile(
                title: const Text('⚖️ 處置策略計算'),
                subtitle: const Text('急性期? CBD Stone?'),
                leading: const Icon(Icons.calculate, color: Colors.teal),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _BiliaryManagementCalculator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBiliaryIndicationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('手術適應症'),
        children: GeneralSurgeryLogic.getGallbladderSurgicalIndications()
            .map(
              (t) => ListTile(
                title: Text(t, style: const TextStyle(fontSize: 14)),
                dense: true,
                leading: const Icon(Icons.check, size: 16),
              ),
            )
            .toList(),
      ),
    );
  }

  void _showBiliaryDiagnosticDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('診斷工具比較'),
        children:
            ['腹部超音波 (US)', '電腦斷層 (CT)', '磁振膽道攝影 (MRCP)', '內視鏡逆行性膽胰管攝影 (ERCP)']
                .map(
                  (t) => ListTile(
                    title: Text(t),
                    subtitle: Text(
                      GeneralSurgeryLogic.getBiliaryDiagnosticInfo(t),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  // --- Ch22 ---
  void _showCCADialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('膽管癌 (CCA)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('📚 危險因子與分類'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showCCAInfoDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('🔪 手術策略'),
                subtitle: const Text('Klatskin vs Distal'),
                leading: const Icon(Icons.content_cut, color: Colors.blue),
                onTap: () {
                  Navigator.pop(ctx);
                  _showCCATreatmentDialog(context);
                },
              ),
              ListTile(
                title: const Text('🧪 術前引流評估 (PBD)'),
                subtitle: const Text('Bilirubin > 10?'),
                leading: const Icon(Icons.science, color: Colors.teal),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _CCADrainageCalculator(),
                  );
                },
              ),
              ListTile(
                title: const Text('🚫 手術禁忌症'),
                leading: const Icon(Icons.block, color: Colors.red),
                onTap: () {
                  Navigator.pop(ctx);
                  _showResultDialog(
                    context,
                    '不可切除標準',
                    GeneralSurgeryLogic.getCCAUnresectableCriteria(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCCAInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('危險因子'),
        children: GeneralSurgeryLogic.getCCARiskFactors()
            .map(
              (t) => ListTile(
                title: Text(t),
                dense: true,
                leading: const Icon(Icons.warning_amber, size: 16),
              ),
            )
            .toList(),
      ),
    );
  }

  void _showCCATreatmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('腫瘤位置與術式'),
        children:
            ['肝門型 (Perihilar / Klatskin)', '遠端型 (Distal)', '肝內型 (Intrahepatic)']
                .map(
                  (t) => ListTile(
                    title: Text(t),
                    onTap: () {
                      var info = GeneralSurgeryLogic.getCCATypeInfo(t);
                      _showResultDialog(
                        context,
                        t,
                        "${info['desc']}\n\n${info['surgery']}",
                      );
                    },
                  ),
                )
                .toList(),
      ),
    );
  }

  // --- Ch23 (New!) ---
  void _showPancreaticDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('胰臟癌 (Pancreatic Cancer)'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('📚 危險因子與症狀'),
                onTap: () {
                  Navigator.pop(ctx);
                  _showPancreaticInfoDialog(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('🔪 治療策略'),
                subtitle: const Text('Resectable vs Borderline'),
                leading: const Icon(Icons.content_cut, color: Colors.blue),
                onTap: () {
                  Navigator.pop(ctx);
                  _showPancreaticTreatmentDialog(context);
                },
              ),
              ListTile(
                title: const Text('🚨 術後胰漏計算 (POPF)'),
                subtitle: const Text('Amylase 3x Rule'),
                leading: const Icon(Icons.water_drop, color: Colors.redAccent),
                onTap: () {
                  Navigator.pop(ctx);
                  showDialog(
                    context: context,
                    builder: (c) => const _POPFCalculator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPancreaticInfoDialog(BuildContext context) {
    var risks = GeneralSurgeryLogic.getPancreaticRiskFactors();
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('臨床特徵'),
        children: [
          const ListTile(
            title: Text('危險因子', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...risks.map(
            (t) => ListTile(
              title: Text(t),
              dense: true,
              leading: const Icon(Icons.warning, size: 16),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              '症狀 (依位置)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: const Text('胰頭 (Head)'),
            subtitle: Text(GeneralSurgeryLogic.getPancreaticSymptoms('頭')),
            onTap: () => _showResultDialog(
              context,
              '胰頭癌',
              GeneralSurgeryLogic.getPancreaticSymptoms('頭'),
            ),
          ),
          ListTile(
            title: const Text('胰體尾 (Body/Tail)'),
            subtitle: Text(GeneralSurgeryLogic.getPancreaticSymptoms('尾')),
            onTap: () => _showResultDialog(
              context,
              '胰體尾癌',
              GeneralSurgeryLogic.getPancreaticSymptoms('尾'),
            ),
          ),
        ],
      ),
    );
  }

  void _showPancreaticTreatmentDialog(BuildContext context) {
    var types = [
      '可切除 (Resectable)',
      '邊緣可切除 (Borderline)',
      '局部晚期 (Locally Advanced)',
      '轉移型 (Metastatic)',
    ];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('治療策略'),
        children: types
            .map(
              (t) => ListTile(
                title: Text(t),
                onTap: () {
                  var info = GeneralSurgeryLogic.getPancreaticTreatmentStrategy(
                    t,
                  );
                  _showResultDialog(
                    context,
                    t,
                    "${info['action']}\n\n${info['detail']}",
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

// ==========================================
// 獨立計算機 Widgets (Ch9-Ch23 All Calculators)
// ==========================================

class _LiverTumorCalculator extends StatefulWidget {
  const _LiverTumorCalculator();
  @override
  State<_LiverTumorCalculator> createState() => _LiverTumorCalculatorState();
}

class _LiverTumorCalculatorState extends State<_LiverTumorCalculator> {
  String _type = '肝臟血管瘤 (Hemangioma)';
  final _sizeController = TextEditingController();
  bool _isSymptomatic = false;
  bool _isMale = false;
  bool _isUncertain = false;
  Map<String, dynamic>? _result;
  void _calculate() {
    double size = double.tryParse(_sizeController.text) ?? 0;
    setState(() {
      _result = GeneralSurgeryLogic.checkLiverTumorSurgery(
        type: _type,
        sizeCm: size,
        isSymptomatic: _isSymptomatic,
        isMale: _isMale,
        isDiagnosisUncertain: _isUncertain,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('良性腫瘤手術評估'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _type,
              items: ['肝臟血管瘤 (Hemangioma)', '局部結節性增生 (FNH)', '肝細胞腺瘤 (HCA)']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.split(' ')[0]),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() {
                _type = v!;
                _result = null;
              }),
            ),
            TextField(
              controller: _sizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '腫瘤大小 (cm)'),
            ),
            CheckboxListTile(
              title: const Text('有症狀'),
              value: _isSymptomatic,
              onChanged: (v) => setState(() {
                _isSymptomatic = v!;
              }),
            ),
            if (_type.contains('HCA'))
              CheckboxListTile(
                title: const Text('男性'),
                value: _isMale,
                onChanged: (v) => setState(() {
                  _isMale = v!;
                }),
              ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('評估')),
            if (_result != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _result!['action'],
                  style: TextStyle(
                    color: _result!['needSurgery'] ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResectabilityCalculator extends StatefulWidget {
  const _ResectabilityCalculator();
  @override
  State<_ResectabilityCalculator> createState() =>
      _ResectabilityCalculatorState();
}

class _ResectabilityCalculatorState extends State<_ResectabilityCalculator> {
  String _childPugh = 'A';
  final _icgController = TextEditingController();
  final _biliController = TextEditingController();
  bool _hasAscites = false;
  Map<String, dynamic>? _result;
  void _calculate() {
    double icg = double.tryParse(_icgController.text) ?? 0;
    double bili = double.tryParse(_biliController.text) ?? 1.0;
    setState(() {
      _result = GeneralSurgeryLogic.assessLiverResectability(
        childPugh: _childPugh,
        icg15: icg,
        hasAscites: _hasAscites,
        bilirubin: bili,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('肝切除評估 (Makuuchi)'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _childPugh,
              items: ['A', 'B', 'C']
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text("Class $e")),
                  )
                  .toList(),
              onChanged: (v) => setState(() {
                _childPugh = v!;
              }),
            ),
            TextField(
              controller: _icgController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'ICG-15 (%)'),
            ),
            TextField(
              controller: _biliController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Bilirubin'),
            ),
            CheckboxListTile(
              title: const Text('有腹水'),
              value: _hasAscites,
              onChanged: (v) => setState(() {
                _hasAscites = v!;
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('評估')),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                color: _result!['status'].contains("❌")
                    ? Colors.red[50]
                    : Colors.green[50],
                child: Text(
                  "${_result!['status']}\n\n${_result!['action']}",
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('關閉'),
        ),
      ],
    );
  }
}

class _HCCCriteriaCalculator extends StatefulWidget {
  const _HCCCriteriaCalculator();
  @override
  State<_HCCCriteriaCalculator> createState() => _HCCCriteriaCalculatorState();
}

class _HCCCriteriaCalculatorState extends State<_HCCCriteriaCalculator> {
  final _countCtrl = TextEditingController(text: "1");
  final _maxSizeCtrl = TextEditingController();
  final _totalSizeCtrl = TextEditingController();
  Map<String, dynamic>? _result;
  void _calculate() {
    int c = int.tryParse(_countCtrl.text) ?? 1;
    double m = double.tryParse(_maxSizeCtrl.text) ?? 0;
    double t = double.tryParse(_totalSizeCtrl.text) ?? m;
    setState(() {
      _result = GeneralSurgeryLogic.checkHCCCriteriaForTransplant(
        tumorCount: c,
        maxTumorSize: m,
        totalTumorSize: t,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('移植標準評估'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _countCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '腫瘤顆數'),
            ),
            TextField(
              controller: _maxSizeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '最大腫瘤 (cm)'),
            ),
            TextField(
              controller: _totalSizeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '腫瘤總和 (cm)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('檢查')),
            if (_result != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _result!['recommendation'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _result!['recommendation'].contains("✅")
                        ? Colors.green[800]
                        : Colors.red[800],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GRWRCalculator extends StatefulWidget {
  const _GRWRCalculator();
  @override
  State<_GRWRCalculator> createState() => _GRWRCalculatorState();
}

class _GRWRCalculatorState extends State<_GRWRCalculator> {
  final _recipientWeightCtrl = TextEditingController();
  final _graftWeightCtrl = TextEditingController();
  Map<String, dynamic>? _result;
  void _calculate() {
    double r = double.tryParse(_recipientWeightCtrl.text) ?? 0;
    double g = double.tryParse(_graftWeightCtrl.text) ?? 0;
    if (r > 0)
      setState(() {
        _result = GeneralSurgeryLogic.calculateGRWR(
          recipientWeightKg: r,
          graftWeightGrams: g,
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('GRWR 計算機'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _recipientWeightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '受贈者體重 (kg)'),
            ),
            TextField(
              controller: _graftWeightCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Graft 重量 (g)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('計算')),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                color: _result!['status'].contains("✅")
                    ? Colors.green[50]
                    : Colors.red[50],
                child: Text(
                  "GRWR: ${_result!['value']}%\n${_result!['status']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChildPughCalculator extends StatefulWidget {
  const _ChildPughCalculator();
  @override
  State<_ChildPughCalculator> createState() => _ChildPughCalculatorState();
}

class _ChildPughCalculatorState extends State<_ChildPughCalculator> {
  int _bili = 1, _alb = 1, _inr = 1, _ascites = 1, _he = 1;
  Map<String, dynamic>? _result;
  void _calculate() {
    setState(() {
      _result = GeneralSurgeryLogic.calculateChildPugh(
        bilirubinPoints: _bili,
        albuminPoints: _alb,
        inrPoints: _inr,
        ascitesPoints: _ascites,
        hePoints: _he,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Child-Pugh Score'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropdown("Bilirubin", _bili, [
              "< 2",
              "2 - 3",
              "> 3",
            ], (v) => _bili = v),
            _buildDropdown("Albumin", _alb, [
              "> 3.5",
              "2.8 - 3.5",
              "< 2.8",
            ], (v) => _alb = v),
            _buildDropdown("INR", _inr, [
              "< 1.7",
              "1.7 - 2.3",
              "> 2.3",
            ], (v) => _inr = v),
            _buildDropdown("腹水", _ascites, [
              "無",
              "輕微",
              "嚴重",
            ], (v) => _ascites = v),
            _buildDropdown("肝腦病變", _he, [
              "無",
              "Gr 1-2",
              "Gr 3-4",
            ], (v) => _he = v),
            const SizedBox(height: 15),
            ElevatedButton(onPressed: _calculate, child: const Text('計算')),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(12),
                color: Colors.blue.shade50,
                child: Text(
                  "${_result!['score']} 分\n${_result!['grade']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String l, int v, List<String> o, Function(int) c) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(l),
          DropdownButton<int>(
            value: v,
            items: List.generate(
              3,
              (i) => DropdownMenuItem(value: i + 1, child: Text(o[i])),
            ),
            onChanged: (val) => setState(() => c(val!)),
          ),
        ],
      );
}

class _AscitesCalculator extends StatefulWidget {
  const _AscitesCalculator();
  @override
  State<_AscitesCalculator> createState() => _AscitesCalculatorState();
}

class _AscitesCalculatorState extends State<_AscitesCalculator> {
  final _spiroCtrl = TextEditingController(text: "100");
  Map<String, String>? _result;
  void _calculate() {
    double s = double.tryParse(_spiroCtrl.text) ?? 100;
    setState(() {
      _result = GeneralSurgeryLogic.calculateAscitesDiuretics(
        spironolactoneDose: s,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('腹水利尿劑配比'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _spiroCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Spironolactone (mg)',
              ),
              onChanged: (v) => _calculate(),
            ),
            if (_result != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.teal.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spiro: ${_result!['Spiro']}"),
                    Text(
                      "Lasix: ${_result!['Lasix']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BiliaryManagementCalculator extends StatefulWidget {
  const _BiliaryManagementCalculator();
  @override
  State<_BiliaryManagementCalculator> createState() =>
      _BiliaryManagementCalculatorState();
}

class _BiliaryManagementCalculatorState
    extends State<_BiliaryManagementCalculator> {
  bool _isAcute = false;
  bool _hasCBD = false;
  bool _isHighRisk = false;
  Map<String, String>? _result;
  void _calculate() {
    setState(() {
      _result = GeneralSurgeryLogic.getBiliaryManagement(
        isAcute: _isAcute,
        hasCBDStone: _hasCBD,
        isHighRisk: _isHighRisk,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('膽道處置策略'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('急性膽囊炎'),
              value: _isAcute,
              onChanged: (v) => setState(() {
                _isAcute = v!;
              }),
            ),
            CheckboxListTile(
              title: const Text('合併 CBD Stone'),
              value: _hasCBD,
              onChanged: (v) => setState(() {
                _hasCBD = v!;
              }),
            ),
            if (_isAcute)
              CheckboxListTile(
                title: const Text('高風險 (High Risk)'),
                value: _isHighRisk,
                activeColor: Colors.red,
                onChanged: (v) => setState(() {
                  _isHighRisk = v!;
                }),
              ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('決定策略')),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(12),
                color: Colors.green.shade50,
                child: Text(
                  _result!['action']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CCADrainageCalculator extends StatefulWidget {
  const _CCADrainageCalculator();
  @override
  State<_CCADrainageCalculator> createState() => _CCADrainageCalculatorState();
}

class _CCADrainageCalculatorState extends State<_CCADrainageCalculator> {
  final _biliCtrl = TextEditingController();
  bool _hasCholangitis = false;
  bool _isMajor = true;
  Map<String, dynamic>? _result;
  void _calculate() {
    double b = double.tryParse(_biliCtrl.text) ?? 0;
    setState(() {
      _result = GeneralSurgeryLogic.checkPreOpDrainage(
        bilirubin: b,
        hasCholangitis: _hasCholangitis,
        isMajorResection: _isMajor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('術前膽道引流 (PBD)'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _biliCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Bilirubin (mg/dL)',
              ),
            ),
            CheckboxListTile(
              title: const Text('合併膽管炎'),
              value: _hasCholangitis,
              onChanged: (v) => setState(() {
                _hasCholangitis = v!;
              }),
            ),
            CheckboxListTile(
              title: const Text('預計大範圍肝切除'),
              value: _isMajor,
              onChanged: (v) => setState(() {
                _isMajor = v!;
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _calculate, child: const Text('評估')),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                color: _result!['needDrainage']
                    ? Colors.red[50]
                    : Colors.green[50],
                child: Text(
                  _result!['action'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _result!['needDrainage'] ? Colors.red : Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Ch23 Calculator (New!)
class _POPFCalculator extends StatefulWidget {
  const _POPFCalculator();
  @override
  State<_POPFCalculator> createState() => _POPFCalculatorState();
}

class _POPFCalculatorState extends State<_POPFCalculator> {
  final _serumCtrl = TextEditingController();
  final _drainCtrl = TextEditingController();
  Map<String, dynamic>? _result;

  void _calculate() {
    double s = double.tryParse(_serumCtrl.text) ?? 0;
    double d = double.tryParse(_drainCtrl.text) ?? 0;
    if (s > 0) {
      setState(() {
        _result = GeneralSurgeryLogic.assessPOPF(
          serumAmylase: s,
          drainAmylase: d,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('術後胰液滲漏 (POPF)'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '診斷標準: Drain Amylase ≥ 3倍 Serum',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _serumCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '血清 Amylase (U/L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _drainCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '引流液 Amylase (U/L)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('計算風險'),
            ),
            if (_result != null)
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _result!['isLeak']
                      ? Colors.red.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      _result!['status'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _result!['isLeak'] ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(_result!['action'], textAlign: TextAlign.center),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('關閉'),
        ),
      ],
    );
  }
}
