import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart'; // Logic for Gov App Bridge
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'links_data.dart'; // Your directory of links

void main() {
  runApp(const BestVerifierApp());
}

class BestVerifierApp extends StatelessWidget {
  const BestVerifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Verifier',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF0D47A1),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // LAYER 1: Show the Startup Legal Disclaimer immediately
    WidgetsBinding.instance.addPostFrameCallback((_) => _showInitialDisclaimer());
  }

  // --- POPUP 1: THE STARTUP GATEKEEPER ---
  void _showInitialDisclaimer() {
    showDialog(
      context: context,
      barrierDismissible: false, // User MUST agree to enter
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.gavel, color: Color(0xFF0D47A1)),
            SizedBox(width: 10),
            Text("Legal Disclosure"),
          ],
        ),
        content: const Text(
          "Best Verifier is a private utility tool and is NOT affiliated with the Government of India.\n\n"
          "By proceeding, you agree that you are using these public links for lawful purposes and have obtained necessary consent for any third-party verification.",
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)),
            child: const Text("I UNDERSTAND & AGREE", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // --- POPUP 2: TRANSPARENCY NOTIFICATION FOR GOV APPS ---
  Future<void> _handleAppLaunch(String packageName, String toolName) async {
    bool? proceed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("$toolName Required"),
        content: Text(
          "To ensure 100% security and verify digital signatures, this feature requires you to use the official government app.\n\n"
          "We will now check if it's on your device. If missing, we'll guide you to the official Play Store page.",
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("CANCEL")),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)),
            child: const Text("PROCEED", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (proceed == true) {
      // Launch official app or redirect to store
      await LaunchApp.openApp(
        androidPackageName: packageName,
        openStore: true, 
      );
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Best Verifier', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: const Color(0xFF0D47A1),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Color(0xFFFF9933),
            tabs: [
              Tab(icon: Icon(Icons.travel_explore), text: "VERIFY OTHERS"),
              Tab(icon: Icon(Icons.folder_shared), text: "MY DOCUMENTS"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CategoryGrid(mode: 'verify'),
            CategoryGrid(mode: 'personal'),
          ],
        ),
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final String mode;
  const CategoryGrid({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (mode == 'verify') 
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber)),
            child: const Text("PRIVATE TOOL: Not affiliated with Govt. All links open official portals.", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: gridCategories.entries.map((e) => _buildCard(context, e.value)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> cat) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _showTools(context, cat),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder, size: 40, color: Color(cat['color'])),
            const SizedBox(height: 10),
            Text(cat['title'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void _showTools(BuildContext context, Map<String, dynamic> cat) {
    final List tools = cat[mode];
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: tools.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(tools[i]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(tools[i]['desc']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pop(context);
              if (tools[i]['isApp'] == true) {
                // Call the transparency notification logic
                (context.findAncestorStateOfType<_HomePageState>())?._handleAppLaunch(tools[i]['url'], tools[i]['name']);
              } else {
                (context.findAncestorStateOfType<_HomePageState>())?._launchURL(tools[i]['url']);
              }
            },
          ),
        ),
      ),
    );
  }
}
