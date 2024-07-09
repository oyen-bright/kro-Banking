import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  const CardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Rent"),
      subtitle: const Text("15th May 2021"),
      trailing: const Text("\$30000"),
      leading: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
        ),
        child: const Icon(Icons.arrow_outward),
      ),
    );
  }
}
