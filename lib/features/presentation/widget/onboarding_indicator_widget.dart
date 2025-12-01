import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final bool isCurrent;

  const StepIndicator({
    super.key,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // The indicator is a rounded rectangle or a circle
      width: isCurrent ? 30.0 : 8.0, // Wider if it is the current step (dynamic width)
      height: 8.0, 
      margin: const EdgeInsets.symmetric(horizontal: 4.0), // Spacing between indicators
      decoration: BoxDecoration(
        // Color changes based on the state
        color: isCurrent ? Colors.lightGreen : Colors.grey.shade300,
        // Shape is either a full circle or a rounded rectangle
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}




class ProgressStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep; // This is the dynamic value

  const ProgressStepper({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  }) : assert(currentStep >= 0 && currentStep < totalSteps); // Safety check

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        // Compare the current index with the dynamic currentStep value
        return StepIndicator(
          isCurrent: index == currentStep,
        );
      }),
    );
  }
}