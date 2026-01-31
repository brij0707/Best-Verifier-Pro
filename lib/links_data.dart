import 'package:flutter/material.dart';

const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";
const String developerEmail = "Innomind2022@gmail.com";

class ToolData {
  final String enName, hiName, url, enDesc, hiDesc;
  final bool isApp;
  ToolData({required this.enName, required this.hiName, required this.url, required this.enDesc, required this.hiDesc, this.isApp = false});
}

final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "enTitle": "Identity", "hiTitle": "पहचान", "icon": Icons.person, "color": 0xFF2196F3,
    "tools": [
      ToolData(enName: "Aadhaar QR Scanner", hiName: "आधार QR स्कैनर", url: uidaiScannerPackage, isApp: true, enDesc: "Digital signature check.", hiDesc: "डिजिटल हस्ताक्षर जांच।"),
      ToolData(enName: "Aadhaar Face RD", hiName: "आधार फेस RD", url: faceRDAppPackage, isApp: true, enDesc: "Liveness check.", hiDesc: "लाइवनेस चेक।"),
      ToolData(enName: "Aadhaar Validity", hiName: "आधार वैधता", url: "https://myaadhaar.uidai.gov.in/check-aadhaar-validity/en", enDesc: "Free demographic check.", hiDesc: "नि:शुल्क जनसांख्यिकीय जांच।"),
      ToolData(enName: "Aadhaar-PAN Link", hiName: "आधार-पैन लिंक", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/link-aadhaar-status", enDesc: "Cross-link check.", hiDesc: "लिंक की जांच करें।"),
      ToolData(enName: "Verify PAN (OTP)", hiName: "पैन सत्यापन (OTP)", url: "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN", enDesc: "Deep OTP check.", hiDesc: "गहरा OTP सत्यापन।"),
      ToolData(enName: "Court Case (v6)", hiName: "कोर्ट केस", url: "https://services.ecourts.gov.in/ecourtindia_v6/?p=casestatus/index", enDesc: "Search records.", hiDesc: "रिकॉर्ड खोजें।"),
      ToolData(enName: "Missing Persons", hiName: "लापता व्यक्ति", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "National search.", hiDesc: "राष्ट्रीय खोज।"),
      ToolData(enName: "Criminal Records", hiName: "अपराधिक रिकॉर्ड", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Offender check.", hiDesc: "अपराधी की जांच।"),
    ],
  },
  "ASSETS": {
    "enTitle": "Assets", "hiTitle": "संपत्ति", "icon": Icons.directions_car, "color": 0xFF4CAF50,
    "tools": [
      ToolData(enName: "Vehicle RC Status", hiName: "वाहन RC स्थिति", url: "https://vahan.parivahan.gov.in/nrservices/faces/user/citizen/citizenlogin.xhtml", enDesc: "Ownership check.", hiDesc: "स्वामित्व जांच।"),
      ToolData(enName: "Stolen Vehicle/NOC", hiName: "चोरी का वाहन/NOC", url: "https://www.digitalpolicecitizenservices.gov.in/centercitizen/login.htm", enDesc: "Police NOC check.", hiDesc: "पुलिस NOC जांच।"),
      ToolData(enName: "Pay E-Challan", hiName: "ई-चालान भुगतान", url: "https://echallan.parivahan.gov.in/index/accused-challan", enDesc: "Traffic fines.", hiDesc: "ट्रैफिक जुर्माना।"),
    ],
  },
  "BUSINESS": {
    "enTitle": "Business", "hiTitle": "व्यापार", "icon": Icons.store, "color": 0xFFFF9800,
    "tools": [
      ToolData(enName: "GST Verification", hiName: "GST सत्यापन", url: "https://cleartax.in/gst-number-search/", enDesc: "ClearTax lookup.", hiDesc: "GST खोजें।"),
      ToolData(enName: "Company Check", hiName: "कंपनी की जांच", url: "https://www.mca.gov.in/mca21/Verify_DIN.html", enDesc: "MCA records.", hiDesc: "MCA रिकॉर्ड।"),
    ],
  },
  "FINANCE": {
    "enTitle": "Finance", "hiTitle": "वित्त", "icon": Icons.account_balance, "color": 0xFF9C27B0,
    "tools": [
      ToolData(enName: "Verify Bank A/C", hiName: "बैंक खाता सत्यापन", url: "https://pfms.nic.in/static/NewLayoutCommonContent.aspx?RequestPagename=Static/KnowYourPayment.aspx", enDesc: "Public validator.", hiDesc: "बैंक सत्यापन।"),
    ],
  },
};
