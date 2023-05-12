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
  @override
  void initState() {
    final test = context.read<TestEditorCubit>().state.test;
    title = test.title ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return WillPopScope(
      onWillPop: () async {
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
                            image: state.test.imageUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(state.test.imageUrl!))
                                : null,
                          ),
                          child: state.test.imageUrl == null
                              ? Center(
                                  child: Text("Adauga imagine",
                                      textAlign: TextAlign.center,
                                      style: theme.subtitleTextStyle
                                          .copyWith(color: Colors.white)))
                              : null))
                ]),
                TextInputField(
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
                      state.test.isPublic ? Icons.public : Icons.public_off,
                      color: state.test.isPublic ? theme.good : theme.bad),
                  onTap: () {
                    context.read<TestEditorCubit>().togglePublicity();
                  },
                  title: Text(
                    state.test.isPublic ? "Public" : "Privat",
                    style: theme.subtitleTextStyle.copyWith(
                        color: state.test.isPublic ? theme.good : theme.bad),
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
