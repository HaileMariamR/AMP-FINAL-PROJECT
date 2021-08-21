import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassword = TextEditingController();
  String roleDropDownValue = 'User';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Register"),
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            hinttext: "Email Address",
            textEditingController: emailController,
            icondata: Icon(Icons.email),
          ),
          CustomTextField(
            hinttext: "Password",
            textEditingController: passwordController,
            icondata: Icon(Icons.password),
          ),
          CustomTextField(
            hinttext: "Confirm Password",
            textEditingController: controller2,
            icondata: Icon(Icons.password),
          ),
          Container(
              margin: EdgeInsets.only(right: 100),
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 50),
                    child: Text("Role"),
                  ),
                ),
                DropdownButton<String>(
                  value: roleDropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 24,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? newValue) {
                    setState(() {
                      roleDropDownValue = newValue!;
                    });
                  },
                  items: <String>['User', 'Representative']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ])),
          Hero(
              tag: "Registertag",
              child: CustomRoundButton(
                onPressedfun: () async {
                  User newuser = User(
                    emailController.text.toString(),
                    controller2.text.toString(),
                    userName: " Eharry ",
                    fullName: "Hailemariam Fikadie",
                    id: "tempoid",
                    userRole: roleDropDownValue,
                    confirmPassword: confirmPassword.text.toString(),
                  );

                  RegisterEvent registerEvent = RegisteringUser(newuser);
                  BlocProvider.of<RegisterBloc>(context).add(registerEvent);
                },
                backroundcolor: Colors.blue,
                displaytext: Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                ),
              )),
          BlocBuilder<RegisterBloc, RegisterState>(builder: (_, state) {
            if (state is Registering) {
              return SpinKitDualRing(
                color: Colors.black,
                size: 50,
              );
            }
            if (state is Registered) {
              return Text(
                  "Signup Sucess! go back and login");
            }
            if (state is FailedToRegister) {
              return Text("Failed!");
            }
            return Text("");
          }),
        ],
      ),
    );
  }
}
