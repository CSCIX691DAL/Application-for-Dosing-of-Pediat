import 'package:flutter/material.dart';

class Med5 extends StatefulWidget {
  Med5(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med5State createState() => _Med5State();
}


class _Med5State extends State<Med5> {
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: Text(medication['name']),
          backgroundColor: Colors.redAccent,
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
            const formFieldContainer("Drug Concentration Needed (mg/kg/day)"),
            const formFieldContainer("Child's Weight (kg)"), 
            const formFieldContainer("Total Drug Dose Needed (mg/dose)"),
            
          ],
        ),
      ),
    );
  }
}

/* Class for creating text form*/
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
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            TextField(
              onChanged: (userInput){
                userInput;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Value",
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.purple.shade900, width: 3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade400, width: 3),
                  borderRadius: const BorderRadius.all(
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




