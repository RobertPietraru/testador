import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testador/features/test/domain/entities/question_entity.dart';
import 'package:testador/features/test/domain/entities/test_entity.dart';
import 'package:testador/features/test/domain/failures/test_failures.dart';

part 'test_editor_state.dart';

class TestEditorCubit extends Cubit<TestEditorState> {
  TestEditorCubit(super.initialState);
}
