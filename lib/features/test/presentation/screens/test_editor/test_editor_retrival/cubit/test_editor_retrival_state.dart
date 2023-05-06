part of 'test_editor_retrival_cubit.dart';

abstract class TestEditorRetrivalState extends Equatable {
  const TestEditorRetrivalState();

  @override
  List<Object> get props => [];
}

class TestEditorRetrivalLoading extends TestEditorRetrivalState {}

class TestEditorRetrivalFailed extends TestEditorRetrivalState {}

class TestEditorRetrivalSuccessful extends TestEditorRetrivalState {
  final TestEntity entity;

  const TestEditorRetrivalSuccessful({required this.entity});
  @override
  List<Object> get props => [entity];
}
