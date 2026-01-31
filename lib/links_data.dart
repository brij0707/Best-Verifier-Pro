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

// --- TAB A: VERIFY OTHERS (16 TOOLS SERIAL BIFURCATION) ---
final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity", "hiTitle": "पहचान", "icon": Icons.person, "color": 0xFF2196F3,
    "tools": [
      ToolData(enName: "Aadhaar QR Scanner", hiName: "आधार QR स्कैनर", url: uidaiScannerPackage, isApp: true, enDesc: "Digital signature/photo check.", hiDesc: "डिजिटल हस्ताक्षर/फोटो जांच।"),
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: faceRDAppPackage, isApp: true, enDesc: "Biometric face authentication.", hiDesc: "बायोमेट्रिक चेहरा प्रमाणीकरण।"),
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
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/content/mca/global/en/contact-us/mca-offices/roc.html", enDesc: "MCA Director/ROC check.", hiDesc: "MCA डायरेक्टर/ROC जांच।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance", "hiTitle": "वित्त", "icon": Icons.account_balance, "color": 0xFF9C27B0,
    "tools": [
      ToolData(enName: "Verify Bank A/C", hiName: "बैंक खाता सत्यापन", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public status validator.", hiDesc: "सार्वजनिक स्थिति सत्यापन।"),
      ToolData(enName: "ITR Status", hiName: "ITR स्थिति", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/itr-status", enDesc: "Tax filing verification.", hiDesc: "टैक्स फाइलिंग सत्यापन।"),
      ToolData(enName: "Credit Score", hiName: "क्रेडिट स्कोर", url: "https://consumer.experian.in/ECV-OLN/view/angular/#/", enDesc: "Experian financial health.", hiDesc: "वित्तीय स्वास्थ्य जांच।"),
    ],
  }
};

// --- TAB B: OWN DOCS (PERSONAL VAULT) ---
final List<ToolData> ownDocsTools = [
  ToolData(enName: "DigiLocker", hiName: "डिजी लॉकर", url: "https://www.digilocker.gov.in/", enDesc: "Access Govt certificates.", hiDesc: "सरकारी प्रमाणपत्र प्राप्त करें।"),
  ToolData(enName: "mParivahan", hiName: "m-परिवहन", url: "https://mparivahan.gov.in/", enDesc: "Your virtual DL/RC.", hiDesc: "आपका वर्चुअल DL/RC।"),
  ToolData(enName: "My Aadhaar", hiName: "मेरा आधार", url: "https://myaadhaar.uidai.gov.in/", enDesc: "E-Aadhaar download.", hiDesc: "ई-आधार डाउनलोड करें।"),
  ToolData(enName: "Income Tax", hiName: "आयकर", url: "https://eportal.incometax.gov.in/", enDesc: "Check tax filings.", hiDesc: "टैक्स फाइलिंग जांचें।"),
  ToolData(enName: "EPF Portal", hiName: "EPF पोर्टल", url: "https://unifiedportal-mem.epfindia.gov.in/", enDesc: "Check PF balance.", hiDesc: "PF बैलेंस चेक करें।"),
];

// --- COMPLETE EMERGENCY HUB LIST ---
final List<Map<String, String>> emergencyList = [
  {"name": "National Emergency", "hi": "राष्ट्रीय आपातकाल", "num": "112"},
  {"name": "Cyber Fraud", "hi": "साइबर धोखाधड़ी", "num": "1930"},
  {"name": "Police", "hi": "पुलिस", "num": "100"},
  {"name": "Fire", "hi": "दमकल", "num": "101"},
  {"name": "Ambulance", "hi": "एम्बुलेंस", "num": "102"},
  {"name": "Women Helpline", "hi": "महिला हेल्पलाइन", "num": "1091"},
  {"name": "Child Helpline", "hi": "चाइल्ड हेल्पलाइन", "num": "1098"},
];

// --- FULL DETAILED STRATEGY (5 PHASES) ---
final List<Map<String, String>> fullStrategy = [
  {
    "step": "1",
    "title_en": "Phase 1: Demographic Discovery",
    "title_hi": "चरण 1: जनसांख्यिकीय खोज",
    "en": "Use the Aadhaar Validity tool first. It is a free, zero-login service. Verify that the ID is active and match the provided Age-Band, Gender, and State against the person's physical appearance to spot obvious fakes.",
    "hi": "सबसे पहले आधार वैधता टूल का उपयोग करें। यह एक निःशुल्क सेवा है। पुष्टि करें कि आईडी सक्रिय है और आयु-बैंड, लिंग और राज्य का व्यक्ति के भौतिक स्वरूप से मिलान करें।"
  },
  {
    "step": "2",
    "title_en": "Phase 2: Identity Consistency",
    "title_hi": "चरण 2: पहचान निरंतरता",
    "en": "Check the Aadhaar-PAN Link status. If an individual has a valid Aadhaar but it isn't linked to a PAN, it indicates a high risk of identity inconsistency or tax non-compliance, requiring deeper scrutiny.",
    "hi": "आधार-पैन लिंक स्थिति की जांच करें। यदि आधार वैध है लेकिन पैन से लिंक नहीं है, तो यह पहचान में विसंगति या टैक्स नियमों के उल्लंघन का संकेत देता है।"
  },
  {
    "step": "3",
    "title_en": "Phase 3: Digital & Physical Match",
    "title_hi": "चरण 3: डिजिटल और भौतिक मिलान",
    "en": "Use the QR Scanner to verify digital signatures (which cannot be forged like physical cards) and use Face RD for biometric confirmation that the person standing in front of you is indeed the true owner of the record.",
    "hi": "डिजिटल हस्ताक्षर को सत्यापित करने के लिए क्यूआर स्कैनर का उपयोग करें और बायोमेट्रिक पुष्टि के लिए फेस आरडी का उपयोग करें कि आपके सामने वाला व्यक्ति ही असली मालिक है।"
  },
  {
    "step": "4",
    "title_en": "Phase 4: Asset & Legal Audit",
    "title_hi": "चरण 4: संपत्ति और कानूनी ऑडिट",
    "en": "Use Vehicle RC Status for ownership age and insurance. Crucially, use the Police NOC/Stolen tool to ensure the vehicle or the individual isn't flagged in any active criminal activity or theft reports.",
    "hi": "स्वामित्व और बीमा के लिए वाहन आरसी स्थिति का उपयोग करें। पुलिस एनओसी/चोरी टूल का उपयोग करें ताकि यह सुनिश्चित हो सके कि वाहन किसी अपराध में शामिल नहीं है।"
  },
  {
    "step": "5",
    "title_en": "Phase 5: Behavioral Compliance",
    "title_hi": "चरण 5: व्यवहार अनुपालन",
    "en": "Check E-Challans. A high frequency of traffic violations often correlates with a general disregard for law and order, providing a final behavioral risk profile for your verification process.",
    "hi": "ई-चालान की जांच करें। ट्रैफिक उल्लंघन की उच्च आवृत्ति अक्सर कानून के प्रति उपेक्षा को दर्शाती है, जो आपके सत्यापन को एक अंतिम व्यवहारिक आधार प्रदान करती है।"
  },
];
