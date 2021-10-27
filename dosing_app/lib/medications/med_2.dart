//import 'dart:html';

import 'package:flutter/material.dart';

class Med2 extends StatelessWidget {
  const Med2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acyclovir"),
      ),
      backgroundColor: Colors.white, //page background color

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's surface area (m2)"),
            dropDownList(
              listTitle: "Drug concentration (mg/ml)",
            ),
            formFieldContainer("Child's weight (kg)"),
            //formFieldContainer("Drug concentration (mg/ml)"), //drop down  list

            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's Weight (kg)"),
          ],
        ),
      ),
    );
  }
}

//Stateless widget to create the text form fields

class formFieldContainer extends StatelessWidget {
  final String formTitle;

  const formFieldContainer(this.formTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Text(
                formTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Value",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.purple.shade900, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade400, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Drop Down list widget

class dropDownList extends StatefulWidget {
  //const dropDownList({this.formTitle = formTitle});
  String listTitle; // receives the value

  dropDownList({required this.listTitle});

  @override
  _dropDownListState createState() => _dropDownListState();
}

class _dropDownListState extends State<dropDownList> {
  final items = ['item1', 'item2', 'item3', 'item4'];
  String? value;

  // final String listTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Text(
                widget.listTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade900, width: 3),
              ),
              child: DropdownButtonHideUnderline(
                //hides the underline in the text
                child: DropdownButton<String>(
                  value: value,
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: items.map(buildMenuItem).toList(),
                  isExpanded: true,
                  //onChanged: (value) => setState(() => this.value = value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
