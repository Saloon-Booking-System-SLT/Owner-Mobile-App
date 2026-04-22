import 'package:flutter/material.dart';

class OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OtpInputFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 60,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.length == 1 && index < 3) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
            },
          ),
        ),
      ),
    );
  }
}