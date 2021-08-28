
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Register/Register_event.dart';
import 'package:frontend/Repository/MainRepository.dart';
import 'blocs.dart';
import 'package:frontend/Models/models.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisteringUser) {
      yield Registering();

      try {
        User newuser = await AuthRepository.RegisterUserRepo(event.user);
        print(newuser.tojson());
        var incommingValue = newuser.tojson();
        if (incommingValue['emailAddress'] == '') {
          yield FailedToRegister();
        } else if (incommingValue['emailAddress'] != '') {
          yield Registered(newuser);
        }
      } catch (e) {
        yield FailedToRegister();
      }
    }
  }
}
