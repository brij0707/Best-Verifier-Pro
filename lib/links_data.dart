import 'package:flutter/material.dart';

const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";
const String developerEmail = "Innomind2022@gmail.com";

class ToolData {
  final String enName;
  final String hiName;
  final String url;
  final String enDesc;
  final String hiDesc;
  final bool isApp;

  ToolData({
    required this.enName,
    required this.hiName,
    required this.url,
    required this.enDesc,
    required this.hiDesc,
    this.isApp = false,
  });
}

final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity & Verification",
    "hiTitle": "पहचान और सत्यापन",
    "icon": Icons.person, 
    "color": 0xFF0D47A1,
    "tools": [
      ToolData(enName: "Aadhaar QR Scanner", hiName: "आधार QR स्कैनर", url: uidaiScannerPackage, isApp: true, enDesc: "Official UIDAI scanner for digital signatures.", hiDesc: "डिजिटल हस्ताक्षर के लिए आधिकारिक आधार स्कैनर।"),
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: faceRDAppPackage, isApp: true, enDesc: "Liveness check for Aadhaar authentication.", hiDesc: "आधार प्रमाणीकरण के लिए लाइवनेस चेक।"),
      ToolData(enName: "Aadhaar Validity", hiName: "आधार वैधता", url: "https://myaadhaar.uidai.gov.in/check-aadhaar-validity/en", enDesc: "Check if Aadhaar is active and see demographics.", hiDesc: "जांचें कि आधार सक्रिय है या नहीं।"),
      ToolData(enName: "Aadhaar-PAN Link", hiName: "आधार-पैन लिंक स्थिति", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status", enDesc: "Verify if PAN is linked with Aadhaar.", hiDesc: "जांचें कि क्या पैन आधार से जुड़ा है।"),
      ToolData(enName: "Verify PAN (OTP)", hiName: "पैन सत्यापित करें (OTP)", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN", enDesc: "Deep verification of PAN via OTP.", hiDesc: "OTP के माध्यम से पैन का गहरा सत्यापन।"),
      ToolData(enName: "Court Case Status", hiName: "कोर्ट केस की स्थिति", url: "https://services.ecourts.gov.in/ecourtindia_v6/?p=casestatus/index", enDesc: "Search judicial records (v6 engine).", hiDesc: "न्यायिक रिकॉर्ड खोजें (v6 इंजन)।"),
      ToolData(enName: "Missing Persons", hiName: "लापता व्यक्ति खोज", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Search national missing person records.", hiDesc: "राष्ट्रीय लापता व्यक्ति रिकॉर्ड खोजें।"),
      ToolData(enName: "Proclaimed Offenders", hiName: "घोषित अपराधी", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Check criminal records for wanted individuals.", hiDesc: "वांछित व्यक्तियों के आपराधिक रिकॉर्ड की जांच करें।"),
    ],
  },
  "ASSETS": {
    "enTitle": "Assets & Vehicles",
    "hiTitle": "संपत्ति और वाहन",
    "icon": Icons.directions_car,
    "color": 0xFF2E7D32,
    "tools": [
      ToolData(enName: "Vehicle RC Status", hiName: "वाहन RC स्थिति", url: "https://vahan.parivahan.gov.in/nrservices/faces/user/citizen/citizenlogin.xhtml", enDesc: "Login to check RC, PUC, and Insurance.", hiDesc: "RC, PUC और बीमा की जांच के लिए लॉगिन करें।"),
      ToolData(enName: "Stolen Vehicle / NOC", hiName: "चोरी का वाहन / NOC", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Check for police cases or vehicle NOC.", hiDesc: "पुलिस मामलों की जांच करें या वाहन NOC लें।"),
      ToolData(enName: "Pay E-Challan", hiName: "ई-चालान भुगतान", url: "https://echallan.parivahan.gov.in/index/accused-challan", enDesc: "Verify and pay traffic fines.", hiDesc: "ट्रैफिक जुर्माने का भुगतान करें।"),
    ],
  },
  "BUSINESS": {
    "enTitle": "Business & GST",
    "hiTitle": "व्यापार और GST",
    "icon": Icons.store,
    "color": 0xFF6A1B9A,
    "tools": [
      ToolData(enName: "GST Verification", hiName: "GST सत्यापन", url: "https://cleartax.in/gst-number-search/", enDesc: "Via ClearTax. Disclaimer: Non-Gov source.", hiDesc: "ClearTax के माध्यम से। गैर-सरकारी स्रोत।"),
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/mca21/Verify_DIN.html", enDesc: "Verify DIN and MCA records.", hiDesc: "DIN और MCA रिकॉर्ड सत्यापित करें।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance",
    "hiTitle": "वित्त",
    "icon": Icons.account_balance,
    "color": 0xFFE65100,
    "tools": [
      ToolData(enName: "Verify Bank Account", hiName: "बैंक खाता सत्यापित करें", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public status validator (PFMS).", hiDesc: "सार्वजनिक स्थिति सत्यापनकर्ता (PFMS)।"),
    ],
  }
};

final List<Map<String, String>> verificationSteps = [
  {"en": "1. Check Aadhaar Validity for demographics.", "hi": "1. जनसांख्यिकी के लिए आधार वैधता जांचें।"},
  {"en": "2. Verify Aadhaar-PAN linking status.", "hi": "2. आधार-पैन लिंकिंग स्थिति सत्यापित करें।"},
  {"en": "3. Use QR or Face RD for physical match.", "hi": "3. भौतिक मिलान के लिए QR या फेस RD का उपयोग करें।"},
  {"en": "4. Check Vehicle RC & Police NOC.", "hi": "4. वाहन RC और पुलिस NOC की जांच करें।"},
  {"en": "5. Check for any pending Challans.", "hi": "5. लंबित चालानों की जांच करें।"},
];
