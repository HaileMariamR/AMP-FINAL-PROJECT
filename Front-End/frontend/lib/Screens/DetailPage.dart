import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/holyplace_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/holyplace_event.dart';
import 'package:frontend/ApplicationState/Bloc/subscription/subscription_bloc.dart';
import 'package:frontend/Models/SubscriptionModel.dart';

class DetailPage extends StatelessWidget {
  DetailPage(
      {Key? key,
      required this.hollyplace,
      required this.userId,
      required this.subscribed})
      : super(key: key);
  final dynamic hollyplace;
  final String userId;
  final bool subscribed;
  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SafeArea(
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${hollyplace['name']}",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontFamily: 'Montserrat',
                            fontSize: 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          simpleText("Location: ", 20),
                          simpleText("${hollyplace['location']}", 20)
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                              (hollyplace['image'] != null)
                                  ? hollyplace['image']
                                  : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROGVlwDhbC-6RixbdgEwDrABJ6BD3hhM2eJA&usqp=CAU",
                              fit: BoxFit.cover, errorBuilder: (context,
                                  Object exception, StackTrace? stackTrace) {
                            return const Text('Sorry Image not found ');
                          }),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          simpleText("History: ", 20),
                          simpleText("${hollyplace['history']}", 20)
                        ],
                      ),
                      subscribed
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                  buttonWidget(
                                    function: () {},
                                    color: Colors.blueAccent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.check),
                                        Text("subscribed"),
                                      ],
                                    ),
                                  ),
                                  buttonWidget(
                                    function: () {
                                      BlocProvider.of<SubscriptionBloc>(context)
                                          .add(
                                        UnSubscribe(
                                          subscriptionModel: SubscriptionModel(
                                              hollyplace['createdby']['_id'],
                                              userId),
                                        ),
                                      );
                                    },
                                    color: Colors.redAccent,
                                    child: Text('unSubscribe'),
                                  ),
                                ])
                          : buttonWidget(
                              function: () {
                                print("Button is pressed");
                                print("rep. ${hollyplace['createdby']['_id']}");
                                print("User. ${userId}");
                                BlocProvider.of<SubscriptionBloc>(context).add(
                                  Subscribe(
                                    subscriptionModel: SubscriptionModel(
                                        hollyplace['createdby']['_id'], userId),
                                  ),
                                );
                              },
                              color: Colors.redAccent,
                              child: Text('Subscribe'),
                            ),
                      BlocConsumer<SubscriptionBloc, SubscriptionState>(
                        listener: (context, state) {
                          if (state is UnSubscribed || state is Subscribed) {
                            BlocProvider.of<HolyPlaceBloc>(context)
                                .add(LoadingHolyPlacesEvent());
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          if(state is SubscriptionInProgress){
                            return SpinKitDualRing(
                              color: Colors.black,
                              size: 50,
                            );
                          }
                          if (state is SubscribeUnsbscribeFaild) {
                            return Expanded(
                              child: Text(state.message,
                                  style: TextStyle(color: Colors.red)),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget simpleText(String label, double fontSize) {
    return Expanded(
      child: Text(
        "$label",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.pinkAccent,
            fontFamily: 'Montserrat',
            fontSize: fontSize),
      ),
    );
  }
}

class buttonWidget extends StatelessWidget {
  const buttonWidget({
    Key? key,
    required this.function,
    required this.color,
    required this.child,
  }) : super(key: key);
  final Function() function;
  final Color color;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: function,
        child: child,
        style: ElevatedButton.styleFrom(primary: color),
      ),
    );
  }
}
