import 'package:equatable/equatable.dart';
import 'package:frontend/Models/User.dart';


class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}
class RegisterIntial extends RegisterState{}
class Registering extends RegisterState {}

class FailedToRegister extends RegisterState {}

class Registered extends RegisterState {

  final User registeredUser;
  Registered(this.registeredUser);
  @override
  List<Object?> get props => [registeredUser];
  
}
