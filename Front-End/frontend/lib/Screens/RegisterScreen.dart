import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Register/blocs.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:frontend/Models/models.dart';

class RegisterController extends StatelessWidget {
  const RegisterController({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => RegisterBloc(),
      child: Register(),
    );
  }
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();
  final fullNameCont = TextEditingController();
  final userNameCont = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String roleDropDownValue = 'User';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Register"),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white),
      body: Center(
        child: Stack(
          children: [
            Image.asset("assets/images/background.jpg",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover),
            ListView(
              shrinkWrap: false,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 40, 0, 0),
                      child: Text(
                        '.',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        isValid: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return "Email is nott correct";
                          }
                          return null;
                        },
                        labelText: "Email Address",
                        textEditingController: emailController,
                        icondata: Icon(Icons.email),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Fullname is required";
                          }
                          return null;
                        },
                        labelText: "Full Name",
                        textEditingController: fullNameCont,
                        icondata: Icon(Icons.person),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        labelText: "User Name",
                        textEditingController: userNameCont,
                        icondata: Icon(Icons.person_outline),
                      ),
                      CustomTextField(
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          if (value.length < 6) {
                            return "too short password";
                          }
                          return null;
                        },
                        labelText: "Password",
                        textEditingController: passwordController,
                        icondata: Icon(Icons.password),
                      ),
                      CustomTextField(
                        labelText: "Confirm Password",
                        textEditingController: confirmPassword,
                        icondata: Icon(Icons.password),
                        isValid: (value) {
                          if (value!.isEmpty ||
                              (passwordController.text !=
                                  confirmPassword.text)) {
                            return "Passwords doesn't match";
                          }
                          return null;
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 100),
                          child: Row(children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 50),
                                child: Text(
                                  "Role",
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: roleDropDownValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              style: const TextStyle(color: Colors.pinkAccent),
                              onChanged: (String? newValue) {
                                setState(() {
                                  roleDropDownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'User',
                                'Representative'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ])),
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (_, state) {
                          if (state is Registered) {
                            emailController.text = "";
                            fullNameCont.text = "";
                            userNameCont.text = "";
                            passwordController.text = "";
                            confirmPassword.text = "";
                          }
                        },
                        builder: (_, state) {
                          if (state is Registering) {
                            return SpinKitDualRing(
                              color: Colors.black,
                              size: 50,
                            );
                          }
                          if (state is Registered) {
                            return Text("Signup Sucess! go back and login");
                          }
                          if (state is FailedToRegister) {
                            return Text(
                              "Failed!",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 25),
                            );
                          }
                          return Hero(
                            tag: "Registertag",
                            child: CustomRoundButton(
                              onPressedfun: () async {
                                var form = _formKey.currentState;
                                if (form!.validate()) {
                                  User newuser = User(
                                    emailController.text,
                                    passwordController.text,
                                    userName: userNameCont.text,
                                    fullName: fullNameCont.text,
                                    userRole: roleDropDownValue,
                                    id: "tempid",
                                    confirmPassword: confirmPassword.text,
                                  );

                                  RegisterEvent registerEvent =
                                      RegisteringUser(newuser);
                                  BlocProvider.of<RegisterBloc>(context)
                                      .add(registerEvent);
                                }
                              },
                              backroundcolor: Colors.blue,
                              displaytext: Text(
                                "Register",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
