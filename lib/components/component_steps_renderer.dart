import 'package:flutter/material.dart';

class StepsRenderer extends StatelessWidget {
  final int numSteps;
  final int currentStep;

  const StepsRenderer({super.key, required this.numSteps, this.currentStep = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numSteps, (index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: index <= currentStep ? const Color(0xFF323230) : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            index < numSteps-1 ?
            Container(
              width: 150 / numSteps,
              height: 5,
              color: index <= currentStep ? const Color(0xFF323230) : Colors.grey,
            ):const SizedBox(),
          ],
        );
      }),
    );
  }
}
