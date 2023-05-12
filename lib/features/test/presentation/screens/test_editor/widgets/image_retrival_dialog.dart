import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testador/core/components/custom_dialog.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';

class ImageRetrivalDialog extends StatefulWidget {
  const ImageRetrivalDialog({super.key});

  @override
  State<ImageRetrivalDialog> createState() => _ImageRetrivalDialogState();
}

class _ImageRetrivalDialogState extends State<ImageRetrivalDialog> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final cubit = context.read<TestEditorCubit>();
    return CustomDialog(
      child: Padding(
        padding: theme.standardPadding.copyWith(top: 0, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                final file = await picker.pickImage(source: ImageSource.camera);
                if (file == null) return;
                cubit.updateQuestionImage(image: File(file.path));
              },
              child: Ink(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.camera_alt),
                    Text("Camera"),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                final file =
                    await picker.pickImage(source: ImageSource.gallery);
                if (file == null) return;
                cubit.updateQuestionImage(image: File(file.path));
              },
              child: Ink(
                child: Column(mainAxisSize: MainAxisSize.min, children: const [
                  Icon(Icons.photo),
                  Text("Galerie"),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
