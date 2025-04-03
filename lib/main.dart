import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomelo/fungal_disease_page.dart';
import 'package:pomelo/canker_blackspot_page.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF3F6F9),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 6,
            backgroundColor: Colors.deepPurple.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? filePath;
  String label = '';
  double confidence = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeTFLite();
  }

  Future<void> _initializeTFLite() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
       useGpuDelegate: false, 
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;

    setState(() {
      filePath = File(image.path);
    });

    final recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 3,
      threshold: 0.6,
      asynch: true,
    );

    if (recognitions == null || recognitions.isEmpty || !mounted) {
      developer.log("No recognitions or widget is unmounted");
      setState(() {
        _showWarningDialog();
      });
      return;
    }

    setState(() {
      confidence = (recognitions[0]['confidence'] * 100).toDouble();
      label = recognitions[0]['label'].toString();
    });

    if (confidence >= 99.2) {
      _showWarningDialog();
    } else if (confidence < 60) {
      _showWarningDialog();
    } else {
      _navigateBasedOnLabel();
    }
  }

  void _navigateBasedOnLabel() {
    if (label.toLowerCase().contains('fungal diseases')) {
      _navigateTo(FungalPage(confidence: confidence, imagePath: filePath));
    } else {
      _navigateTo(CankerBlackspotPage(confidence: confidence, imagePath: filePath));
    }
  }

  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "NO DISEASE DETECTED",
            style: TextStyle(
              color: Color.fromARGB(255, 246, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: const Text(
            "Please ensure the picture is clear or try again.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pomelo Disease Identifier"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
        elevation: 5,
        toolbarHeight: 50,  //  height app bar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            const HeaderWidget(title: "Pomelo Disease Identifier"),
            const SizedBox(height: 40),
            _customSection(
              title: "About this App",
              content:
                  "This app identifies diseases in Pomelo plants using machine learning models. Simply upload a picture of the plant to detect possible diseases.",
            ),
            const SizedBox(height: 30),
            const Text(
              "Classify Disease",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icons.camera_alt,
                  label: "Take Photo",
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icons.image,
                  label: "Gallery",
                ),
              ],
            ),
            const SizedBox(height: 40),
            _customSection(
              title: "Features",
              content:
                  "• Easy-to-use interface\n• Fast detection of Pomelo diseases\n• Works with both camera and gallery images",
            ),
          ],
        ),
      ),
    );
  }

  Widget _customSection({required String title, required String content}) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.deepPurple.shade700,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 50),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple.shade800,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
