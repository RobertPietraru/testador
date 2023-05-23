import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'question_timer_state.dart';

class QuestionTimerCubit extends Cubit<QuestionTimerState> {
  QuestionTimerCubit() : super(QuestionTimerInitial()) {}

  
}
