import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _hidePass = true;
  showHidePass() {
    _hidePass = !_hidePass;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        obscureText: _hidePass,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              showHidePass();
            },
            icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
