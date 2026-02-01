import 'package:flutter/material.dart';

// Package & Developer Constants
const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";
const String developerEmail = "Innomind2022@gmail.com";

class ToolData {
  final String enName, hiName, url, enDesc, hiDesc;
  final bool isApp;

  ToolData({
    required this.enName, 
    required this.hiName, 
    required this.url, 
    required this.enDesc, 
    required this.hiDesc, 
    this.isApp = false
  });
}

// --- TAB A: VERIFY OTHERS (16 TOOLS) ---
final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity", "hiTitle": "पहचान", "icon": Icons.person, "color": 0xFF2196F3,
    "tools": [
      ToolData(enName: "Aadhaar QR Scanner", hiName: "आधार QR स्कैनर", url: uidaiScannerPackage, isApp: true, enDesc: "Digital signature check.", hiDesc: "डिजिटल हस्ताक्षर जांच।"),
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: "https://play.google.com/store/apps/details?id=in.gov.uidai.facerd", isApp: true, enDesc: "Official UIDAI biometric face match.", hiDesc: "आधिकारिक यूआईडीएआई बायोमेट्रिक चेहरा मिलान।"),
      ToolData(enName: "Aadhaar Validity", hiName: "आधार वैधता", url: "https://myaadhaar.uidai.gov.in/check-aadhaar-validity/en", enDesc: "Check Age/Gender/State.", hiDesc: "आयु/लिंग/राज्य की जांच।"),
      ToolData(enName: "Aadhaar-PAN Link", hiName: "आधार-पैन लिंक", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status", enDesc: "ID consistency check.", hiDesc: "आईडी निरंतरता जांच।"),
      ToolData(enName: "Verify PAN (OTP)", hiName: "पैन सत्यापित (OTP)", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN", enDesc: "Deep identity match.", hiDesc: "गहरा पहचान मिलान।"),
      ToolData(enName: "Court Case", hiName: "कोर्ट केस", url: "https://services.ecourts.gov.in/ecourtindia_v6/?p=casestatus/index", enDesc: "Search judicial records.", hiDesc: "न्यायिक रिकॉर्ड खोजें।"),
      ToolData(enName: "Missing Persons", hiName: "लापता व्यक्ति", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Police database search.", hiDesc: "पुलिस डेटाबेस खोज।"),
      ToolData(enName: "Criminal Records", hiName: "अपराधिक रिकॉर्ड", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Check wanted offenders.", hiDesc: "अपराधियों की जांच।"),
    ],
  },
  "ASSETS": {
    "enTitle": "Assets", "hiTitle": "संपत्ति", "icon": Icons.directions_car, "color": 0xFF4CAF50,
    "tools": [
      ToolData(enName: "Vehicle RC Status", hiName: "वाहन RC स्थिति", url: "https://vahan.parivahan.gov.in/nrservices/faces/user/citizen/citizenlogin.xhtml", enDesc: "Ownership/Insurance info.", hiDesc: "स्वामित्व/बीमा जानकारी।"),
      ToolData(enName: "Stolen Vehicle/NOC", hiName: "चोरी वाहन/NOC", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Check for police cases.", hiDesc: "पुलिस केस की जांच।"),
      ToolData(enName: "Pay E-Challan", hiName: "ई-चालान भुगतान", url: "https://echallan.parivahan.gov.in/index/accused-challan", enDesc: "Traffic fine lookup.", hiDesc: "ट्रैफिक जुर्माना खोज।"),
    ],
  },
  "BUSINESS": {
    "enTitle": "Business", "hiTitle": "व्यापार", "icon": Icons.store, "color": 0xFFFF9800,
    "tools": [
      ToolData(enName: "GST Verification", hiName: "GST सत्यापन", url: "https://cleartax.in/gst-number-search/", enDesc: "GSTIN registration check.", hiDesc: "GSTIN पंजीकरण जांच।"),
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/content/mca/global/en/mca-services/master-data/view-company-llp-master-data.html", enDesc: "MCA Master Data search.", hiDesc: "MCA मास्टर डेटा खोज।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance", "hiTitle": "वित्त", "icon": Icons.account_balance, "color": 0xFF9C27B0,
    "tools": [
      ToolData(enName: "Verify Bank A/C", hiName: "बैंक खाता सत्यापन", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public status validator.", hiDesc: "सार्वजनिक स्थिति सत्यापन।"),
      ToolData(enName: "Income Tax Login", hiName: "आयकर लॉगिन", url: "https://eportal.incometax.gov.in/iec/foservices/#/login", enDesc: "Tax filing portal.", hiDesc: "टैक्स फाइलिंग पोर्टल।"),
      ToolData(enName: "Credit Score", hiName: "क्रेडिट स्कोर", url: "https://consumer.experian.in/ECV-OLN/view/angular/#/", enDesc: "Experian financial health.", hiDesc: "वित्तीय स्वास्थ्य जांच।"),
    ],
  }
};

// --- TAB B: OWN DOCS (PERSONAL VAULT) ---
final List<ToolData> ownDocsTools = [
  ToolData(enName: "DigiLocker", hiName: "डिजी लॉकर", url: "https://www.digilocker.gov.in/", enDesc: "Govt certificates.", hiDesc: "सरकारी प्रमाणपत्र।"),
  ToolData(enName: "mParivahan", hiName: "m-परिवहन", url: "https://mparivahan.gov.in/", enDesc: "Virtual DL/RC.", hiDesc: "वर्चुअल DL/RC।"),
  ToolData(enName: "My Aadhaar", hiName: "मेरा आधार", url: "https://myaadhaar.uidai.gov.in/", enDesc: "E-Aadhaar download.", hiDesc: "ई-आधार डाउनलोड।"),
  ToolData(enName: "ITR Login", hiName: "ITR लॉगिन", url: "https://eportal.incometax.gov.in/iec/foservices/#/login", enDesc: "Personal tax profile.", hiDesc: "व्यक्तिगत टैक्स प्रोफाइल।"),
  ToolData(enName: "EPF Portal", hiName: "EPF पोर्टल", url: "https://unifiedportal-mem.epfindia.gov.in/", enDesc: "Check PF balance.", hiDesc: "PF बैलेंस जांच।"),
];

// --- COMPLETE EMERGENCY HUB (7 NUMBERS) ---
final List<Map<String, String>> emergencyList = [
  {"name": "National Emergency", "hi": "राष्ट्रीय आपातकाल", "num": "112"},
  {"name": "Cyber Fraud", "hi": "साइबर धोखाधड़ी", "num": "1930"},
  {"name": "Police", "hi": "पुलिस", "num": "100"},
  {"name": "Fire", "hi": "दमकल", "num": "101"},
  {"name": "Ambulance", "hi": "एम्बुलेंस", "num": "102"},
  {"name": "Women Helpline", "hi": "महिला हेल्पलाइन", "num": "1091"},
  {"name": "Child Helpline", "hi": "चाइल्ड हेल्पलाइन", "num": "1098"},
];

// --- FULL 5-PHASE STRATEGY ---
final List<Map<String, String>> fullStrategy = [
  {"step": "1", "title_en": "Phase 1: Demographics", "title_hi": "चरण 1: जनसांख्यिकी", "en": "Check Aadhaar Validity (Age/Gender/State).", "hi": "आधार वैधता (आयु/लिंग/राज्य) की जांच करें।"},
  {"step": "2", "title_en": "Phase 2: Consistency", "title_hi": "चरण 2: स्थिरता", "en": "Verify Aadhaar-PAN linkage.", "hi": "आधार-पैन लिंकिंग सत्यापित करें।"},
  {"step": "3", "title_en": "Phase 3: Biometrics", "title_hi": "चरण 3: बायोमेट्रिक्स", "en": "Digital QR scan and Face RD match.", "hi": "डिजिटल क्यूआर स्कैन और फेस आरडी मिलान।"},
  {"step": "4", "title_en": "Phase 4: Assets", "title_hi": "चरण 4: संपत्ति", "en": "Vehicle RC and Police NOC check.", "hi": "वाहन आरसी और पुलिस एनओसी जांच।"},
  {"step": "5", "title_en": "Phase 5: Behavior", "title_hi": "चरण 5: व्यवहार", "en": "E-Challan history risk profiling.", "hi": "ई-चालान इतिहास जोखिम प्रोफाइलिंग।"},
];
