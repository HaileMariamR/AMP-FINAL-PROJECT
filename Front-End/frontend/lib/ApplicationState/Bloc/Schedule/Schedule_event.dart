import 'package:equatable/equatable.dart';
import 'package:frontend/Models/Schedule.dart';

class ScheduleEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingScheduleEvent extends ScheduleEvent {}

class AddingScheduleEvent extends ScheduleEvent {
  final  Schedule schedule;
  AddingScheduleEvent(this.schedule);
  
  @override
  List<Object?> get props => [];
}
