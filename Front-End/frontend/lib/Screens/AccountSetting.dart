import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/Models/models.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentLoggedInState = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          "Account Setting",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: BlocBuilder(
            bloc: currentLoggedInState,
            builder: (BuildContext context, state) {
              print("rebuild");
              if (state is Logedin) {
                return Column(
                  children: [
                    Container(
                      child: Text(
                          "fullName : ${state.loggedinUserinfo.tojson()['fullName']}"),
                    ),
                    Container(
                      child: Text(
                          "userName : ${state.loggedinUserinfo.tojson()['userName']}"),
                    ),
                    Container(
                      child: Text(
                          "emailAddress : ${state.loggedinUserinfo.tojson()['emailAddress']}"),
                    ),
                    Container(
                      child: Text(
                          "password : ${state.loggedinUserinfo.tojson()['password']}"),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text("Delete Account"),
                        onPressed: () {
                          User user =
                              User(state.loggedinUserinfo.emailAddress, "");
                          BlocProvider.of<LoginBloc>(context)
                              .add(DeleteUserEvent(user, state.access_token));
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: Text("Update Account"),
                        onPressed: () {
                          print("update event added!");

                          User user =
                              User(state.loggedinUserinfo.emailAddress, "");
                        },
                      ),
                    ),
                  ],
                );
              }
              return Text("");
            }),
      ),
    );
  }
}
