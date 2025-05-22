import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingControllerValue;

  const InputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textEditingControllerValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: textEditingControllerValue,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16, // Ensures left padding for both hint and input text
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xff008B8B)),
            ),
          ),
        ),
      ],
    );
  }
}
