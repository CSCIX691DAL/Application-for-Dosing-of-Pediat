import 'dart:html';

import 'package:flutter/material.dart';

class Med2 extends StatelessWidget {
  const Med2({Key? key}) : super(key: key);

  Widget buildCard(cardTitle) {
    return Card(
      color: Colors.blueGrey[100],
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: Column(
          children: <Widget>[
            Text(
              cardTitle,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "[Enter Value]",
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cyclosporin Dosing"),
        ),
        backgroundColor: Colors.blueGrey[700], //page background color

        body: Column(
          children: <Widget>[
            buildCard("Drug Concentration Needed (mg/kg/day)"),
            buildCard("Child's Weight (kg)"),
            buildCard("Drug Concentration (mg/mL)"),
            buildCard("Patient Weight (kg)"),
            buildCard("# of Doses"),
            buildCard("Days of Treatment"),
          ],
        ));
  }
}
