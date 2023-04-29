import 'package:flutter/material.dart';
import 'package:testador/core/components/theme/app_theme.dart';

class TextInputField extends StatefulWidget {
  final Function(String) onChanged;
  final String hint;
  final String? error;
  final IconData? leading;
  final bool isPassword;
  const TextInputField({
    Key? key,
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
  final TextEditingController controller = TextEditingController();
  bool isObscured = false;
  @override
  void initState() {
    isObscured = widget.isPassword;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    //#3a3a3a
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.hint,
          style: theme.informationTextStyle.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 5),
        TextFormField(
            obscureText: isObscured,
            style: TextStyle(color: theme.primaryColor),
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 212, 212, 212),
              filled: true,
              hintText: widget.hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              prefixIcon: widget.leading == null ? null : Icon(widget.leading),
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
            controller: controller,
            onChanged: widget.onChanged),
      ],
    );
  }
}
