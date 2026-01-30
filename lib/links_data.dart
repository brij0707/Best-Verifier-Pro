// Official Android package names for the Government apps
const String uidaiScannerPackage = "in.net.uidai.qrcodescanner";
const String faceRDAppPackage = "in.gov.uidai.facerd";

// Support Contact Details
const String contactEmail = "support@bestverifier.in";
const String emailSubject = "Best Verifier Suggestion";

final Map<String, Map<String, dynamic>> gridCategories = {
  "IDENTITY": {
    "title": "Identity & Verification",
    "icon": "person",
    "color": 0xFF0D47A1,
    "verify": [
      {
        "name": "Official QR Scanner",
        "url": uidaiScannerPackage, 
        "desc": "Verify 2048-bit digital signature & photo.",
        "isApp": true // Triggers the Transparency Notification popup
      },
      {
        "name": "Face Authentication",
        "url": faceRDAppPackage,
        "desc": "Liveness check via Aadhaar Face RD.",
        "isApp": true
      },
      {"name": "Verify Aadhaar", "url": "https://myaadhaar.uidai.gov.in/verifyAadhaar", "desc": "Check if an Aadhaar number exists."},
      {"name": "Verify PAN", "url": "https://eportal.incometax.gov.in/iec/foservices/#/pre-login/verifyYourPAN", "desc": "Check if a PAN is active."},
      {"name": "Police Clearance (PCC)", "url": "https://digitalpolice.gov.in/Create_PCC_Request.aspx", "desc": "Check criminal background status."},
    ],
    "personal": [
      {"name": "Download Aadhaar", "url": "https://myaadhaar.uidai.gov.in/gen-aadhaar", "desc": "Download your E-Aadhaar."},
      {"name": "DigiLocker", "url": "https://www.digilocker.gov.in/", "desc": "Access your stored documents."},
      {"name": "Passport Status", "url": "https://www.passportindia.gov.in/AppOnlineProject/statusTracker/trackStatusInpNew", "desc": "Track your application."},
    ]
  },
  "ASSETS": {
    "title": "Assets & Vehicles",
    "icon": "directions_car",
    "color": 0xFF2E7D32,
    "verify": [
      {"name": "Vehicle RC Status", "url": "https://vahan.parivahan.gov.in/nrservices/faces/user/prelogin/index.xhtml", "desc": "Verify vehicle owner and age."},
      {"name": "Stolen Vehicle Check", "url": "https://digitalpolice.gov.in/StolenVehicleCheck.aspx", "desc": "Check if vehicle is blacklisted."},
    ],
    "personal": [
      {"name": "E-Challan Pay", "url": "https://echallan.parivahan.gov.in/index/accused-challan", "desc": "Check and pay traffic fines."},
    ]
  },
  "BUSINESS": {
    "title": "Business & GST",
    "icon": "store",
    "color": 0xFF6A1B9A,
    "verify": [
      {"name": "GST Verification", "url": "https://services.gst.gov.in/services/searchtp", "desc": "Verify a business GSTIN."},
      {"name": "Company/Director Check", "url": "https://www.mca.gov.in/mca21/Verify_DIN.html", "desc": "Verify MCA registration."},
    ],
    "personal": [
      {"name": "FSSAI License", "url": "https://foscos.fssai.gov.in/index", "desc": "Manage food business license."},
    ]
  },
  "FINANCE": {
    "title": "Finance & Taxes",
    "icon": "account_balance_wallet",
    "color": 0xFFE65100,
    "verify": [
      {"name": "Court Case Search", "url": "https://ecourts.gov.in/ecourts_home/", "desc": "Check for legal litigation."},
    ],
    "personal": [
      {"name": "File ITR", "url": "https://www.incometax.gov.in/iec/foportal/", "desc": "Income tax filing portal."},
      {"name": "EPFO Passbook", "url": "https://passbook.epfindia.gov.in/MemberPassBook/Login", "desc": "Check your PF balance."},
    ]
  }
};

