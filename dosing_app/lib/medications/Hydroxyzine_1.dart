import 'package:flutter/material.dart';

class Hydroxyzine1 extends StatefulWidget {
  Hydroxyzine1(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Hydroxyzine1State createState() => _Hydroxyzine1State();
}

class  _Hydroxyzine1State  extends State<Hydroxyzine1> {
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
              textAlign:TextAlign.center ,
              decoration: InputDecoration(
                hintText: "Enter Value",
                border: InputBorder.none,

              ),
            )
          ],
        ),
      ),
    );
  }
  void calculate() {
    print("success");
  }
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Hydroxyzine"),
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
      body: Column(
        children:<Widget> [
          buildCard("BrandName:"),
          buildCard("Drug Concentration Need (mg/kg/day)"),
          buildCard("Patient Weight (kg)"),
          buildCard("Patient Age (years)"),
          ElevatedButton(
              child: const Text('Calculate'),
               onPressed:(){ calculate();},)

        ],


      ),

    );
  }
}
