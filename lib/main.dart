import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'links_data.dart';

void main() => runApp(const BestVerifierApp());

class BestVerifierApp extends StatelessWidget {
  const BestVerifierApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: const Color(0xFF0D47A1),
        fontFamily: 'Roboto', // We will add Noto Sans support for Hindi later
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isHindi = false;

  // --- LOGIC SECTION ---

  Future<void> _handleLaunch(ToolData tool) async {
    try {
      if (tool.isApp) {
        await LaunchApp.openApp(
          androidPackageName: tool.url,
          openStore: true,
        );
      } else {
        final Uri uri = Uri.parse(tool.url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      debugPrint("Error launching: $e");
    }
  }

  void _showInfo(ToolData tool) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? tool.hiName : tool.enName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isHindi ? tool.hiDesc : tool.enDesc),
            const SizedBox(height: 15),
            Text(
              isHindi ? "सुरक्षा नोट: हम आपका डेटा स्टोर नहीं करते हैं।" : "Security Note: We do not store your data.",
              style: const TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(isHindi ? "ठीक है" : "OK")),
        ],
      ),
    );
  }

  void _showEmergencyList() {
    final List<Map<String, String>> contacts = [
      {"en": "National Emergency", "hi": "राष्ट्रीय आपातकाल", "num": "112"},
      {"en": "Police Helpdesk", "hi": "पुलिस हेल्पलाइन", "num": "100"},
      {"en": "Ambulance", "hi": "एम्बुलेंस", "num": "102"},
      {"en": "Fire Brigade", "hi": "दमकल केंद्र", "num": "101"},
      {"en": "Cyber Fraud", "hi": "साइबर धोखाधड़ी", "num": "1930"},
      {"en": "Women Helpline", "hi": "महिला हेल्पलाइन", "num": "1091"},
      {"en": "Highway Accident", "hi": "राजमार्ग सहायता", "num": "1033"},
      {"en": "Child Helpline", "hi": "चाइल्ड हेल्पलाइन", "num": "1098"},
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(isHindi ? "आपातकालीन संपर्क" : "Emergency Contacts", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: ListView(
                children: contacts.map((c) => ListTile(
                  leading: const Icon(Icons.phone_in_talk, color: Colors.red),
                  title: Text(isHindi ? c['hi']! : c['en']!),
                  subtitle: Text(c['num']!),
                  trailing: ElevatedButton(
                    onPressed: () => launchUrl(Uri.parse("tel:${c['num']}")),
                    child: Text(isHindi ? "कॉल" : "Call"),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showVerificationGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? "सत्यापन मार्गदर्शिका" : "How to Verify"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: verificationSteps.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text("• ${isHindi ? s['hi'] : s['en']}", style: const TextStyle(fontSize: 14)),
            )).toList(),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(isHindi ? "बंद करें" : "Close"))],
      ),
    );
  }

  // --- UI BUILD SECTION ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "बेस्ट वेरिफायर" : "Best Verifier", style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => isHindi = !isHindi),
            icon: const Icon(Icons.translate, color: Colors.white, size: 18),
            label: Text(isHindi ? "English" : "हिंदी", style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Disclaimer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.amber.shade100,
              child: Text(
                isHindi ? "सूचना: हम एक निजी निर्देशिका हैं, सरकारी ऐप नहीं।" : "Note: Private directory, not a Govt app.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: gridCategories.entries.map((e) => Card(
                elevation: 4,
                color: Color(e.value['color']),
                child: InkWell(
                  onTap: () => _showTools(e.value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(e.value['icon'], color: Colors.white, size: 45),
                      const SizedBox(height: 8),
                      Text(
                        isHindi ? e.value['hiTitle'] : e.value['enTitle'], 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),

            const Divider(),
            _buildActionTile(Icons.rule, isHindi ? "सत्यापन कैसे करें" : "How to Verify", _showVerificationGuide),
            _buildActionTile(Icons.emergency_outlined, isHindi ? "आपातकालीन नंबर" : "Emergency Numbers", _showEmergencyList, color: Colors.red),
            
            const SizedBox(height: 30),
            Text(
              isHindi ? "ईमेल: Innomind2022@gmail.com" : "Email: Innomind2022@gmail.com",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            TextButton(
              onPressed: () => launchUrl(Uri.parse("mailto:$developerEmail")),
              child: Text(isHindi ? "सुझाव भेजें" : "Send Suggestions"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String label, VoidCallback tap, {Color? color}) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color?.withOpacity(0.1) ?? Colors.blue.withOpacity(0.1), child: Icon(icon, color: color ?? Colors.blue)),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: tap,
    );
  }

  void _showTools(Map<String, dynamic> cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isHindi ? cat['hiTitle'] : cat['enTitle'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: cat['tools'].map<Widget>((ToolData t) => ListTile(
                  leading: Icon(cat['icon'], color: Color(cat['color'])),
                  title: Text(isHindi ? t.hiName : t.enName),
                  trailing: IconButton(icon: const Icon(Icons.info_outline), onPressed: () => _showInfo(t)),
                  onTap: () => _handleLaunch(t),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
