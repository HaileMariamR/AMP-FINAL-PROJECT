import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, this.id}) : super(key: key);
  final id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  
                ),
              ],
            ),
          ),
        ));
  }
}
