// 檔案路徑: lib/logic/general_principles.dart

class GeneralPrinciples {
  // ==========================================
  // Ch1: 預防性抗生素 (Prophylactic Antibiotics)
  // ==========================================
  static double calculateCefazolinDose(double weight) {
    if (weight >= 120) {
      return 3.0; // 3g
    } else if (weight > 80) {
      return 2.0; // 2g
    } else {
      return 1.0; // 1g
    }
  }

  // ==========================================
  // Ch3: 輸液與電解質 (Fluid & Electrolytes)
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
    double hourlyRate = dailyMl / 24;
    return {"daily_ml": dailyMl, "rate_ml_hr": hourlyRate};
  }

  static List<Map<String, String>> getFluidDatabase() {
    return [
      {
        "name": "0.9% Normal Saline (N/S)",
        "type": "等張",
        "content": "Na+: 154, Cl-: 154",
        "usage": "休克急救、輸血前後。",
        "warning": "易致高氯性酸中毒。",
      },
      {
        "name": "Lactated Ringer's (L/R)",
        "type": "等張",
        "content": "Na+: 130, K+: 4, Ca++: 3, Lactate: 28",
        "usage": "燒傷、急性失血。",
        "warning": "含鉀鈣，腎衰竭/輸血慎用。",
      },
      {
        "name": "5% Dextrose (D5W)",
        "type": "等張->低張",
        "content": "Glucose: 50g/L",
        "usage": "補充自由水。",
        "warning": "腦傷/腦水腫禁用。",
      },
      {
        "name": "0.45% Saline (Half Saline)",
        "type": "低張",
        "content": "Na+: 77, Cl-: 77",
        "usage": "高滲透壓狀態維持。",
        "warning": "過快易致腦水腫。",
      },
      {
        "name": "3% NaCl",
        "type": "高張",
        "content": "Na+: 513",
        "usage": "嚴重低血鈉 (<120) 合併症狀。",
        "warning": "高危險藥品！小心 CPM。",
      },
      {
        "name": "Taita No.1",
        "type": "低張",
        "content": "Na+: 38, K+: 0",
        "usage": "嬰兒維持。",
        "warning": "成人極易低血鈉。",
      },
      {
        "name": "Taita No.2",
        "type": "低張",
        "content": "Na+: 56, K+: 20",
        "usage": "一般維持 (含鉀)。",
        "warning": "腎衰竭慎用。",
      },
      {
        "name": "Taita No.4",
        "type": "低張",
        "content": "Na+: 30, K+: 20",
        "usage": "低張性脫水。",
        "warning": "含磷，腎衰竭慎用！",
      },
      {
        "name": "Taita No.5",
        "type": "高張",
        "content": "G: 10%, Na: 40, K: 10",
        "usage": "需熱量/肝病。",
        "warning": "易靜脈炎。",
      },
    ];
  }

  // ==========================================
  // Ch4: 營養支持 (Nutritional Support) - Updated
  // ==========================================

  /// 進階營養需求計算
  /// 依據：一般病房 vs ICU (Acute/Recovery) vs CKD/Dialysis
  static Map<String, String> calculateAdvancedNutrition({
    required double weight,
    required String
    condition, // 'General', 'ICU_Acute', 'ICU_Recovery', 'CKD_Pre', 'CKD_Dialysis', 'CRRT'
  }) {
    String calorieTarget = "";
    String proteinTarget = "";
    String note = "";

    switch (condition) {
      case 'ICU_Acute': // ICU 急性期
        // 熱量: 保守 15-20 kcal/kg
        // 蛋白: 高代謝 1.2-2.0 g/kg
        calorieTarget =
            "${(weight * 15).toInt()} - ${(weight * 20).toInt()} kcal";
        proteinTarget =
            "${(weight * 1.2).toStringAsFixed(1)} - ${(weight * 2.0).toStringAsFixed(1)} g";
        note = "急性期避免過度餵食 (Permissive underfeeding)。\n優先使用腸道營養 (EN)。";
        break;

      case 'ICU_Recovery': // ICU 恢復期
        // 熱量: 25-30 kcal/kg
        // 蛋白: 1.2-2.0 g/kg
        calorieTarget =
            "${(weight * 25).toInt()} - ${(weight * 30).toInt()} kcal";
        proteinTarget =
            "${(weight * 1.2).toStringAsFixed(1)} - ${(weight * 2.0).toStringAsFixed(1)} g";
        note = "進入同化期 (Anabolic)，需增加熱量支持復健。";
        break;

      case 'CKD_Pre': // 腎病未透析
        // 熱量: 30 kcal/kg
        // 蛋白: 限制 0.6-0.8 g/kg
        calorieTarget = "${(weight * 30).toInt()} kcal";
        proteinTarget =
            "${(weight * 0.6).toStringAsFixed(1)} - ${(weight * 0.8).toStringAsFixed(1)} g";
        note = "需限制蛋白質以延緩腎功能惡化。";
        break;

      case 'CKD_Dialysis': // 洗腎 (HD/PD)
        // 熱量: 30-35 kcal/kg
        // 蛋白: 1.2-1.3 g/kg (流失增加)
        calorieTarget =
            "${(weight * 30).toInt()} - ${(weight * 35).toInt()} kcal";
        proteinTarget =
            "${(weight * 1.2).toStringAsFixed(1)} - ${(weight * 1.3).toStringAsFixed(1)} g";
        note = "透析會流失胺基酸，需增加蛋白質攝取。";
        break;

      case 'CRRT': // 連續透析 (重症)
        // 熱量: 25-30 kcal/kg
        // 蛋白: 2.0-2.5 g/kg
        calorieTarget =
            "${(weight * 25).toInt()} - ${(weight * 30).toInt()} kcal";
        proteinTarget =
            "2.0 - 2.5 g/kg (${(weight * 2.0).toStringAsFixed(1)} - ${(weight * 2.5).toStringAsFixed(1)} g)";
        note = "CRRT 濾除大量營養素，需極高蛋白補充。";
        break;

      case 'General': // 一般外科術後
      default:
        // 熱量: 25-30 kcal/kg
        // 蛋白: 1.0-1.2 g/kg
        calorieTarget =
            "${(weight * 25).toInt()} - ${(weight * 30).toInt()} kcal";
        proteinTarget =
            "${(weight * 1.0).toStringAsFixed(1)} - ${(weight * 1.2).toStringAsFixed(1)} g";
        note = "若有傷口/感染/癌症，壓力因子需 x 1.2-1.5。";
        break;
    }

    return {"Calories": calorieTarget, "Protein": proteinTarget, "Note": note};
  }

  /// 飲食質地介紹
  static List<Map<String, String>> getDietTypes() {
    return [
      {
        "title": "清流質 (Clear Liquid)",
        "desc": "米湯、舒跑、過濾果汁。\n適應症：術前清腸、剛恢復腸蠕動。\n⚠️ 營養不足，勿長期使用。",
      },
      {
        "title": "全流質 (Full Liquid)",
        "desc": "牛奶、濃湯、安素、米漿。\n適應症：食道狹窄、咀嚼困難、吞嚥稍差。",
      },
      {"title": "半流質 (Semi-Liquid)", "desc": "鹹粥、湯麵 (剁碎煮爛)。\n適應症：消化不良、牙齒咬合不佳。"},
      {"title": "軟質飲食 (Soft Diet)", "desc": "質地軟爛的固體食物。\n適應症：老年人、術後恢復期。"},
      {"title": "低渣飲食 (Low Residue)", "desc": "去皮去筋，減少纖維。\n適應症：大腸直腸手術前後、腸阻塞。"},
      {"title": "低油飲食 (Low Fat)", "desc": "脂肪 < 50g/day。\n適應症：膽囊炎、胰臟炎、乳糜胸。"},
    ];
  }

  /// 重症營養指引內容
  static String getICUNutritionGuide(String topic) {
    switch (topic) {
      case 'EN vs PN':
        return "🏆 首選腸道營養 (EN):\n"
            "只要腸胃有功能，應在血動穩定 24-48hr 內開始。\n"
            "優點：維持腸黏膜、減少細菌轉移 (Translocation)。\n\n"
            "💉 靜脈營養 (PN):\n"
            "若 EN 無法達標，建議第 3-7 天後再加 Supplemental PN。\n"
            "勿過早全 PN (增加感染風險)。";
      case 'Refeeding Syndrome':
        return "⚠️ 再餵食症候群:\n"
            "高風險：BMI<16、長期禁食 (>5天)。\n"
            "機轉：胰島素分泌 -> 磷/鉀/鎂 快速進入細胞 -> 血清濃度驟降。\n"
            "處置：\n"
            "1. 初始熱量保守 (< 20 kcal/kg)。\n"
            "2. 前 72hr 監測 P, K, Mg。\n"
            "3. 補充維生素 B1 (Thiamine)。";
      case 'Gastric Residual (GRV)':
        return "📊 胃殘餘量 (GRV):\n"
            "觀念：GRV 不應作為耐受性唯一指標。\n"
            "閾值：建議設為 500 mL。\n"
            "處置：若 > 500mL，先加促進蠕動藥 (Metoclopramide/Erythromycin) 或改幽門後灌食 (NJ tube)。\n"
            "勿因低 GRV 而隨意停止灌食。";
      default:
        return "";
    }
  }

  // ==========================================
  // Ch5: 傷口與引流管 (Wound & Drains)
  // ==========================================
  static String assessAnastomoticLeak({
    required int postOpDay,
    required String drainContent, // Clear, Turbid, Stool-like
    required bool hasFever,
    required bool hasPeritonitis,
  }) {
    if (hasPeritonitis || drainContent == 'Stool-like') {
      return "🚨 高度懷疑滲漏 (Leak)！\n建議：NPO、IV 抗生素、安排 CT 或緊急手術探查。";
    }
    if (postOpDay >= 3 && (hasFever || drainContent == 'Turbid')) {
      return "⚠️ 疑似滲漏或感染 (Leak/Abscess)。\n建議：保持引流管暢通，監測引流量與 Amylase/Bilirubin，安排 CT。";
    }
    return "✅ 目前無明顯滲漏跡象。\n建議：持續觀察引流液性質。";
  }

  // ==========================================
  // Ch8: 法律與倫理 (Consent)
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
        "msg": "⚠️ 緊急醫療 (兩位醫師證明)\n為挽救生命可先行處置，事後盡快補簽同意書。",
      };
    }
    if (isSedated) {
      return {"canSign": false, "msg": "❌ 病人受鎮靜藥物影響\n此時簽署無效。需等藥效退去或由法定代理人簽署。"};
    }
    if (!isAdult) {
      return {"canSign": false, "msg": "❌ 未成年人\n需由法定代理人 (父母/監護人) 簽署。"};
    }
    if (!isOriented) {
      return {"canSign": false, "msg": "❌ 意識不清/譫妄\n需由法定代理人或醫療委任代理人簽署。"};
    }
    return {"canSign": true, "msg": "✅ 病人具備簽署能力\n請解釋病情並完成簽署。"};
  }
}
