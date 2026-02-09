// 檔案路徑: lib/logic/specialties/general_surgery.dart

/// Part II: 一般外科 (General Surgery)
/// 涵蓋《住院醫師醫療手冊》Ch9-Ch23
class GeneralSurgeryLogic {
  // ==========================================
  // Ch9: 甲狀腺 (Thyroid)
  // ==========================================
  static List<String> getThyroidIndications() {
    return [
      "1. 惡性/疑似惡性: FNA 確診或懷疑 Ca。",
      "2. 腫瘤過大: 結節 > 4 cm (惡性機率 10-15%)。",
      "3. 壓迫症狀: 影響吞嚥、呼吸。",
      "4. 快速生長: 短期內體積變大。",
      "5. 功能亢進 (Hyperthyroidism): 藥物無效/副作用/復發。",
      "6. 診斷未明: FNA 反覆無結論或 2次 AUS。",
      "7. 影像惡性徵兆: 低回音、邊緣不規則、高>寬、鈣化。",
    ];
  }

  static Map<String, dynamic> assessThyroidPostOp({
    required bool isNeckSwelling,
    required bool isRespiratoryDistress,
    required bool isBleeding,
  }) {
    if (isNeckSwelling && (isRespiratoryDistress || isBleeding)) {
      return {
        "status": "🚨 [極度危險] 術後血腫壓迫氣管 (Hematoma)",
        "action":
            "1. 立即通知主治醫師！\n"
            "2. 【不要等送開刀房】\n"
            "3. 立即在床邊打開傷口、清除血塊減壓！\n"
            "4. 解除壓迫後再送 OR 止血。",
        "isEmergency": true,
      };
    }
    return {
      "status": "✅ 目前無立即壓迫徵象",
      "action": "持續監測 Vital signs 與引流管量。",
      "isEmergency": false,
    };
  }

  static String getHungryBoneWarning() {
    return "🦴 [注意] 飢餓骨症候群 (Hungry Bone Syndrome)\n"
        "原因: 術後 iPTH 驟降，鈣離子大量回流至骨頭。\n"
        "處置: 密切監測 Ca，發生抽筋時給予 IV 鈣劑，必要時調整透析液鈣濃度。";
  }

  static Map<String, String> checkRenalHyperparathyroidism({
    required double iPTH,
    required bool hasSymptoms,
  }) {
    if (iPTH > 800 && hasSymptoms) {
      return {
        "result": "✅ 符合手術適應症",
        "detail":
            "iPTH > 800 pg/mL 且伴隨症狀 (骨痛/搔癢/高血鈣)。\n"
            "建議術式: Total Parathyroidectomy + Autotransplantation。",
      };
    } else if (iPTH > 800) {
      return {"result": "⚠️ 數值達標但無症狀", "detail": "可考慮手術，需會診腎臟科評估透析狀況。"};
    }
    return {"result": "❌ 未達標準", "detail": "持續藥物控制與透析調整，追蹤 iPTH。"};
  }

  // ==========================================
  // Ch10: 乳房外科 (Breast Surgery)
  // ==========================================
  static String getBreastDiseaseGuide(String condition) {
    switch (condition) {
      case '纖維囊腫 (Fibrocystic)':
        return "特徵: 雙側、週期性疼痛、隨月經變化。\n處置: 保守追蹤 + 衛教。疑慮時切片。";
      case '纖維腺瘤 (Fibroadenoma)':
        return "特徵: 20-35歲，無痛、界線清晰。\n處置: 小於 2-3cm 追蹤。快速變大或葉狀腫瘤則切除。";
      case '乳房囊腫 (Cyst)':
        return "影像: 無回音 (Anechoic)。\n處置: 單純囊腫追蹤，有症狀細針抽吸。";
      case '乳突瘤 (Papilloma)':
        return "特徵: 乳頭血性分泌物。\n處置: 建議病灶局部切除。";
      case '男性女乳症 (Gynecomastia)':
        return "鑑別: 排除男性乳癌 (質硬/固定)。\n處置: 藥物調整為主，美觀考量可手術。";
      default:
        return "";
    }
  }

  static Map<String, String> manageMastitis({required bool isLactational}) {
    if (isLactational) {
      return {
        "type": "哺乳期 (Lactational)",
        "action": "1. 抗生素 (Dicloxacillin)。\n2. 持續排空乳汁。\n3. 膿瘍則引流。",
      };
    } else {
      return {
        "type": "非哺乳期 (Chronic)",
        "action": "1. 廣效抗生素 + 引流。\n2. 反覆發作考慮切除乳管系統。",
      };
    }
  }

  // ==========================================
  // Ch12: GERD
  // ==========================================
  static String getGerdDiagnosticGuide(String tool) {
    switch (tool) {
      case '24小時 pH 監測':
        return "黃金標準。確認症狀與酸逆流相關性。";
      case '食道壓力測量 (Manometry)':
        return "決策關鍵。評估蠕動功能 (決定做 Nissen 或 Partial)。";
      case '上消化道內視鏡 (EGD)':
        return "評估食道炎分級、排除癌症。";
      case '鋇劑攝影 (Esophagography)':
        return "評估裂孔疝氣解剖構造。";
      default:
        return "";
    }
  }

  static Map<String, String> chooseFundoplication({
    required bool isPeristalsisNormal,
  }) {
    return isPeristalsisNormal
        ? {"technique": "Nissen (360°)", "desc": "抗逆流效果最強，但術後吞嚥困難風險較高。"}
        : {"technique": "Partial (Toupet/Dor)", "desc": "適用於蠕動功能不良者，減少術後吞嚥困難。"};
  }

  static Map<String, String> classifyHiatalHernia(String type) {
    switch (type) {
      case 'Type I (Sliding)':
        return {"desc": "最常見 (95%)，GEJ 上滑。", "action": "無症狀觀察，藥物無效才手術。"};
      case 'Type II (Paraesophageal)':
        return {"desc": "胃底鑽入胸腔，GEJ 正常。", "action": "建議手術 (預防胃扭轉)。"};
      case 'Type III (Mixed)':
        return {"desc": "Type I + II。", "action": "建議手術。"};
      case 'Type IV (Complex)':
        return {"desc": "大腸或脾臟滑入。", "action": "建議手術。"};
      default:
        return {"desc": "", "action": ""};
    }
  }

  // ==========================================
  // Ch13: 良性胃腫瘤
  // ==========================================
  static String getGastricTumorInfo(String type) {
    switch (type) {
      case 'GIST (間質瘤)':
        return "🚨 來源 Cajal 細胞。\n處置: >2cm 或惡性特徵建議切除。";
      case '增生性息肉 (Hyperplastic)':
        return "最常見，惡性低。";
      case '腺瘤性息肉 (Adenomatous)':
        return "⚠️ 癌前病變，需切除。";
      default:
        return "請參考手冊詳解。";
    }
  }

  static String getGistSurgicalPrinciples() =>
      "1. 首選腹腔鏡楔形切除。\n2. ⚠️ 嚴禁弄破腫瘤 (No rupture)！\n3. R0 切除即可，不需淋巴廓清。";

  static Map<String, dynamic> checkBenignTumorSurgery({
    required double sizeCm,
    required bool isSymptomatic,
    required bool isGistSuspected,
    required bool isGrowthRapid,
  }) {
    if (isSymptomatic)
      return {"needSurgery": true, "reason": "有症狀", "action": "建議手術"};
    if (isGistSuspected && (sizeCm > 2 || isGrowthRapid))
      return {
        "needSurgery": true,
        "reason": "GIST > 2cm 或快長",
        "action": "建議切除 (勿破裂)",
      };
    if (sizeCm > 2)
      return {"needSurgery": true, "reason": "腫瘤 > 2cm", "action": "建議切除"};
    return {"needSurgery": false, "reason": "小且無症狀", "action": "內視鏡追蹤"};
  }

  // ==========================================
  // Ch14: 胃癌
  // ==========================================
  static Map<String, String> decideGastricSurgery({required String location}) {
    if (location.contains('Proximal'))
      return {
        "procedure": "Total Gastrectomy",
        "reconstruction": "Roux-en-Y",
        "note": "需補充 B12",
      };
    return {
      "procedure": "Subtotal Gastrectomy",
      "reconstruction": "Billroth II / Roux-en-Y",
      "note": "D2 淋巴廓清",
    };
  }

  static Map<String, String> getGastricTreatmentPlan({
    required bool isMetastatic,
    required bool isLocallyAdvanced,
  }) {
    if (isMetastatic) return {"strategy": "姑息治療", "detail": "化療/免疫為主"};
    if (isLocallyAdvanced)
      return {"strategy": "圍手術期化療 (FLOT)", "detail": "術前4次 + 術後4次"};
    return {"strategy": "直接手術", "detail": "早期胃癌適用"};
  }

  static String checkGastricPostOp({
    required int postOpDay,
    required bool hasFever,
    required bool isDrainAmylaseHigh,
    required bool isDrainDirty,
  }) {
    if (postOpDay >= 3 && (hasFever || isDrainDirty)) {
      if (isDrainAmylaseHigh) return "🚨 吻合口滲漏 (Leak): NPO, 抗生素, CT";
      return "⚠️ 腹內感染: 建議 CT";
    }
    return "✅ 穩定觀察";
  }

  // ==========================================
  // Ch15: 減重手術
  // ==========================================
  static String getBariatricProcedureInfo(String type) {
    if (type.contains('袖狀')) return "限制型。全球最常見。缺點: GERD 加重。";
    if (type.contains('繞道')) return "混合型。糖尿病效果佳。缺點: 需補維生素，無法照胃鏡。";
    if (type.contains('SASI')) return "雙通道。保留胃鏡路徑。";
    return "";
  }

  static Map<String, String> recommendBariatricProcedure({
    required bool hasSevereGERD,
    required bool hasUncontrolledT2DM,
    required bool needGastricSurveillance,
  }) {
    if (needGastricSurveillance) {
      if (hasSevereGERD)
        return {"recommendation": "難題", "reason": "需照胃鏡但有 GERD。考慮 SASI。"};
      return {"recommendation": "袖狀胃 (SG) / SASI", "reason": "保留胃鏡檢查路徑。"};
    }
    if (hasSevereGERD)
      return {"recommendation": "胃繞道 (RYGB)", "reason": "抗逆流標準術式。"};
    if (hasUncontrolledT2DM)
      return {"recommendation": "胃繞道 / OAGB", "reason": "代謝效果較佳。"};
    return {"recommendation": "袖狀胃 (SG)", "reason": "標準術式，併發症低。"};
  }

  // ==========================================
  // Ch16: 肝臟良性腫瘤
  // ==========================================
  static String getLiverImagingFeatures(String type) {
    if (type.contains('血管瘤'))
      return "Light bulb (T2 High), Peripheral enhancement。";
    if (type.contains('FNH')) return "Central scar (延遲增強)。";
    if (type.contains('HCA')) return "Heterogeneous (脂肪/出血)，無 scar。";
    return "";
  }

  static Map<String, dynamic> checkLiverTumorSurgery({
    required String type,
    required double sizeCm,
    required bool isSymptomatic,
    required bool isMale,
    required bool isDiagnosisUncertain,
  }) {
    if (isDiagnosisUncertain)
      return {"needSurgery": true, "reason": "診斷不明", "action": "切除/切片"};
    if (type.contains('HCA')) {
      if (isMale)
        return {
          "needSurgery": true,
          "reason": "男性 HCA (高惡性風險)",
          "action": "切除",
        };
      if (sizeCm > 5 || isSymptomatic)
        return {"needSurgery": true, "reason": ">5cm 或有症狀", "action": "切除"};
    }
    if (type.contains('血管瘤') && sizeCm > 10 && isSymptomatic)
      return {"needSurgery": true, "reason": "巨大有症狀", "action": "手術"};
    return {"needSurgery": false, "reason": "良性/風險低", "action": "觀察"};
  }

  // ==========================================
  // Ch17: 惡性肝腫瘤 (HCC)
  // ==========================================
  static String getHCCImagingFeatures() =>
      "1. Arterial Hyperenhancement\n2. Portal/Delayed Washout\n3. Capsule / Nodule-in-nodule";

  static Map<String, dynamic> assessLiverResectability({
    required String childPugh,
    required double icg15,
    required bool hasAscites,
    required double bilirubin,
  }) {
    if (childPugh != 'A' || hasAscites || bilirubin > 2.0)
      return {
        "status": "❌ 不宜大範圍切除",
        "reason": "肝功能不佳",
        "action": "考慮移植/消融/TACE",
      };
    if (icg15 < 10)
      return {
        "status": "✅ 大範圍切除 (Major)",
        "reason": "ICG < 10%",
        "action": "Hemi-hepatectomy OK",
      };
    if (icg15 < 20)
      return {
        "status": "⚠️ 分葉切除 (Segmentectomy)",
        "reason": "ICG 10-19%",
        "action": "Segmentectomy OK",
      };
    if (icg15 < 30)
      return {
        "status": "⚠️ 局部切除 (Subseg)",
        "reason": "ICG 20-29%",
        "action": "Limited resection",
      };
    return {
      "status": "❌ 僅能剜除/RFA",
      "reason": "ICG > 30%",
      "action": "Enucleation only",
    };
  }

  static Map<String, String> getHCCTreatmentStrategy(String stage) {
    if (stage.contains('0'))
      return {"patient": "單顆 < 2cm", "treatment": "Resection / RFA"};
    if (stage.contains('A'))
      return {
        "patient": "Milan Criteria 內",
        "treatment": "Resection / Transplant / RFA",
      };
    if (stage.contains('B')) return {"patient": "多發性", "treatment": "TACE"};
    if (stage.contains('C'))
      return {"patient": "血管侵犯/轉移", "treatment": "Systemic (Atezo+Bev)"};
    return {"patient": "末期", "treatment": "Supportive care"};
  }

  static String getSystemicTherapyInfo() =>
      "首選: Atezolizumab + Bevacizumab (IMbrave150)。\n替代: Sorafenib, Lenvatinib。";

  // ==========================================
  // Ch18: 肝臟移植
  // ==========================================
  static String getLTIndicationsInfo(String type) {
    if (type.contains('適應症'))
      return "末期肝病 (Child B/C, MELD>15)、HCC (Milan)、ALF、代謝疾病。";
    if (type.contains('禁忌')) return "活動性感染、肝外腫瘤、嚴重心肺疾病、藥酒癮。";
    if (type.contains('免疫')) return "FK506 / Cyclosporine + MMF + Steroids。";
    return "";
  }

  static Map<String, dynamic> checkHCCCriteriaForTransplant({
    required int tumorCount,
    required double maxTumorSize,
    required double totalTumorSize,
  }) {
    bool milan =
        (tumorCount == 1 && maxTumorSize <= 5) ||
        (tumorCount <= 3 && maxTumorSize <= 3);
    bool ucsf =
        (tumorCount == 1 && maxTumorSize <= 6.5) ||
        (tumorCount <= 3 && totalTumorSize <= 8);
    String rec = milan
        ? "✅ 符合 Milan (健保/屍肝)"
        : (ucsf ? "⚠️ 符合 UCSF (可活體)" : "❌ 超出標準");
    return {"milan": milan, "ucsf": ucsf, "recommendation": rec};
  }

  static Map<String, dynamic> calculateGRWR({
    required double recipientWeightKg,
    required double graftWeightGrams,
  }) {
    double grwr = (graftWeightGrams / recipientWeightKg) / 10.0;
    String status = grwr >= 0.8
        ? "✅ 安全"
        : (grwr >= 0.6 ? "⚠️ 風險邊緣" : "❌ 危險 (SFSS risk)");
    return {
      "value": grwr.toStringAsFixed(2),
      "status": status,
      "msg": "標準 > 0.8%",
    };
  }

  // ==========================================
  // Ch20: 門靜脈高壓
  // ==========================================
  static Map<String, dynamic> calculateChildPugh({
    required int bilirubinPoints,
    required int albuminPoints,
    required int inrPoints,
    required int ascitesPoints,
    required int hePoints,
  }) {
    int score =
        bilirubinPoints + albuminPoints + inrPoints + ascitesPoints + hePoints;
    String grade = score <= 6
        ? "Class A"
        : (score <= 9 ? "Class B" : "Class C");
    return {
      "score": score,
      "grade": grade,
      "survival": score <= 6 ? "預後佳" : "預後差",
    };
  }

  static String interpretHVPG(double v) => v >= 12
      ? "🔴 高危險 (Bleeding Risk)"
      : (v >= 10 ? "🟠 CSPH" : (v >= 6 ? "🟡 Portal HTN" : "🟢 Normal"));
  static String getVaricealBleedingProtocol() =>
      "1. 復甦 (Resuscitation)\n2. 藥物 (Terlipressin) ASAP\n3. 內視鏡 (EVL) 12hr內\n4. 失敗則 TIPS";
  static Map<String, String> calculateAscitesDiuretics({
    required double spironolactoneDose,
  }) {
    return {
      "Spiro": "${spironolactoneDose.round()} mg",
      "Lasix": "${(spironolactoneDose * 0.4).toStringAsFixed(1)} mg",
      "Note": "比例 100:40 維持鉀離子平衡",
    };
  }

  // ==========================================
  // Ch21: 膽囊與總膽管結石
  // ==========================================
  static List<String> getGallbladderSurgicalIndications() => [
    "有症狀結石",
    "無症狀但高風險 (TPN/免疫)",
    "膽囊息肉 >1cm",
    "瓷膽囊",
  ];
  static String getBiliaryDiagnosticInfo(String t) {
    if (t.contains('US')) return "首選。Wall>4mm。";
    if (t.contains('CT')) return "看併發症 (穿孔)。";
    if (t.contains('MRCP')) return "非侵入性看 CBD Stone。";
    if (t.contains('ERCP')) return "診斷兼治療。";
    return "";
  }

  static Map<String, String> getBiliaryManagement({
    required bool isAcute,
    required bool hasCBDStone,
    required bool isHighRisk,
  }) {
    if (hasCBDStone)
      return {
        "strategy": "CBD Stone 處理",
        "action": "ERCP 取石 -> LC (Two-stage) 或 LCBDE + LC",
      };
    if (isAcute) {
      if (isHighRisk)
        return {"strategy": "高風險急性膽囊炎", "action": "PTGBD 引流 -> 穩定後評估"};
      return {"strategy": "急性膽囊炎", "action": "早期 LC (72hr內)"};
    }
    return {"strategy": "有症狀結石", "action": "常規 LC"};
  }

  // ==========================================
  // Ch22: 膽管癌 (CCA)
  // ==========================================
  static List<String> getCCARiskFactors() => [
    "1. PSC (原發性硬化性膽管炎)",
    "2. 肝吸蟲",
    "3. 膽管囊腫",
    "4. 肝內結石",
    "5. B/C 肝",
  ];

  static Map<String, String> getCCATypeInfo(String type) {
    if (type.contains('肝門'))
      return {"desc": "Klatskin tumor (65%)", "surgery": "肝葉切除 + 尾狀葉切除 + 膽道重建"};
    if (type.contains('遠端'))
      return {"desc": "Distal CCA (25%)", "surgery": "Whipple procedure"};
    if (type.contains('肝內'))
      return {"desc": "Intrahepatic (10%)", "surgery": "Hepatectomy"};
    return {"desc": "", "surgery": ""};
  }

  static Map<String, dynamic> checkPreOpDrainage({
    required double bilirubin,
    required bool hasCholangitis,
    required bool isMajorResection,
  }) {
    if (hasCholangitis)
      return {
        "needDrainage": true,
        "reason": "合併膽管炎",
        "action": "強烈建議引流 (控制感染)",
      };
    if (isMajorResection && bilirubin >= 10)
      return {
        "needDrainage": true,
        "reason": "大範圍切除且黃疸>10",
        "action": "建議引流 (降黃疸)",
      };
    return {
      "needDrainage": false,
      "reason": "未達標準",
      "action": "可直接手術 (Upfront surgery)",
    };
  }

  static String getCCAUnresectableCriteria() =>
      "❌ 不可切除:\n1. 遠端轉移 (M1)\n2. 門脈/肝動脈主幹受侵犯且無法重建\n3. 雙側二級膽管侵犯 + 肝萎縮\n4. Child B/C";

  // ==========================================
  // Ch23: 胰臟癌 (Pancreatic Cancer)
  // ==========================================

  static List<String> getPancreaticRiskFactors() {
    return [
      "1. 抽菸 (風險 x 1.7倍)",
      "2. 慢性胰臟炎 (酒精/遺傳)",
      "3. 遺傳突變 (BRCA1/2, Lynch)",
      "4. 胰囊腫、糖尿病、肥胖",
    ];
  }

  static String getPancreaticSymptoms(String location) {
    if (location.contains('頭')) {
      return "📍 胰頭癌 (Pancreatic Head):\n"
          "1. 無痛性黃疸 (Painless jaundice)\n"
          "2. 灰白便 (Acholic stool)\n"
          "3. 茶色尿、皮膚搔癢";
    } else {
      return "📍 胰體尾癌 (Body/Tail):\n"
          "1. 上腹痛 (放射至背部)\n"
          "2. 體重減輕\n"
          "3. 新發生的糖尿病";
    }
  }

  static Map<String, String> getPancreaticTreatmentStrategy(String type) {
    switch (type) {
      case '可切除 (Resectable)':
        return {
          "action": "直接手術 (Upfront Surgery)",
          "detail":
              "胰頭: Whipple procedure\n胰體尾: Distal pancreatectomy + Splenectomy\n術後需輔助化療 (Adjuvant)。",
        };
      case '邊緣可切除 (Borderline)':
        return {
          "action": "新輔助治療 (Neoadjuvant Therapy)",
          "detail": "先化療 (FOLFIRINOX) -> 重新評估 -> 手術。\n目的: 提高 R0 切除率。",
        };
      case '局部晚期 (Locally Advanced)':
        return {
          "action": "系統性化療",
          "detail":
              "mFOLFIRINOX 或 Gemcitabine + Nab-Paclitaxel。\n若反應良好可考慮轉為手術。",
        };
      case '轉移型 (Metastatic)':
        return {
          "action": "姑息性化療 / 精準醫療",
          "detail":
              "BRCA突變: PARP inhibitor (Olaparib)。\nMSI-H: 免疫治療 (Pembrolizumab)。",
        };
      default:
        return {"action": "", "detail": ""};
    }
  }

  /// 胰液滲漏 (POPF) 評估計算機
  static Map<String, dynamic> assessPOPF({
    required double serumAmylase,
    required double drainAmylase,
  }) {
    // 定義: Drain Amylase >= 3 * Serum Amylase
    bool isLeak = drainAmylase >= (serumAmylase * 3);

    if (isLeak) {
      return {
        "isLeak": true,
        "status": "🚨 符合胰液滲漏定義 (POPF)",
        "action":
            "1. 保持引流管暢通。\n2. 考慮 Somatostatin analogues。\n3. 監測感染徵兆 (Fever, CRP)。",
      };
    } else {
      return {"isLeak": false, "status": "✅ 數值正常", "action": "持續觀察引流液性質與量。"};
    }
  }
}
