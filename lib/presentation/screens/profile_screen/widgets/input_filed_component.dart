import 'package:flutter/material.dart';

class InputFiledComponent extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool readOnly;
  final Function? onTap;
  final TextEditingController controller;
  final String hintText;
  final String? trailingText;
  final VoidCallback? onTrailingTap;

  const InputFiledComponent({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    required this.controller,
    required this.hintText,
    this.trailingText,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff008B8B),
              ),
            ),
            if (trailingText != null)
              GestureDetector(
                onTap: onTrailingTap,
                child: Text(
                  trailingText!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: const Color(0xff008B8B).withOpacity(0.6),
                width: 1.2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
