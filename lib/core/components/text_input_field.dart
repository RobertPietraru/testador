import 'package:flutter/material.dart';
import 'package:testador/core/components/theme/app_theme.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hint;
  final String? error;
  final IconData? leading;
  final bool isPassword;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.hint,
    this.error,
    this.leading,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool isObscured = false;
  @override
  void initState() {
    isObscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return TextFormField(
        obscureText: isObscured,
        decoration: InputDecoration(
          prefixIcon: widget.leading == null
              ? null
              : Icon(
                  widget.leading,
                  color: Colors.white,
                ),
          label: Text(
            widget.hint,
            style: TextStyle(fontSize: theme.spacing.large),
          ),
          errorStyle: TextStyle(fontSize: theme.spacing.mediumLarge),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => isObscured = !isObscured),
                )
              : null,
          errorText: widget.error,
        ),
        controller: widget.controller,
        onChanged: widget.onChanged);
  }
}
