import 'package:flutter/material.dart';

// Package IDs for the App Launcher
const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";
const String developerEmail = "Innomind2022@gmail.com";

// Language Data Model
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
    "icon": Icons.person, // Restored V1 Human Icon
    "color": 0xFF0D47A1,
    "tools": [
      ToolData(
        enName: "Aadhaar QR Scanner",
        hiName: "आधार QR स्कैनर",
        url: uidaiScannerPackage,
        enDesc: "Uses official UIDAI scanner to verify digital signatures.",
        hiDesc: "डिजिटल हस्ताक्षर सत्यापित करने के लिए आधिकारिक आधार स्कैनर का उपयोग करें।",
        isApp: true,
      ),
      ToolData(
        enName: "Aadhaar Validity",
        hiName: "आधार वैधता",
        url: "https://myaadhaar.uidai.gov.in/check-aadhaar-validity/en",
        enDesc: "Check if Aadhaar is active and see demographic details.",
        hiDesc: "जांचें कि आधार सक्रिय है या नहीं और जनसांख्यिकीय विवरण देखें।",
      ),
      ToolData(
        enName: "Aadhaar-PAN Link",
        hiName: "आधार-पैन लिंक स्थिति",
        url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status",
        enDesc: "Verify if PAN is legally linked with Aadhaar.",
        hiDesc: "सत्यापित करें कि क्या पैन कानूनी रूप से आधार से जुड़ा है।",
      ),
      ToolData(
        enName: "Verify PAN (OTP)",
        hiName: "पैन सत्यापित करें (OTP)",
        url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN",
        enDesc: "Deep verification of PAN details via OTP authentication.",
        hiDesc: "OTP प्रमाणीकरण के माध्यम से पैन विवरण का गहरा सत्यापन।",
      ),
      ToolData(
        enName: "Court Case Status",
        hiName: "कोर्ट केस की स्थिति",
        url: "https://services.ecourts.gov.in/ecourtindia_v6/?p=casestatus/index",
        enDesc: "Search judicial records using the latest v6 engine.",
        hiDesc: "नवीनतम v6 इंजन का उपयोग करके न्यायिक रिकॉर्ड खोजें।",
      ),
      ToolData(
        enName: "Missing Persons",
        hiName: "लापता व्यक्ति खोज",
        url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm",
        enDesc: "Search national database for registered missing persons.",
        hiDesc: "पंजीकृत लापता व्यक्तियों के लिए राष्ट्रीय डेटाबेस खोजें।",
      ),
      ToolData(
        enName: "Proclaimed Offenders",
        hiName: "घोषित अपराधी",
        url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm",
        enDesc: "Check criminal records for wanted individuals.",
        hiDesc: "वांछित व्यक्तियों के लिए आपराधिक रिकॉर्ड की जांच करें।",
      ),
    ],
  },
  "ASSETS": {
    "enTitle": "Assets & Vehicles",
    "hiTitle": "संपत्ति और वाहन",
    "icon": Icons.directions_car, // Restored V1 Car Icon
    "color": 0xFF2E7D32,
    "tools": [
      ToolData(
        enName: "Vehicle RC Status",
        hiName: "वाहन RC स्थिति",
        url: "https://vahan.parivahan.gov.in/nrservices/faces/user/citizen/citizenlogin.xhtml",
        enDesc: "Login to check RC, PUC, and Insurance validity.",
        hiDesc: "RC, PUC और बीमा वैधता की जांच करने के लिए लॉगिन करें।",
      ),
      ToolData(
        enName: "Stolen Vehicle / NOC",
        hiName: "चोरी का वाहन / NOC",
        url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm",
        enDesc: "Check for police cases or download vehicle NOC.",
        hiDesc: "पुलिस मामलों की जांच करें या वाहन NOC डाउनलोड करें।",
      ),
      ToolData(
        enName: "Pay E-Challan",
        hiName: "ई-चालान भुगतान",
        url: "https://echallan.parivahan.gov.in/index/accused-challan",
        enDesc: "Verify and pay pending traffic fines.",
        hiDesc: "लंबित ट्रैफिक जुर्माने को सत्यापित करें और भुगतान करें।",
      ),
    ],
  },
  "BUSINESS": {
    "enTitle": "Business & GST",
    "hiTitle": "व्यापार और GST",
    "icon": Icons.store,
    "color": 0xFF6A1B9A,
    "tools": [
      ToolData(
        enName: "GST Verification",
        hiName: "GST सत्यापन",
        url: "https://cleartax.in/gst-number-search/",
        enDesc: "Data via ClearTax. Disclaimer: Non-Gov source.",
        hiDesc: "ClearTax के माध्यम से डेटा। अस्वीकरण: गैर-सरकारी स्रोत।",
      ),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance & Taxes",
    "hiTitle": "वित्त और कर",
    "icon": Icons.account_balance,
    "color": 0xFFE65100,
    "tools": [
      ToolData(
        enName: "Verify Bank Account",
        hiName: "बैंक खाता सत्यापित करें",
        url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx",
        enDesc: "Public status validator for bank accounts.",
        hiDesc: "बैंक खातों के लिए सार्वजनिक स्थिति सत्यापनकर्ता।",
      ),
    ],
  }
};

// Data for "How to Verify" guide
final List<Map<String, String>> verificationSteps = [
  {
    "en": "Step 1: Check Aadhaar Validity for demographic details.",
    "hi": "चरण 1: जनसांख्यिकीय विवरण के लिए आधार वैधता की जांच करें।"
  },
  {
    "en": "Step 2: Verify Aadhaar-PAN linking status.",
    "hi": "चरण 2: आधार-पैन लिंकिंग स्थिति सत्यापित करें।"
  },
  {
    "en": "Step 3: Use QR or Face RD for physical identity matching.",
    "hi": "चरण 3: भौतिक पहचान मिलान के लिए QR या फेस RD का उपयोग करें।"
  },
  {
    "en": "Step 4: Verify Vehicle RC and check for Police NOC/Challans.",
    "hi": "चरण 4: वाहन RC सत्यापित करें और पुलिस NOC/चालान की जांच करें।"
  }
];
