import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Repository/SchedulesRepository.dart';
import 'blocs.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleState());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    //LoadingScheduleEvent
    if (event is GetInitialState) {
      yield SchedulesIntialState();
    }
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
      dynamic responsemessage;
      yield AddingSchedule();
      try {
        var responsemessage =
            await SchedulesRepository.createSchedule(event.schedule);
        if (responsemessage.containsKey("Errormessage")) {
          yield FailedtoAddSchedule(responsemessage['Errormessage']);
        } else if (responsemessage.containsKey("message")) {
          print("responseMessage$responsemessage");
          yield onAddingScheduleSucess(responsemessage.toString());
        } else {
          yield FailedtoAddSchedule(responsemessage);
        }
      } catch (e) {
        print(e.toString());
        // yield FailedtoAddSchedule(e.toString());
      }
    }
  }
}
