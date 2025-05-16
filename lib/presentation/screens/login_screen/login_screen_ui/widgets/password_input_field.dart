import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;
  final ValueChanged<String>? onChanged;

  const PasswordInputField({
    required this.obscurePassword,
    required this.onToggleVisibility,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscurePassword,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            hintText: 'Enter your password',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
