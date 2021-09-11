import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/Widgets/widgets.dart';
import 'package:frontend/ApplicationState/Bloc/Holyplace/blocs.dart';
import 'package:frontend/ApplicationState/Bloc/Login/blocs.dart';
import 'package:frontend/Models/HolyplaceModel.dart';

class HolyPlace extends StatelessWidget {
  HolyPlace({Key? key}) : super(key: key);

  var hollyPlaceController = TextEditingController();
  var locationController = TextEditingController();
  var historyController = TextEditingController();
  var imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String userid = "";
    String responseMessage = "";

    HolyPlaceState responsestate =
        BlocProvider.of<HolyPlaceBloc>(context).state;

    if (responsestate is onCreateHolyPlaceSucess) {
      responseMessage = responsestate.responsemessage.toString();
    }

    LoginState userstate = BlocProvider.of<LoginBloc>(context).state;
    if (userstate is Logedin) {
      userid = userstate.loggedinUserinfo.id.toString();
    }
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: Text("Holyplace Form"),
            ),
            Expanded(
                child: CustomTextField(
                    textEditingController: hollyPlaceController,
                    labelText: "Enter name of holyplace",
                    icondata: Icon(Icons.place))),
            Expanded(
                child: CustomTextField(
              textEditingController: locationController,
              labelText: "Enter location ",
              icondata: Icon(Icons.location_city),
            )),
            Expanded(
                child: CustomTextField(
              textEditingController: historyController,
              labelText: "Enter  History",
              icondata: Icon(Icons.history),
            )),
            Expanded(
                child: CustomTextField(
              textEditingController: imageUrlController,
              labelText: "Enter Image URL",
              icondata: Icon(Icons.image),
            )),
            Expanded(
                child: CustomRoundButton(
              backroundcolor: Colors.blue,
              displaytext: Text("Add Schedule"),
              onPressedfun: () {
                String nameofHolyplace = hollyPlaceController.text.toString();
                String location = locationController.text.toString();
                String history = historyController.text.toString();
                String imageurl = imageUrlController.text.toString();
                HolyplaceModel holyplaceModel = HolyplaceModel(
                  userid,
                  nameofHolyplace,
                  history: history,
                  location: location,
                  imageUrl: imageurl,
                );

                BlocProvider.of<HolyPlaceBloc>(context)
                    .add(createHolyplaceEvent(holyplaceModel));

                Navigator.pop(context);

                final mysnackbar = SnackBar(content: Text("$responseMessage"));
                ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
                
              },
            ))
          ],
        ));
  }
}
