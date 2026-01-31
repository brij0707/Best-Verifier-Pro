import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'links_data.dart'; // Connecting to our Brain file

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
  bool isHindi = false; // The Language Toggle State

  // Logic to launch Web or App
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

  // Show Info Dialog
  void _showInfo(ToolData tool) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? tool.hiName : tool.enName),
        content: Text(isHindi ? tool.hiDesc : tool.enDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isHindi ? "ठीक है" : "OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? "बेस्ट वेरिफायर" : "Best Verifier"),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        actions: [
          // The A/अ Toggle Button
          TextButton(
            onPressed: () => setState(() => isHindi = !isHindi),
            child: Text(
              isHindi ? "A/English" : "अ/हिंदी",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 4-Category Grid with Restored V1 Icons
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: gridCategories.length,
              itemBuilder: (context, index) {
                String key = gridCategories.keys.elementAt(index);
                var category = gridCategories[key]!;
                return Card(
                  color: Color(category['color']),
                  child: InkWell(
                    onTap: () => _showCategoryTools(category),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'], size: 50, color: Colors.white),
                        const SizedBox(height: 10),
                        Text(
                          isHindi ? category['hiTitle'] : category['enTitle'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            // Bottom Meta-Buttons Section
            _buildMetaButton(
              icon: Icons.assignment_outlined,
              title: isHindi ? "सत्यापन कैसे करें" : "How to Verify",
              onTap: _showVerificationGuide,
            ),
            _buildMetaButton(
              icon: Icons.emergency_share,
              title: isHindi ? "आपातकालीन संपर्क" : "Emergency Contacts",
              color: Colors.red.shade800,
              onTap: () {}, // Next Step: Emergency List
            ),
            
            // Footer Disclaimer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                isHindi 
                  ? "अस्वीकरण: हम सरकार से संबद्ध नहीं हैं।" 
                  : "Disclaimer: Not affiliated with Govt.",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List View for Tools inside Categories
  void _showCategoryTools(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) => ListView.builder(
          controller: scrollController,
          itemCount: category['tools'].length,
          itemBuilder: (context, index) {
            ToolData tool = category['tools'][index];
            return ListTile(
              leading: Icon(category['icon']),
              title: Text(isHindi ? tool.hiName : tool.enName),
              trailing: IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showInfo(tool),
              ),
              onTap: () => _handleLaunch(tool),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetaButton({required IconData icon, required String title, required VoidCallback onTap, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        tileColor: color ?? Colors.blueGrey.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(icon, color: color != null ? Colors.white : Colors.black),
        title: Text(title, style: TextStyle(color: color != null ? Colors.white : Colors.black)),
        onTap: onTap,
      ),
    );
  }

  void _showVerificationGuide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isHindi ? "सत्यापन प्रक्रिया" : "How to Verify"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: verificationSteps.map((step) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text("• ${isHindi ? step['hi'] : step['en']}"),
          )).toList(),
        ),
      ),
    );
  }
}
