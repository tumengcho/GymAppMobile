import 'package:flutter/material.dart';

import '../utils/activity_enum.dart';

class CalculateCalorieForm extends StatefulWidget {
  final void Function(double poids, double taille, double age, double activityFactor) onCalculate;

  const CalculateCalorieForm({super.key, required this.onCalculate});

  @override
  State<CalculateCalorieForm> createState() => _CalculateCalorieFormState();
}

class _CalculateCalorieFormState extends State<CalculateCalorieForm> {
  TextEditingController poids = TextEditingController();
  TextEditingController taille = TextEditingController();
  TextEditingController age = TextEditingController();

  ActivityLevel? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      decoration: BoxDecoration(
          color: Color(0xFF323230), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: poids,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Poids',
              hintText: '86',
              helperText: "Entrez votre poids",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.monitor_weight_outlined),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: taille,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Taille',
              hintText: '1.83',
              helperText: "Entrez votre taille",
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.horizontal_rule_rounded),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: age,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Âge',
              hintText: '25',
              helperText: 'Entrez votre âge',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.supervised_user_circle_outlined),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<ActivityLevel>(
            style: const TextStyle(color: Colors.white),
            dropdownColor: Colors.black,
            decoration: const InputDecoration(
              labelText: "Niveau d'activité",
              border: OutlineInputBorder(),
            ),
            hint: const Text("Sélectionnez un niveau d'activité", style: TextStyle(color: Colors.grey)),
            value: selectedLevel,
            isExpanded: true,
            items: ActivityLevel.values.map((level) {
              return DropdownMenuItem<ActivityLevel>(
                value: level,
                child: Text(level.description, style: TextStyle(color: Colors.white),),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedLevel = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color(0xFFD3FF55)),
            ),
            onPressed: () => {
              widget.onCalculate(
                  double.tryParse(poids.text) ?? 0,
                  double.tryParse(taille.text) ?? 0,
                  double.tryParse(age.text) ?? 0,
                  selectedLevel!.multiplier
              ),
            },
            child: const Text(
              'Calculer',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
