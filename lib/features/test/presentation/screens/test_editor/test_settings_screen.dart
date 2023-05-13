import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/core/components/app_app_bar.dart';
import 'package:testador/core/components/text_input_field.dart';
import 'package:testador/core/components/theme/app_theme.dart';
import 'package:testador/features/test/presentation/screens/test_editor/cubit/test_editor_cubit.dart';
import 'package:testador/features/test/presentation/screens/test_editor/widgets/image_retrival_dialog.dart';

class TestSettingsScreen extends StatefulWidget {
  const TestSettingsScreen({
    super.key,
  });

  @override
  State<TestSettingsScreen> createState() => _TestSettingsScreenState();
}

class _TestSettingsScreenState extends State<TestSettingsScreen> {
  late String title;
  late String initialTitle;
  @override
  void initState() {
    final test = context.read<TestEditorCubit>().state.draft;
    title = test.title ?? '';
    initialTitle = title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (initialTitle == title) {
          return true;
        }
        if (title.isEmpty) {
          return true;
        }

        context.read<TestEditorCubit>().updateTestTitle(title);

        return true;
      },
      child: Scaffold(
        appBar: const CustomAppBar(trailing: []),
        body: BlocBuilder<TestEditorCubit, TestEditorState>(
          builder: (context, state) {
            return Padding(
              padding: theme.standardPadding,
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                              value: context.read<TestEditorCubit>(),
                              child: ImageRetrivalDialog(
                                  onImageRetrived: (imageFile) {
                                context
                                    .read<TestEditorCubit>()
                                    .updateTestImage(newImage: imageFile);
                              }))),
                      child: Ink(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme.secondaryColor,
                            image: state.draft.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(state.draft.imageUrl!))
                                : null,
                          ),
                          child: state.draft.imageUrl == null
                              ? Center(
                                  child: Text("Adauga imagine",
                                      textAlign: TextAlign.center,
                                      style: theme.subtitleTextStyle
                                          .copyWith(color: Colors.white)))
                              : null))
                ]),
                TextInputField(
                    initialValue: title,
                    onChanged: (e) {
                      title = e;
                    },
                    hint: 'Titlu'),
                SizedBox(height: theme.spacing.small),
                TextInputField(
                  onChanged: (e) {},
                  hint: 'Descriere',
                  maxLines: 5,
                ),
                ListTile(
                  leading: Icon(
                      state.draft.isPublic ? Icons.public : Icons.public_off,
                      color: state.draft.isPublic ? theme.good : theme.bad),
                  onTap: () {
                    context.read<TestEditorCubit>().togglePublicity();
                  },
                  title: Text(
                    state.draft.isPublic ? "Public" : "Privat",
                    style: theme.subtitleTextStyle.copyWith(
                        color: state.draft.isPublic ? theme.good : theme.bad),
                  ),
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
