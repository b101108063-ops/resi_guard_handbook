// 檔案路徑: lib/logic/general_principles.dart

class GeneralPrinciples {
  // ==========================================
  // 1. 預防性抗生素 (Updated!)
  // ==========================================

  /// 計算 Cefazolin 劑量 (依據亞東手冊 Ch2)
  static Map<String, dynamic> calculateCefazolinDose(double weight) {
    if (weight > 120) {
      return {"dose": "3 g", "note": "體重 > 120 kg"};
    } else if (weight > 80) {
      return {"dose": "2 g", "note": "體重 81 - 120 kg"};
    } else {
      return {"dose": "1 g", "note": "體重 ≤ 80 kg"};
    }
  }

  /// 評估是否需要術中追加 (Re-dosing)
  static Map<String, String> checkRedosing({
    required double hours,
    required double bloodLoss,
  }) {
    bool timeTrigger = hours > 3.0;
    bool bloodTrigger = bloodLoss > 1500;

    if (timeTrigger || bloodTrigger) {
      List<String> reasons = [];
      if (timeTrigger) reasons.add("手術時間 > 3小時");
      if (bloodTrigger) reasons.add("出血量 > 1500mL");
      return {
        "status": "🔴 建議追加劑量",
        "reason": reasons.join(" + "),
        "action": "請補充一劑抗生素以維持血中濃度",
      };
    } else {
      return {
        "status": "🟢 目前不需追加",
        "reason": "未達追加標準",
        "action": "持續監測手術時間與出血量",
      };
    }
  }

  /// 取得抗生素指引文字
  static String getAntibioticGuidelines(String topic) {
    switch (topic) {
      case '給藥時機':
        return "1. 標準：劃刀前 60 分鐘內 (IV)。\n"
            "2. 例外：Vancomycin / Fluoroquinolone 需提早於 120 分鐘前給予。\n"
            "3. 剖腹產：劃刀前 1 小時給藥 (不需等斷臍)。";
      case '手術分類':
        return "【清潔手術 (Clean)】\n"
            "- 甲類：原則免用。若用限術前 1 劑。\n"
            "- 乙類 (植入物/心/腦)：術後 < 24h 停藥。\n\n"
            "【清潔-汙染 (Clean-Contaminated)】\n"
            "- 胃腸/膽道/婦科/肺部。\n"
            "- 術後 < 24h 停藥。\n"
            "- 大腸直腸需涵蓋厭氧菌 (Cefoxitin 或 Amp+Beta-lac)。";
      case '特殊手術':
        return "【大腸直腸 (Colorectal)】\n"
            "- 非急診 (Elective)：術前一日 19:00, 23:00 口服 Neomycin 2g + Metronidazole 2g。\n\n"
            "【攝護腺切片 (Biopsy)】\n"
            "- 術前 12h 口服 Cipro 500mg，術後 12h 再一劑。";
      case 'MRSA風險':
        return "- 考慮使用 Vancomycin + Cefazolin。\n"
            "- 鼻腔定植者：鼻內 Mupirocin (術前1天~術後5天) + Chlorhexidine 沐浴。";
      default:
        return "";
    }
  }

  // ==========================================
  // 2. 輸液計算 (Maintenance)
  // ==========================================
  static Map<String, double> calculateMaintenanceFluid(double weight) {
    double dailyMl = 0;
    if (weight <= 10) {
      dailyMl = weight * 100;
    } else if (weight <= 20) {
      dailyMl = 1000 + (weight - 10) * 50;
    } else {
      dailyMl = 1500 + (weight - 20) * 20;
    }
    return {"daily_ml": dailyMl, "rate_ml_hr": dailyMl / 24};
  }

  static List<Map<String, String>> getFluidDatabase() {
    return [
      {
        "name": "N/S (Normal Saline)",
        "type": "等張溶液",
        "content": "Na 154, Cl 154 (mEq/L)",
        "usage": "休克復甦首選、輸血前後、代謝性鹼中毒。",
        "warning": "大量輸注恐致高氯性酸中毒。",
      },
      {
        "name": "L/R (Lactated Ringer's)",
        "type": "等張溶液",
        "content": "Na 130, K 4, Ca 3, Cl 109, Lactate 28",
        "usage": "手術中體液補充、燒燙傷、矯正酸中毒。",
        "warning": "含鉀 (洗腎慎用)、含鈣 (不可與輸血同一管路)。",
      },
      {
        "name": "D5W (5% Glucose)",
        "type": "等張 -> 低張",
        "content": "Glucose 50g/L",
        "usage": "補充水分、提供基本熱量 (170kcal/L)。",
        "warning": "不適合休克復甦 (留不住血管內)。腦水腫禁用。",
      },
      {
        "name": "3% NaCl",
        "type": "高張溶液",
        "content": "Na 513, Cl 513",
        "usage": "嚴重低血鈉 (Symptomatic Hyponatremia)。",
        "warning": "需緩慢輸注，避免 CPM (腦橋解髓鞘)。ICU 監測。",
      },
      {
        "name": "0.45% S (Half Saline)",
        "type": "低張溶液",
        "content": "Na 77, Cl 77",
        "usage": "高滲透壓狀態 (HHS)、嚴重高血鈉。",
        "warning": "輸注過快恐致腦水腫。",
      },
    ];
  }

  // ==========================================
  // 3. 吻合口滲漏 (Anastomotic Leak)
  // ==========================================
  static String assessAnastomoticLeak({
    required int postOpDay,
    required String drainContent,
    required bool hasFever,
    required bool hasPeritonitis,
  }) {
    if (hasPeritonitis) return "🚨 [危急] 腹膜炎徵象：強烈懷疑滲漏或破裂，建議緊急 CT 或手術探查。";
    if (drainContent.contains('Stool') || drainContent.contains('Bile'))
      return "🚨 [高風險] 引流管見糞水/膽汁：確診滲漏，需 NPO + 抗生素 + 引流。";
    if (postOpDay >= 3 && (hasFever || drainContent == 'Turbid'))
      return "⚠️ [疑似] 術後 >3 天發燒或引流混濁：建議安排 CT 排除腹內膿瘍/滲漏。";
    return "✅ 目前風險較低，持續觀察引流管與 Vital signs。";
  }

  // ==========================================
  // 4. 營養支持 (Nutrition)
  // ==========================================
  static Map<String, String> calculateAdvancedNutrition({
    required double weight,
    required String condition,
  }) {
    double calMin = 25, calMax = 30;
    double proMin = 1.0, proMax = 1.2;
    String note = "一般術後標準";

    switch (condition) {
      case 'ICU_Acute':
        calMin = 20;
        calMax = 25;
        proMin = 1.2;
        proMax = 1.5;
        note = "急性期避免過度餵食 (Permissive underfeeding)";
        break;
      case 'ICU_Recovery':
        calMin = 25;
        calMax = 30;
        proMin = 1.5;
        proMax = 2.0;
        note = "恢復期需高蛋白合成肌肉，注意腎功能";
        break;
      case 'CKD_Pre':
        calMin = 30;
        calMax = 35;
        proMin = 0.6;
        proMax = 0.8;
        note = "未透析腎病需限制蛋白質";
        break;
      case 'CKD_Dialysis':
        calMin = 30;
        calMax = 35;
        proMin = 1.2;
        proMax = 1.3;
        note = "洗腎病人流失胺基酸，需補回蛋白質";
        break;
      case 'CRRT':
        calMin = 25;
        calMax = 30;
        proMin = 1.5;
        proMax = 2.0;
        note = "CRRT 會濾出大量營養，需高蛋白";
        break;
    }

    return {
      "Calories":
          "${(weight * calMin).toInt()} - ${(weight * calMax).toInt()} kcal",
      "Protein":
          "${(weight * proMin).toStringAsFixed(1)} - ${(weight * proMax).toStringAsFixed(1)} g",
      "Note": note,
    };
  }

  static List<Map<String, String>> getDietTypes() {
    return [
      {"title": "Clear Liquid (清流質)", "desc": "水、運動飲料、無渣果汁。適用：術後剛排氣、腸鏡前。"},
      {"title": "Full Liquid (全流質)", "desc": "牛奶、豆漿、米湯、濃湯。適用：吞嚥困難、過渡期。"},
      {"title": "Soft Diet (軟質)", "desc": "稀飯、麵條、軟爛肉類。適用：牙口不好、腸胃消化弱。"},
      {"title": "Low Residue (低渣)", "desc": "去皮去筋、避免粗纖維。適用：腸道手術前後、發炎性腸道疾病。"},
      {"title": "Diabetic Diet (糖尿病)", "desc": "定時定量、控制醣類。適用：DM 病人。"},
    ];
  }

  static String getICUNutritionGuide(String topic) {
    if (topic.contains('EN vs PN'))
      return "原則：Gut works, use it!\n1. 首選 EN (腸道營養)，維護腸黏膜屏障。\n2. 若 EN < 60% 目標量超過 3-7 天，才考慮加 PN。\n3. 休克未穩定 (高劑量升壓劑) 時暫停 EN。";
    if (topic.contains('Refeeding'))
      return "高風險：BMI<16、禁食>7天、酗酒。\n特徵：低磷、低鉀、低鎂、心衰竭。\n預防：從 50% 目標熱量開始，補充電解質與維生素 B1。";
    if (topic.contains('Residual'))
      return "GRV (胃殘餘量) 指引：\n1. GRV < 500ml 且無嘔吐/腹脹 -> 繼續餵食。\n2. 不建議常規監測 GRV (易導致不必要的中斷)。\n3. 若 GRV 高，可加用 Prokinetics (Metoclopramide)。";
    return "";
  }

  // ==========================================
  // 5. 知情同意 (Informed Consent)
  // ==========================================
  static Map<String, dynamic> validateConsent({
    required bool isAdult,
    required bool isSedated,
    required bool isOriented,
    required bool isEmergency,
  }) {
    if (isEmergency) {
      return {
        "canSign": true,
        "msg": "🚨 緊急情況：\n為挽救生命，若無法取得同意，由兩位醫師簽署病歷後即可進行醫療處置 (醫療法規定)。",
      };
    }
    if (!isAdult) {
      return {"canSign": false, "msg": "❌ 未成年：\n需由法定代理人 (父母) 簽署。"};
    }
    if (isSedated) {
      return {
        "canSign": false,
        "msg": "❌ 受藥物影響：\n病人處於鎮靜/麻醉狀態，意識不清，簽署無效。需待藥效退去或由代理人簽署。",
      };
    }
    if (!isOriented) {
      return {"canSign": false, "msg": "❌ 意識不清：\n無法理解資訊，需由法定代理人/配偶/親屬簽署。"};
    }
    return {"canSign": true, "msg": "✅ 有效簽署：\n病人意識清楚且具行為能力，可自行簽署。"};
  }
}
