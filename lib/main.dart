import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:image_picker/image_picker.dart'; // Required for Camera
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; // Required for AI
import 'links_data.dart'; 
import 'ai_scanner.dart'; // Required for Auto-Judge

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

  // --- CAMERA SCANNER LOGIC ---
  Future<void> _startCameraScan() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      
      if (image == null) return; // User cancelled

      // Show processing indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isHindi ? "AI विश्लेषण कर रहा है..." : "AI is analyzing...")),
      );

      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();

      // Pass text to the "Brain"
      final result = AIScannerLogic.judgeDocument(recognizedText.text);

      if (result != null) {
        AIScannerLogic.copyToClipboard(result['id']!);
        _showSuccessDialog(result);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isHindi ? "कोई मान्य ID नहीं मिली (RC/PAN/CNR)" : "No valid RC, PAN, or CNR found.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _showSuccessDialog(Map<String, String> result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Text(isHindi ? "सफल!" : "Success!")
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isHindi ? result['title_hi']! : result['title_en']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            Text("ID: ${result['id']}", style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(isHindi ? "क्लिपबोर्ड पर कॉपी किया गया।" : "Copied to clipboard."),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))
        ],
      ),
    );
  }

  // --- EXISTING UI & LOGIC ---
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

  void _showScannerOnboarding() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isHindi ? "AI स्मार्ट स्कैनर" : "AI Smart Scanner", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Text(isHindi ? "1. कैमरा खोलें\n2. RC, PAN या कोर्ट केस पर पॉइंट करें\n3. AI नंबर कॉपी करेगा" : "1. Open Camera\n2. Point at RC, PAN or Court Case\n3. AI auto-copies the ID"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _startCameraScan(); // Trigger the camera
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50), backgroundColor: const Color(0xFF0D47A1), foregroundColor: Colors.white),
              child: Text(isHindi ? "स्कैन शुरू करें" : "Start Scan Now"),
            )
          ],
        ),
      ),
    );
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
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ElevatedButton.icon(
              onPressed: _showScannerOnboarding,
              icon: const Icon(Icons.camera_alt),
              label: Text(isHindi ? "AI स्मार्ट स्कैन शुरू करें" : "Start AI Smart Scan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D47A1),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
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
