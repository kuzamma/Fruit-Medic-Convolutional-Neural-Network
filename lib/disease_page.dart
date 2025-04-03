import 'package:flutter/material.dart';
import 'dart:io';

class DiseasePage extends StatelessWidget {
  final String title;
  final String description;
  final String management;
  final double confidence;
  final File? imagePath;

  const DiseasePage({
    required this.title,
    required this.description,
    required this.management,
    required this.confidence,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoCard("Disease Detected", "$title\nConfidence: ${confidence.toStringAsFixed(2)}%"),
            const SizedBox(height: 20),
            if (imagePath != null)
              _buildImageDisplay(),
            const SizedBox(height: 20),
            _buildInfoCard("About the Disease", description),
            const SizedBox(height: 20),
            _buildInfoCard("Management Tips", management),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 5,
      shape: const Border(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(content, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }

  // New widget for displaying the image with style
  Widget _buildImageDisplay() {
    return Container(
      height: 290, 
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        imagePath!,
        fit: BoxFit.cover,
        width: double.infinity, 
      ),
    );
  }
}
