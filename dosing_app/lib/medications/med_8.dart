

import 'package:flutter/material.dart';

class Med8 extends StatefulWidget
{
  Med8(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med8State createState() => _Med8State();
}
class _Med8State extends State<Med8>{
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hydroxyzine"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavourited) {
                        widget.favMedications.remove(medication);
                      } else {
                        widget.favMedications.add(medication);
                      }
                    });
                    print(widget.favMedications);
                  },
                  child: Icon(
                    isFavourited
                        ? Icons.bookmark
                        : Icons.bookmark_outline_rounded,
                    size: 34,
                    // color: isFavourited ? Colors,
                  )))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            formFieldContainer("Children's Weight (kg)"),
            formFieldContainer("Current dose per day (mg)"),
            formFieldContainer("Prior dose per day (mg)"),
            //formFieldContainer("Drug concentration (mg/ml)"), //drop down  list
            formFieldContainer("Days of treatment(day)"),

          ],
        ),
      ),
    );
  }

}
class formFieldContainer extends StatelessWidget{
  final String formTitle;
  const formFieldContainer(this.formTitle);
  @override
  Widget build(BuildContext context){
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

