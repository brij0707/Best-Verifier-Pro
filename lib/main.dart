import 'package:flutter/material.dart';
import 'dart:io';
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
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF0D47A1)),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});
  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isHindi = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // Pre-written Email Logic
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: developerEmail,
      queryParameters: {
        'subject': 'Feedback from App side',
        'body': 'Sent from Best Verifier App side\n\n[Write your message here]'
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _showStrategyGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? "विस्तृत जांच रणनीति" : "Detailed Investigation Strategy"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: fullStrategy.length,
            itemBuilder: (context, i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 12, child: Text(fullStrategy[i]['step']!)),
                      const SizedBox(width: 10),
                      Text(isHindi ? fullStrategy[i]['title_hi']! : fullStrategy[i]['title_en']!,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 34, top: 5),
                    child: Text(isHindi ? fullStrategy[i]['hi']! : fullStrategy[i]['en']!,
                        style: const TextStyle(fontSize: 13, color: Colors.black87)),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(isHindi ? "समझ गया" : "Got it"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Verifier", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0D47A1),
        actions: [
          IconButton(icon: const Icon(Icons.email_outlined, color: Colors.white), onPressed: _sendEmail),
          IconButton(
            icon: const Icon(Icons.translate, color: Colors.white),
            onPressed: () => setState(() => isHindi = !isHindi),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: isHindi ? "सत्यापन" : "Verify Others"),
            Tab(text: isHindi ? "दस्तावेज़" : "Own Docs"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVerifyTab(),
          _buildOwnDocsTab(),
        ],
      ),
    );
  }

  Widget _buildVerifyTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Disclaimer Line
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: Colors.amber.shade100,
            child: Text(
              isHindi ? "डिस्क्लेमर: हम एक निजी निर्देशिका हैं और किसी भी सरकारी संस्था से संबद्ध नहीं हैं।" 
              : "Disclaimer: We are a private directory and not affiliated with any Government entity.",
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
          
          // 4 Grid Categories
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 20,
            children: gridCategories.entries.map((e) => Column(
              children: [
                InkWell(
                  onTap: () => _showToolModal(e.value),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Color(e.value['color']).withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(e.value['color']).withOpacity(0.4), width: 2),
                    ),
                    child: Icon(e.value['icon'], color: Color(e.value['color']), size: 38),
                  ),
                ),
                const SizedBox(height: 10),
                Text(isHindi ? e.value['hiTitle'] : e.value['enTitle'], style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            )).toList(),
          ),

          // Strategy & Emergency Section
          ListTile(
            onTap: _showStrategyGuide,
            leading: const Icon(Icons.info_outline, color: Colors.blue),
            title: Text(isHindi ? "जांच रणनीति (स्टेप-बाय-स्टेप)" : "Investigation Strategy (Step-by-Step)"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 52)),
              onPressed: _showEmergencyHub,
              icon: const Icon(Icons.emergency),
              label: Text(isHindi ? "आपातकालीन डायल" : "EMERGENCY DIALER"),
            ),
          ),

          // Privacy Footer
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              isHindi ? "गोपनीयता सूचना: हम आपके द्वारा सत्यापित किसी भी व्यक्तिगत डेटा या दस्तावेज़ को स्टोर, सेव या साझा नहीं करते हैं।"
              : "Privacy Notice: We do not store, save, or share any personal data or documents you verify.",
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  void _showToolModal(Map<String, dynamic> cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          children: [
            Text(isHindi ? cat['hiTitle'] : cat['enTitle'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Divider(),
            ...cat['tools'].map<Widget>((ToolData t) => ListTile(
              leading: Icon(cat['icon'], color: Color(cat['color'])),
              title: Text(isHindi ? t.hiName : t.enName),
              subtitle: Text(isHindi ? t.hiDesc : t.enDesc),
              onTap: () => _handleAction(t),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _handleAction(ToolData tool) async {
    // iOS Compatibility Check
    if (Platform.isIOS && tool.isApp) {
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text("Coming Soon to iOS"),
          content: const Text("This biometric feature is currently optimized for Android due to UIDAI restrictions. It is coming soon to iOS."),
          actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("OK"))],
        ),
      );
      return;
    }

    // Android App Pre-Redirect Notice
    if (tool.isApp) {
      bool? go = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(isHindi ? "ऐप की आवश्यकता" : "App Required"),
          content: Text(isHindi ? "इस फीचर के लिए आधिकारिक ${tool.enName} ऐप की आवश्यकता है। क्या आप स्टोर पर जाना चाहते हैं?" : "This feature requires the official ${tool.enName} app. Proceed to Store?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: Text(isHindi ? "नहीं" : "No")),
            TextButton(onPressed: () => Navigator.pop(c, true), child: Text(isHindi ? "हाँ" : "Yes")),
          ],
        ),
      );
      if (go == true) await LaunchApp.openApp(androidPackageName: tool.url, openStore: true);
    } else {
      await launchUrl(Uri.parse(tool.url), mode: LaunchMode.externalApplication);
    }
  }

  void _showEmergencyHub() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: const Icon(Icons.local_police, color: Colors.red), title: const Text("Police (100)"), onTap: () => launchUrl(Uri.parse("tel:100"))),
          ListTile(leading: const Icon(Icons.security, color: Colors.red), title: const Text("Cyber Fraud (1930)"), onTap: () => launchUrl(Uri.parse("tel:1930"))),
          ListTile(leading: const Icon(Icons.emergency, color: Colors.red), title: const Text("National Emergency (112)"), onTap: () => launchUrl(Uri.parse("tel:112"))),
        ],
      ),
    );
  }

  Widget _buildOwnDocsTab() => const Center(child: Text("Own Docs Portals - Coming Soon"));
}
