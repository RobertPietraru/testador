import 'package:flutter/material.dart';

import '../../../../../core/components/theme/app_theme.dart';
import '../../../domain/entities/question_entity.dart';

class SessionOptionWidget extends StatefulWidget {
  final int index;
  final MultipleChoiceOptionEntity option;
  final VoidCallback? onPressed;
  final bool isSelected;
  const SessionOptionWidget({
    super.key,
    required this.index,
    required this.option,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  State<SessionOptionWidget> createState() => _SessionOptionWidgetState();
}

class _SessionOptionWidgetState extends State<SessionOptionWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.option.text != null;
    final theme = AppTheme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      child: InkWell(
        onTap: widget.onPressed,
        child: Ink(
          color:
              isEnabled ? theme.getColor(widget.index) : theme.secondaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.isSelected)
                    const Icon(Icons.done, color: Colors.white)
                ],
              ),
              Center(
                child: Text(
                  widget.option.text ?? "Optiunea ${widget.index + 1}",
                  style: TextStyle(
                      color: isEnabled ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}