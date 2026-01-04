import 'package:flutter/material.dart';

class IngredientAccordion extends StatelessWidget {
  final Map item;

  const IngredientAccordion({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isAlami = item["category"] == "alami";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,

        leading: CircleAvatar(
          radius: 7,
          backgroundColor: isAlami ? Colors.green : Colors.red,
        ),

        title: Text(
          item["ingredient"] ?? "-",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
        ),

        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kegunaan: ${item["informasi_kegunaan"] ?? "-"}"),
                  const SizedBox(height: 6),
                  Text("Batas Wajar: ${item["batas_wajar"] ?? "-"}"),
                  const SizedBox(height: 6),
                  Text("Dampak: ${item["dampak_negatif"] ?? "-"}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}