import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
// Links the data logic to the UI
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

  // FIXED EMAIL LOGIC: Properly encoded for mobile apps
  Future<void> _sendEmail() async {
    final String subject = Uri.encodeComponent("Feedback from App side");
    final String body = Uri.encodeComponent("Sent from Best Verifier App side\n\n[Your Message]");
    final Uri emailUri = Uri.parse("mailto:$developerEmail?subject=$subject&body=$body");
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isHindi ? "ईमेल ऐप नहीं मिला" : "No email app found")),
      );
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
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14, 
                        backgroundColor: const Color(0xFF0D47A1), 
                        child: Text(fullStrategy[i]['step']!, style: const TextStyle(color: Colors.white, fontSize: 12))
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(isHindi ? fullStrategy[i]['title_hi']! : fullStrategy[i]['title_en']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 38, top: 6),
                    child: Text(isHindi ? fullStrategy[i]['hi']! : fullStrategy[i]['en']!, style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4)),
                  ),
                ],
              ),
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
          // UPDATED: A/अ Toggle button
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
          _buildDisclaimer(),
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
          _buildPrivacyFooter(),
        ],
      ),
    );
  }

  Widget _buildOwnDocsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          ...ownDocsTools.map((tool) => Card(
            elevation: 0, color: Colors.grey.shade100, margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.blueGrey, child: Icon(Icons.folder, color: Colors.white, size: 20)),
              title: Text(isHindi ? tool.hiName : tool.enName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(isHindi ? tool.hiDesc : tool.enDesc),
              onTap: () => _handleAction(tool),
            ),
          )).toList(),
          _buildEmergencyButton(),
          _buildPrivacyFooter(),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(12), color: Colors.amber.shade50,
      child: Text(
        isHindi ? "डिस्क्लेमर: हम एक निजी निर्देशिका हैं और किसी भी सरकारी संस्था से संबद्ध नहीं हैं।" 
        : "Disclaimer: We are a private directory and not affiliated with any Government entity.",
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.brown),
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade700, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 55)),
        onPressed: _showEmergencyHub,
        icon: const Icon(Icons.emergency),
        label: Text(isHindi ? "आपातकालीन डायल" : "EMERGENCY DIALER"),
      ),
    );
  }

  Widget _buildPrivacyFooter() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        isHindi ? "गोपनीयता सूचना: हम आपके द्वारा सत्यापित किसी भी व्यक्तिगत डेटा को स्टोर नहीं करते हैं।"
        : "Privacy Notice: We do not store, save, or share any personal data or documents you verify.",
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  void _showEmergencyHub() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(isHindi ? "आपातकालीन नंबर" : "Emergency Numbers", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
            const Divider(),
            ...emergencyList.map((e) => ListTile(
              leading: const Icon(Icons.phone_forwarded, color: Colors.red),
              title: Text(isHindi ? e['hi']! : e['name']!),
              trailing: Text(e['num']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              onTap: () => launchUrl(Uri.parse("tel:${e['num']}")),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _showToolModal(Map<String, dynamic> cat) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.65, expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController, padding: const EdgeInsets.all(25),
          children: [
            Text(isHindi ? cat['hiTitle'] : cat['enTitle'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            const Divider(height: 30),
            ...cat['tools'].map<Widget>((ToolData t) => ListTile(
              leading: Icon(cat['icon'], color: Color(cat['color'])),
              title: Text(isHindi ? t.hiName : t.enName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(isHindi ? t.hiDesc : t.enDesc),
              onTap: () => _handleAction(t),
            )).toList(),
          ],
        ),
      ),
    );
  }

  void _handleAction(ToolData tool) async {
    if (Platform.isIOS && tool.isApp) {
      showDialog(context: context, builder: (c) => AlertDialog(
        title: const Text("iOS Notice"),
        content: const Text("This biometric feature is currently optimized for Android. Coming soon to iOS."),
        actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text("OK"))],
      ));
      return;
    }
    if (tool.isApp) {
      bool? go = await showDialog<bool>(context: context, builder: (c) => AlertDialog(
        title: Text(isHindi ? "ऐप आवश्यक" : "App Required"),
        content: Text(isHindi ? "${tool.enName} ऐप की आवश्यकता है। क्या आप स्टोर पर जाना चाहते हैं?" : "The official ${tool.enName} app is required. Proceed to Store?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(isHindi ? "नहीं" : "No")),
          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(isHindi ? "हाँ" : "Yes")),
        ],
      ));
      if (go == true) await LaunchApp.openApp(androidPackageName: tool.url, openStore: true);
    } else {
      await launchUrl(Uri.parse(tool.url), mode: LaunchMode.externalApplication);
    }
  }
}
