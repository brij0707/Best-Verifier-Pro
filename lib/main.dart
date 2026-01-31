import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'links_data.dart';

void main() {
  runApp(const BestVerifierApp());
}

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

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;
  bool isHindi = false;

  // Toggle Language
  void _toggleLanguage() {
    setState(() {
      isHindi = !isHindi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHindi ? "बेस्ट वेरिफायर" : "Best Verifier",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D47A1),
        actions: [
          // The A/अ Language Toggle
          TextButton.icon(
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.translate, color: Colors.white, size: 18),
            label: Text(
              isHindi ? "English" : "हिंदी",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      // Switching between Tab 1 (Investigation) and Tab 2 (My Docs)
      body: _selectedIndex == 0 
          ? InvestigationTab(isHindi: isHindi) 
          : MyDocumentsTab(isHindi: isHindi),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF0D47A1),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.verified_user),
            label: isHindi ? "सत्यापन" : "Verify Others",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.folder_shared),
            label: isHindi ? "मेरे दस्तावेज़" : "My Documents",
          ),
        ],
      ),
    );
  }
}

class InvestigationTab extends StatelessWidget {
  final bool isHindi;
  const InvestigationTab({super.key, required this.isHindi});

  // Launch Logic for Apps and Full Web URLs
  Future<void> _handleLaunch(ToolData tool) async {
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
  }

  // Tool List Modal (Triggered by Grid Clicks)
  void _showToolList(BuildContext context, Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                isHindi ? category['hiTitle'] : category['enTitle'],
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold, 
                  color: Color(category['color'])
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: category['tools'].length,
                itemBuilder: (context, index) {
                  ToolData tool = category['tools'][index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(category['color']).withOpacity(0.1),
                      child: Icon(category['icon'], color: Color(category['color'])),
                    ),
                    title: Text(isHindi ? tool.hiName : tool.enName),
                    subtitle: Text(isHindi ? tool.hiDesc : tool.enDesc),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () => _handleLaunch(tool),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Detailed 6.1 Logic Guide
  void _showHowToVerify(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? "सत्यापन कैसे करें (रणनीति)" : "How to Verify (Strategy)"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _guideStep("1", isHindi ? "आधार वैधता: जनसांख्यिकीय विवरण (आयु/लिंग/राज्य) की पुष्टि करें।" : "Aadhaar Validity: Confirm demographic details (Age/Gender/State)."),
              _guideStep("2", isHindi ? "आधार-पैन लिंक: सरकारी रिकॉर्ड में निरंतरता की जांच करें।" : "Aadhaar-PAN Link: Check consistency across government records."),
              _guideStep("3", isHindi ? "लाइवनेस (QR/Face): व्यक्ति का आईडी से भौतिक मिलान करें।" : "Liveness (QR/Face): Physically match the person with the ID."),
              _guideStep("4", isHindi ? "संपत्ति और NOC: चोरी के रिकॉर्ड या पुलिस मामलों की जांच करें।" : "Assets & NOC: Check for stolen records or police cases."),
              _guideStep("5", isHindi ? "अनुपालन: लंबित चालानों की जांच करें।" : "Compliance: Check for pending challans."),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(isHindi ? "बंद करें" : "Close"))
        ],
      ),
    );
  }

  Widget _guideStep(String num, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 12, child: Text(num, style: const TextStyle(fontSize: 12))),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // The 4-Category Grid (Restored V1 Colors)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: gridCategories.entries.map((e) {
              final cat = e.value;
              return Card(
                elevation: 4,
                color: Color(cat['color']),
                child: InkWell(
                  onTap: () => _showToolList(context, cat),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cat['icon'], color: Colors.white, size: 45),
                      const SizedBox(height: 10),
                      Text(
                        isHindi ? cat['hiTitle'] : cat['enTitle'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          
          const Divider(),

          // The Meta-Strategy Button
          ListTile(
            leading: const Icon(Icons.psychology_outlined, color: Colors.blueAccent),
            title: Text(isHindi ? "6.1 सत्यापन कैसे करें" : "6.1 How to Verify"),
            subtitle: Text(isHindi ? "विस्तृत जांच रणनीति देखें" : "View Detailed Investigation Strategy"),
            trailing: const Icon(Icons.info_outline),
            onTap: () => _showHowToVerify(context),
          ),

          const SizedBox(height: 20),
          Text(
            isHindi ? "अस्वीकरण: हम सरकार से संबद्ध नहीं हैं।" : "Disclaimer: We are not affiliated with the Govt.",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MyDocumentsTab extends StatelessWidget {
  final bool isHindi;
  const MyDocumentsTab({super.key, required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.folder_open, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            isHindi ? "मेरे दस्तावेज़ अनुभाग जल्द ही आ रहा है" : "My Documents Section Coming Soon",
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
