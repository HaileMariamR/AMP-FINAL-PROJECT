import 'package:equatable/equatable.dart';
import 'package:frontend/Models/Schedule.dart';

class ScheduleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingSchedules extends ScheduleState {}

class OnScheduleLoadSuccess extends ScheduleState {
  List<dynamic> allschedules;

  OnScheduleLoadSuccess(this.allschedules);

  @override
  List<Object?> get props => [allschedules];
}

class FaildLoadingSchedules extends ScheduleState {}

class AddingSchedule extends ScheduleState {}

class onAddingScheduleSucess extends ScheduleState {
  String responsemessage;
  onAddingScheduleSucess(this.responsemessage);

  @override
  List<Object?> get props => [responsemessage];
}

class FailedtoAddSchedule extends ScheduleState {}
