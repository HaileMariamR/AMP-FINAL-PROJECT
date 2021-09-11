import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Models/models.dart';
import 'package:frontend/Repository/HolyplaceRepository.dart';
import 'blocs.dart';

class HolyPlaceBloc extends Bloc<HolyPlaceEvent, HolyPlaceState> {
  HolyPlaceBloc() : super(HolyPlaceState());

  @override
  Stream<HolyPlaceState> mapEventToState(HolyPlaceEvent event) async* {
    //LoadingHolyplace

    if (event is LoadingHolyPlacesEvent) {
      yield LoadingHolyPlaces();
      try {
        dynamic incommingvalue = await HolyPlaceRepository.getAllHolyplaces();
        print(incommingvalue);

        yield OnHolyPlaceLoadSuccess(incommingvalue);
      } catch (e) {
        FaildtoLoadingHolyPlaces();
        ;
      }
    }
    if (event is createHolyplaceEvent) {
      try {
        dynamic message =
            await HolyPlaceRepository.createHolyPlace(event.holyplaceModel);

        print(message.toString());
        yield onCreateHolyPlaceSucess(message);
      } catch (e) {
        yield FaildtoCreateHolyplace();
      }
    }
  }
}
