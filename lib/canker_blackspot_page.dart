import 'package:flutter/material.dart';
import 'dart:io';
import 'disease_page.dart';

class CankerBlackspotPage extends StatelessWidget {
  final double confidence;
  final File? imagePath;

  const CankerBlackspotPage({required this.confidence, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return DiseasePage(
      title: "Canker or Blackspot",
      description: "Canker or Blackspot is a fungal disease that primarily affects the fruit and occasionally the leaves of pomelo plants. It is characterized by the presence of dark, sunken lesions on the fruit and can reduce the quality and yield of the crop.",
      management: "To manage Canker or Blackspot, ensure proper pruning of infected plant parts. Use fungicides to control the spread of the disease, and avoid over-watering, which can create favorable conditions for fungal growth. It's important to regularly inspect your plants for signs of infection and remove any affected fruit or leaves promptly.",
      confidence: confidence,
      imagePath: imagePath,
    );
  }
}
