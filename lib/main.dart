import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
// Core logic and data links
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
      ),
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

  // --- FEATURE 1: FIXED EMAIL LOGIC ---
  Future<void> _sendEmail() async {
    final String subject = Uri.encodeComponent("Best Verifier: App Feedback");
    final String body = Uri.encodeComponent("Sent from Best Verifier Mobile Side\n\n[Your Message Here]");
    final Uri emailUri = Uri.parse("mailto:$developerEmail?subject=$subject&body=$body");
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isHindi ? "ईमेल ऐप नहीं मिला" : "No email app found")),
      );
    }
  }

  // --- FEATURE 2: AI SCANNER ONBOARDING (NEW) ---
  void _showScannerOnboarding() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)))),
            const SizedBox(height: 20),
            Text(
              isHindi ? "AI स्कैनर कैसे काम करता है?" : "How AI Scanner Works?",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
            ),
            const SizedBox(height: 20),
            _stepRow(Icons.document_scanner, isHindi ? "कैमरा खोलें और दस्तावेज़ (RC, PAN, Court Case) पर केंद्रित करें।" : "Point camera at any ID or legal document."),
            _stepRow(Icons.psychology, isHindi ? "AI स्वतः महत्वपूर्ण नंबरों की पहचान और एक्सट्रैक्शन करेगा।" : "AI auto-detects and extracts IDs like RC or CNR."),
            _stepRow(Icons.content_copy, isHindi ? "नंबर क्लिपबोर्ड पर कॉपी हो जाएगा और सही टूल खुल जाएगा।" : "The ID is copied and the relevant portal opens."),
            _stepRow(Icons.security, isHindi ? "गोपनीयता: कोई डेटा स्टोर नहीं होता, प्रोसेसिंग ऑन-डिवाइस है।" : "Privacy: No data is stored; all processing is local."),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Placeholder for Step 6: Triggering the Actual Camera Logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isHindi ? "समझ गया, शुरू करें" : "Got it, Start Scanning"),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _stepRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0D47A1), size: 28),
          const SizedBox(width: 15),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, height: 1.4))),
        ],
      ),
    );
  }

  // --- FEATURE 3: STRATEGY MODAL ---
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
            itemBuilder: (context, i) => ListTile(
              leading: CircleAvatar(child: Text(fullStrategy[i]['step']!)),
              title: Text(isHindi ? fullStrategy[i]['title_hi']! : fullStrategy[i]['title_en']!),
              subtitle: Text(isHindi ? fullStrategy[i]['hi']! : fullStrategy[i]['en']!),
            ),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(isHindi ? "ठीक है" : "Got it"))],
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
          IconButton(icon: const Icon(Icons.info_outline, color: Colors.white), onPressed: _showStrategyGuide),
          TextButton(
            onPressed: () => setState(() => isHindi = !isHindi),
            child: Text(
              isHindi ? "A/English" : "अ/हिंदी", 
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: isHindi ? "सत्यापन" : "Verify Others"),
            Tab(text: isHindi ? "दस्तावेज़" : "Own Docs"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildVerifyTab(), _buildOwnDocsTab()],
      ),
    );
  }

  Widget _buildVerifyTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDisclaimer(),
          const SizedBox(height: 15),
          // AI SCANNER UI BLOCK
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0D47A1).withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFF0D47A1).withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Color(0xFF0D47A1)),
                      const SizedBox(width: 10),
                      Text(isHindi ? "AI स्मार्ट स्कैनर" : "AI Smart Scanner", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isHindi ? "कैमरा का उपयोग करके दस्तावेज़ों को तेज़ी से पहचानें।" : "Identify documents instantly using your camera.",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: _showScannerOnboarding,
                    icon: const Icon(Icons.camera_alt),
                    label: Text(isHindi ? "स्कैन शुरू करें" : "Start Smart Scan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 25,
            children: gridCategories.entries.map((e) => Column(
              children: [
                InkWell(
                  onTap: () => _showToolModal(e.value),
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Color(e.value['color']).withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(e.value['color']).withOpacity(0.5), width: 2),
                    ),
                    child: Icon(e.value['icon'], color: Color(e.value['color']), size: 40),
                  ),
                ),
                const SizedBox(height: 10),
                Text(isHindi ? e.value['hiTitle'] : e.value['enTitle'], style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            )).toList(),
          ),
          _buildEmergencyButton(),
        ],
      ),
    );
  }

  Widget _buildOwnDocsTab() {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: 20),
        ...ownDocsTools.map((tool) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.folder_shared, color: Colors.blueGrey),
            title: Text(isHindi ? tool.hiName : tool.enName),
            subtitle: Text(isHindi ? tool.hiDesc : tool.enDesc),
            onTap: () => _handleAction(tool),
          ),
        )).toList(),
        _buildEmergencyButton(),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.amber.shade50,
      child: Text(
        isHindi ? "डिस्क्लेमर: हम एक निजी निर्देशिका हैं।" : "Disclaimer: We are a private directory.",
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, color: Colors.brown),
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 55)),
        onPressed: _showEmergencyHub,
        icon: const Icon(Icons.emergency),
        label: Text(isHindi ? "आपातकालीन डायल" : "EMERGENCY DIALER"),
      ),
    );
  }

  void _showEmergencyHub() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(isHindi ? "आपातकालीन नंबर" : "Emergency Numbers", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
          const Divider(),
          ...emergencyList.map((e) => ListTile(
            leading: const Icon(Icons.phone, color: Colors.red),
            title: Text(isHindi ? e['hi']! : e['name']!),
            trailing: Text(e['num']!),
            onTap: () => launchUrl(Uri.parse("tel:${e['num']}")),
          )).toList(),
        ],
      ),
    );
  }

  void _showToolModal(Map<String, dynamic> cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6, expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController, padding: const EdgeInsets.all(25),
          children: [
            Text(isHindi ? cat['hiTitle'] : cat['enTitle'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            const Divider(height: 30),
            ...cat['tools'].map<Widget>((ToolData t) => ListTile(
              leading: Icon(cat['icon'], color: Color(cat['color'])),
              title: Text(isHindi ? t.hiName : t.enName),
              onTap: () => _handleAction(t),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _handleAction(ToolData tool) async {
    if (tool.isApp) {
      await LaunchApp.openApp(androidPackageName: tool.url.contains("play.google.com") ? faceRDAppPackage : tool.url, openStore: true);
    } else {
      await launchUrl(Uri.parse(tool.url), mode: LaunchMode.externalApplication);
    }
  }
}
