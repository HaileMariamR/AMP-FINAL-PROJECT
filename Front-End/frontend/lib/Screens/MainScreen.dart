import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/holyplace_bloc.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Schedule/blocs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var currentLoginState = BlocProvider.of<LoginBloc>(context);
    var holyplacesstate = BlocProvider.of<HolyPlaceBloc>(context);

    return Scaffold(
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 130, left: 20),
                    child: Text(
                      "AMP final project",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 20),
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Account Settings"),
              onTap: () {
                Navigator.pushNamed(context, '/accountsettings');
              },
            ),
          ],
        )),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white12,
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text("Search",
              style: TextStyle(
                color: Colors.black,
              )),
          actions: [
            Container(
              child: GestureDetector(
                child: Icon(
                  Icons.notification_add,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/allscubscription');
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        currentLoginState.add(LogoutEvent());
                        Navigator.pushNamed(context, '/');
                        break;
                      case 2:
                        Navigator.pushNamed(context, "/accountsettings");
                        break;
                      case 3:
                        Navigator.pushNamed(context, "/allscubscription");
                        break;
                    }
                  },
                  offset: Offset(5, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Color(0xff757575),
                  elevation: 10,
                  icon: Icon(
                    Icons.circle,
                    size: 40,
                    color: Colors.blueGrey,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          value: 1,
                          child: Text(
                            "logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          "my Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      PopupMenuItem(
                          value: 3,
                          child: Text(
                            "All Subscription ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ))
                    ];
                  }),
            )
          ],
        ),
        body: Container(
          child: BlocBuilder(
            bloc: holyplacesstate,
            builder: (BuildContext context, HolyPlaceState state) {
              if (state is LoadingSchedules) {
                return SpinKitDualRing(
                  color: Colors.black,
                  size: 50,
                );
              }

              if (state is OnHolyPlaceLoadSuccess) {
                // return Text("${state.allschedules.toString()}");
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: state.allholyplaces.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Text(
                                  "${state.allholyplaces[index]['name'].toString()}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Image.network(
                                    (state.allholyplaces[index]['image'] !=
                                            null)
                                        ? state.allholyplaces[index]['image']
                                        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROGVlwDhbC-6RixbdgEwDrABJ6BD3hhM2eJA&usqp=CAU",
                                    errorBuilder: (context, Object exception,
                                        StackTrace? stackTrace) {
                                  return const Text('Sorry Image not found ');
                                }),
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/detailpage');
                                },
                                child: Text(
                                  "more ...",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )),
                              Expanded(
                                child: Container(
                                  child: ElevatedButton(
                                    child: Text("Subscribe"),
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                  ),
                                ),

                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return Text("noting found!");
            },
          ),
        ));
  }
}
