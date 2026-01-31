import 'package:flutter/material.dart';

// Native Package IDs for Android
const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";
const String developerEmail = "Innomind2022@gmail.com";

class ToolData {
  final String enName, hiName, url, enDesc, hiDesc;
  final bool isApp;

  ToolData({
    required this.enName, required this.hiName, 
    required this.url, required this.enDesc, 
    required this.hiDesc, this.isApp = false
  });
}

// 16-Tool Serial Bifurcation with V1 Circular Icon Colors
final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity", "hiTitle": "पहचान", "icon": Icons.person, "color": 0xFF2196F3,
    "tools": [
      ToolData(enName: "Aadhaar QR Scanner", hiName: "आधार QR स्कैनर", url: uidaiScannerPackage, isApp: true, enDesc: "Check digital signatures.", hiDesc: "डिजिटल हस्ताक्षर की जाँच।"),
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: faceRDAppPackage, isApp: true, enDesc: "Biometric liveness.", hiDesc: "बायोमेट्रिक लाइवनेस।"),
      ToolData(enName: "Aadhaar Validity", hiName: "आधार वैधता", url: "https://myaadhaar.uidai.gov.in/check-aadhaar-validity/en", enDesc: "Age/Gender/State check.", hiDesc: "आयु/लिंग/राज्य की जाँच।"),
      ToolData(enName: "Aadhaar-PAN Link", hiName: "आधार-पैन लिंक", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status", enDesc: "ID consistency check.", hiDesc: "आईडी निरंतरता की जाँच।"),
      ToolData(enName: "Verify PAN (OTP)", hiName: "पैन सत्यापित (OTP)", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN", enDesc: "Deep identity match.", hiDesc: "गहरा पहचान मिलान।"),
      ToolData(enName: "Court Case", hiName: "कोर्ट केस", url: "https://services.ecourts.gov.in/ecourtindia_v6/?p=casestatus/index", enDesc: "Judicial records.", hiDesc: "न्यायिक रिकॉर्ड।"),
      ToolData(enName: "Missing Persons", hiName: "लापता व्यक्ति", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Police database search.", hiDesc: "पुलिस डेटाबेस खोज।"),
      ToolData(enName: "Criminal Records", hiName: "अपराधिक रिकॉर्ड", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Wanted list check.", hiDesc: "अपराधी की जाँच।"),
    ],
  },
  "ASSETS": {
    "enTitle": "Assets", "hiTitle": "संपत्ति", "icon": Icons.directions_car, "color": 0xFF4CAF50,
    "tools": [
      ToolData(enName: "Vehicle RC Status", hiName: "वाहन RC स्थिति", url: "https://vahan.parivahan.gov.in/nrservices/faces/user/citizen/citizenlogin.xhtml", enDesc: "Owner & Insurance info.", hiDesc: "स्वामित्व और बीमा।"),
      ToolData(enName: "Stolen Vehicle/NOC", hiName: "चोरी वाहन/NOC", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Police case check.", hiDesc: "पुलिस केस की जाँच।"),
      ToolData(enName: "Pay E-Challan", hiName: "ई-चालान भुगतान", url: "https://echallan.parivahan.gov.in/index/accused-challan", enDesc: "Traffic fines.", hiDesc: "ट्रैफिक जुर्माना।"),
    ],
  },
  "BUSINESS": {
    "enTitle": "Business", "hiTitle": "व्यापार", "icon": Icons.store, "color": 0xFFFF9800,
    "tools": [
      ToolData(enName: "GST Verification", hiName: "GST सत्यापन", url: "https://cleartax.in/gst-number-search/", enDesc: "GSTIN lookup.", hiDesc: "GSTIN खोज।"),
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/mca21/Verify_DIN.html", enDesc: "MCA DIN lookup.", hiDesc: "MCA DIN खोज।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance", "hiTitle": "वित्त", "icon": Icons.account_balance, "color": 0xFF9C27B0,
    "tools": [
      ToolData(enName: "Verify Bank A/C", hiName: "बैंक खाता सत्यापन", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public status validator.", hiDesc: "सार्वजनिक स्थिति सत्यापन।"),
      ToolData(enName: "ITR Status", hiName: "ITR स्थिति", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/itr-status", enDesc: "Income Tax check.", hiDesc: "आयकर जाँच।"),
      ToolData(enName: "Credit Score", hiName: "क्रेडिट स्कोर", url: "https://www.cibil.com/freecreditscore/", enDesc: "Financial health.", hiDesc: "वित्तीय स्वास्थ्य।"),
    ],
  }
};

// FULL 5-STEP STRATEGY SUMMARY
final List<Map<String, String>> fullStrategy = [
  {
    "step": "1",
    "title_en": "Demographic Discovery",
    "title_hi": "जनसांख्यिकीय खोज",
    "en": "Use Aadhaar Validity first. It is a free, zero-login service. Verify that the ID is active and match the provided Age-Band, Gender, and State against the person's physical appearance.",
    "hi": "पहले आधार वैधता का उपयोग करें। यह एक निःशुल्क सेवा है। पुष्टि करें कि आईडी सक्रिय है और आयु-बैंड, लिंग और राज्य का व्यक्ति के भौतिक स्वरूप से मिलान करें।"
  },
  {
    "step": "2",
    "title_en": "Identity Consistency",
    "title_hi": "पहचान निरंतरता",
    "en": "Use the Aadhaar-PAN Link check. If a person has a valid Aadhaar but it isn't linked to a PAN, it indicates a high risk of identity inconsistency or tax non-compliance.",
    "hi": "आधार-पैन लिंक जांच का उपयोग करें। यदि किसी व्यक्ति के पास वैध आधार है लेकिन वह पैन से लिंक नहीं है, तो यह पहचान में विसंगति या टैक्स नियमों के उल्लंघन का संकेत देता है।"
  },
  {
    "step": "3",
    "title_en": "Digital & Physical Match",
    "title_hi": "डिजिटल और भौतिक मिलान",
    "en": "Use the QR Scanner to verify the digital signature (which cannot be forged like a physical card) and use Face RD for biometric confirmation that the person in front of you is the true owner.",
    "hi": "डिजिटल हस्ताक्षर को सत्यापित करने के लिए क्यूआर स्कैनर का उपयोग करें और बायोमेट्रिक पुष्टि के लिए फेस आरडी का उपयोग करें कि आपके सामने वाला व्यक्ति ही असली मालिक है।"
  },
  {
    "step": "4",
    "title_en": "Asset & Legal Audit",
    "title_hi": "संपत्ति और कानूनी ऑडिट",
    "en": "Use Vehicle RC Status for ownership age and insurance. Crucially, use the Police NOC/Stolen tool to ensure the vehicle isn't flagged in any criminal activity or theft reports.",
    "hi": "स्वामित्व और बीमा के लिए वाहन आरसी स्थिति का उपयोग करें। महत्वपूर्ण रूप से, यह सुनिश्चित करने के लिए पुलिस एनओसी/चोरी उपकरण का उपयोग करें कि वाहन किसी आपराधिक गतिविधि में शामिल नहीं है।"
  },
  {
    "step": "5",
    "title_en": "Behavioral Compliance",
    "title_hi": "व्यवहार अनुपालन",
    "en": "Check E-Challans. A high frequency of traffic violations often correlates with a disregard for law and order, providing a final behavioral layer to your verification.",
    "hi": "ई-चालान की जांच करें। ट्रैफिक उल्लंघन की उच्च आवृत्ति अक्सर कानून और व्यवस्था के प्रति उपेक्षा को दर्शाती है, जो आपके सत्यापन को एक अंतिम व्यवहारिक आधार प्रदान करती है।"
  },
];
