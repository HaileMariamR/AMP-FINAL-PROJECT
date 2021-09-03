import 'package:flutter/material.dart';
import 'package:frontend/Widgets/CustomTextField.dart';
import 'package:frontend/Widgets/Button.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:frontend/Models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';

class AddSchedule extends StatelessWidget {
  AddSchedule({Key? key}) : super(key: key);

  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userid = "";
    String reponseMessage = "";
    LoginState userstate = BlocProvider.of<LoginBloc>(context).state;
    if (userstate is Logedin) {
      userid = userstate.loggedinUserinfo.id.toString();
    }

    ScheduleState responsestate = BlocProvider.of<ScheduleBloc>(context).state;
    if (responsestate is onAddingScheduleSucess) {
      reponseMessage = responsestate.responsemessage.toString();
    }
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Text("Schedule Form"),
            ),
            Expanded(
                child: CustomTextField(
              textEditingController: controller2,
              hinttext: "Enter first Schedule",
              icondata: Icon(Icons.schedule),
            )),
            Expanded(
                child: CustomTextField(
              textEditingController: controller3,
              hinttext: "Enter second Schedule",
              icondata: Icon(Icons.schedule),
            )),
            Expanded(
                child: CustomTextField(
              textEditingController: controller4,
              hinttext: "Enter third Schedule",
              icondata: Icon(Icons.schedule),
            )),
            Expanded(
                child: CustomTextField(
              textEditingController: controller5,
              hinttext: "Enter fourth Schedule",
              icondata: Icon(Icons.schedule),
            )),
            Expanded(
                child: CustomRoundButton(
              backroundcolor: Colors.blue,
              displaytext: Text("Add Schedule"),
              onPressedfun: () {
                Schedule schedule = Schedule("", []);
                schedule.createdby = userid;
                schedule.allprograms = [
                  controller2.text.toString(),
                  controller3.text.toString(),
                  controller4.text.toString(),
                  controller5.text.toString(),
                ];

                BlocProvider.of<ScheduleBloc>(context)
                    .add(AddingScheduleEvent(schedule));

                Navigator.pop(context);

                final mysnackbar = SnackBar(content: Text("$reponseMessage"));
                ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
              },
            )),
          ],
        ));
  }
}