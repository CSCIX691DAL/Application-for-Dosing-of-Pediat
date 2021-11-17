import 'package:flutter/material.dart';

class Med10 extends StatefulWidget {
  Med10(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med10State createState() => _Med10State();
}

class _Med10State extends State<Med10> {
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Itraconazole"),
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
            const formFieldContainer("Child's Weight (kg)"),
            const formFieldContainer("Child's surface area (m2)"),
            dropDownList(
              listTitle: "Drug concentration (mg/ml)",
            ),
            const formFieldContainer("Child's weight (kg)"),
            //formFieldContainer("Drug concentration (mg/ml)"), //drop down  list

            const formFieldContainer("Child's Weight (kg)"),
            const formFieldContainer("Child's Weight (kg)"),
            const formFieldContainer("Child's Weight (kg)"),
            const formFieldContainer("Child's Weight (kg)"),
            const formFieldContainer("Child's Weight (kg)"),
          ],
        ),
      ),
    );
  }
}