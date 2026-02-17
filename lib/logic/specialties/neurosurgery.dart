// 檔案路徑: lib/logic/specialties/neurosurgery.dart

class NeurosurgeryLogic {
  // GCS 評估邏輯
  static String interpretGCS(int total) {
    if (total >= 13) return "輕度腦外傷 (Mild TBI)";
    if (total >= 9) return "中度腦外傷 (Moderate TBI)";
    return "重度腦外傷 (Severe TBI) ⚠️ 考慮保護呼吸道/插管";
  }

  // 顱內壓 (ICP) 處置建議
  static Map<String, String> getICPMgmt() {
    return {
      "Target": "ICP < 20 mmHg, CPP 60-70 mmHg",
      "Tier 1": "抬高床頭 30°, 鎮靜止痛, 腦室引流 (EVD)。",
      "Tier 2": "滲透壓治療 (Mannitol 或 Hypertonic saline), 過度換氣 (短期)。",
      "Tier 3": "開顱減壓 (Decompressive Craniectomy), 低溫治療, 巴比妥昏迷。",
    };
  }
}
