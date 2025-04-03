
import 'package:flutter/material.dart';
import 'dart:io';
import 'disease_page.dart';

class FungalPage extends StatelessWidget {
  final double confidence;
  final File? imagePath;

  const FungalPage({required this.confidence, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return DiseasePage(
      title: "Fungal Disease",
      description: "Fungal infections in pomelo are common and can cause various issues such as fruit rot, defoliation, and reduced plant vigor. These infections typically occur in warm, humid conditions and can spread rapidly if not controlled. Symptoms may include discolored spots on the leaves and fruits, often with a fuzzy or powdery texture on the surface.",
      management: "To manage fungal diseases in pomelo, regular fungicide applications are essential, especially during the rainy season. Ensure proper spacing between plants to promote good air circulation and reduce humidity. Remove and dispose of infected plant material to prevent the spread of the disease. Additionally, avoid over-watering and water the plants at the base to keep the leaves dry.",
      confidence: confidence,
      imagePath: imagePath,
    );
  }
}
