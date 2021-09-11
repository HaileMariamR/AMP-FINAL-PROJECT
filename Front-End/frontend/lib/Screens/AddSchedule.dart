import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:frontend/Models/Schedule.dart';
import 'package:frontend/Widgets/Button.dart';
import 'package:frontend/Widgets/CustomTextField.dart';

class AddSchedule extends StatelessWidget {
  AddSchedule({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final programOneController = TextEditingController();
  final programTwoController = TextEditingController();
  final ProgramThreeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String userId = '';
    LoginState userState = BlocProvider.of<LoginBloc>(context).state;
    if (userState is Logedin) {
      userId = userState.loggedinUserinfo.id!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Schedule",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Card(
            elevation: 10,
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Schedule",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.pinkAccent,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 100,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextField(
                        labelText: "title",
                        textEditingController: titleController,
                        icondata: Icon(Icons.title),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "provide consie title";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "description",
                        textEditingController: descriptionController,
                        icondata: Icon(Icons.description),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "provide description";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program one,specify time",
                        textEditingController: programOneController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program two,specify time",
                        textEditingController: programTwoController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        labelText: "program three,specify time",
                        textEditingController: ProgramThreeController,
                        icondata: Icon(Icons.schedule),
                        isValid: (value) {
                          if (value!.isEmpty) {
                            return "this field is required";
                          }
                          return null;
                        },
                      ),
                      CustomRoundButton(
                          backroundcolor: Colors.blue,
                          displaytext: Text("Add Schdule"),
                          onPressedfun: () {
                            var form = _formKey.currentState;
                            if (form!.validate()) {
                              var schedule = Schedule(
                                  userId,
                                  [
                                    programOneController.text,
                                    programTwoController.text,
                                    ProgramThreeController.text
                                  ],
                                  title: titleController.text,
                                  description: descriptionController.text);
                              BlocProvider.of<ScheduleBloc>(context)
                                  .add(AddingScheduleEvent(schedule));
                            }
                          }),
                    ],
                  ),
                ),
                BlocConsumer<ScheduleBloc, ScheduleState>(
                  listener: (context, state) {
                    if (state is onAddingScheduleSucess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          
                          content: Text("Schedule added Successfully"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (_, state) {
                    if (state is AddingSchedule) {
                      return SpinKitDualRing(
                        color: Colors.black,
                        size: 50,
                      );
                    }
                    if (state is FailedtoAddSchedule) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Text(state.message),
                          InkWell(
                            onTap: ()=>BlocProvider.of<ScheduleBloc>(context).add(GetInitialState()),
                            child: Text(" Try again",style: TextStyle(color: Colors.blue),))
                                                  ,InkWell(
                            onTap: ()=>Navigator.pop(context),
                            child: Text(" back",style: TextStyle(color: Colors.pinkAccent),))

                        ],
                      );                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
