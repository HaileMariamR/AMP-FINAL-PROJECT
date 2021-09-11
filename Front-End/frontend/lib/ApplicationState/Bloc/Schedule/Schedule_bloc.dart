import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/SchedulesRepository.dart';
import 'blocs.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleState());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    //LoadingScheduleEvent

    if (event is LoadingScheduleEvent) {
      yield LoadingSchedules();
      try {
        dynamic incommingvalue = await SchedulesRepository.allScheduleRepo();
        print(incommingvalue);

        yield OnScheduleLoadSuccess(incommingvalue);
      } catch (e) {
        FaildLoadingSchedules();
        ;
      }
    }

    //AddingScheduleEvent

    if (event is AddingScheduleEvent) {
      yield AddingSchedule();
      try {
        var responsemessage =
            await SchedulesRepository.createSchedule(event.schedule);
        print(responsemessage.toString());

        yield onAddingScheduleSucess(responsemessage);
      } catch (e) {
        yield FailedtoAddSchedule();
      }
    }
  }
}
