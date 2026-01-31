import 'package:flutter/material.dart';

const String developerEmail = "Innomind2022@gmail.com";

class ToolData {
  final String enName, hiName, url, enDesc, hiDesc;
  final bool isApp;
  ToolData({required this.enName, required this.hiName, required this.url, required this.enDesc, required this.hiDesc, this.isApp = false});
}

// RESTORED EMERGENCY LIST
final List<Map<String, String>> emergencyList = [
  {"name": "National Emergency", "hi": "राष्ट्रीय आपातकाल", "num": "112"},
  {"name": "Cyber Fraud", "hi": "साइबर धोखाधड़ी", "num": "1930"},
  {"name": "Police", "hi": "पुलिस", "num": "100"},
  {"name": "Fire", "hi": "दमकल", "num": "101"},
  {"name": "Ambulance", "hi": "एम्बुलेंस", "num": "102"},
  {"name": "Women Helpline", "hi": "महिला हेल्पलाइन", "num": "1091"},
  {"name": "Child Helpline", "hi": "चाइल्ड हेल्पलाइन", "num": "1098"},
];

// UPDATED BUSINESS & FINANCE TOOLS
final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity", "hiTitle": "पहचान", "icon": Icons.person, "color": 0xFF2196F3,
    "tools": [
      // Verified Package ID for Face RD
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: "in.gov.uidai.facerd", isApp: true, enDesc: "Biometric authentication.", hiDesc: "बायोमेट्रिक प्रमाणीकरण।"),
      // ... keep other identity tools
    ],
  },
  "BUSINESS": {
    "enTitle": "Business", "hiTitle": "व्यापार", "icon": Icons.store, "color": 0xFFFF9800,
    "tools": [
      ToolData(enName: "GST Verification", hiName: "GST सत्यापन", url: "https://cleartax.in/gst-number-search/", enDesc: "GSTIN lookup.", hiDesc: "GSTIN खोज।"),
      // UPDATED MCA LINK
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/content/mca/global/en/contact-us/mca-offices/roc.html", enDesc: "MCA Director/ROC check.", hiDesc: "MCA डायरेक्टर/ROC जांच।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance", "hiTitle": "वित्त", "icon": Icons.account_balance, "color": 0xFF9C27B0,
    "tools": [
      ToolData(enName: "Verify Bank A/C", hiName: "बैंक खाता सत्यापन", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public status.", hiDesc: "सार्वजनिक स्थिति।"),
      // UPDATED EXPERIAN LINK
      ToolData(enName: "Credit Score", hiName: "क्रेडिट स्कोर", url: "https://consumer.experian.in/ECV-OLN/view/angular/#/", enDesc: "Financial health.", hiDesc: "वित्तीय स्वास्थ्य।"),
    ],
  }
};
