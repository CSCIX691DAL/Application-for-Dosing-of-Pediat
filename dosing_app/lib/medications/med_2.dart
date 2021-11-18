import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med2 extends StatefulWidget {
  Med2(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med2State createState() => _Med2State();
}

class _Med2State extends State<Med2> {
  //textEditingController variables
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

  //
  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double numDaysTreatment = 0;
  double numMg = 0;
  int numTabsNeeded = 0;

  List<int> mgPerTabletItems = [10, 25];
  int mgPerTablet = 10;

  // Handle closing the keyboard when use taps anywhere else on the screen
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  // Functions for each output field
  void calcTotalDosageNeeded() {
    totalDoseNeeded = concentrationNeeded * childWeight;
    totalDoseNeededText.text = (totalDoseNeeded).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
  }

  void calcNumMg() {
    numMg = totalDoseNeeded * numDaysTreatment;
    numMgText.text = (numMg).toStringAsFixed(2) + "mg";
  }

  void calcNumTabsNeeded() {
    numTabsNeeded = (numMg / mgPerTablet).ceil();
    if (numTabsNeeded.isNaN || numTabsNeeded.isInfinite) {
      numTabsNeededText.text = (0).toString() + " tablets";
    } else {
      numTabsNeededText.text = (numTabsNeeded).toString() + " tablets";
    }
  }

  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(medication['name']),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isFavourited) {
                            widget.favMedications.remove(medication);
                          } else {
                            widget.favMedications.add(medication);
                          }
                        });
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
          backgroundColor: Colors.white, //page background color

          body: SingleChildScrollView(
            child: Column(
              children: [
                // Concentration needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    focusNode: myFocusNode,
                    controller: concentrationNeededText,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigo, width: 2.0),
                      ),
                      labelText: "Concentration Needed (mg/kg/dose)",
                      hintText: "0mg/kg/dose",
                    ),
                  ),
                ),

                // Drug concentration needed slider
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 0),
                  child: Slider(
                    value: concentrationNeeded,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: concentrationNeeded.toString(),
                    onChanged: (value) {
                      myFocusNode.requestFocus();
                      setState(() {
                        concentrationNeeded = value;
                        concentrationNeededText.text =
                            (concentrationNeeded.toString() + "mg/kg/dose");
                        calcTotalDosageNeeded();
                        calcNumMg();
                        calcNumTabsNeeded();
                      });
                    },
                  ),
                ),

                // Child's weight input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Child's Weight (kg)",
                        hintText: "Child's Weight (kg)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          childWeight = x ?? 0; // handle null and String
                          totalDoseNeeded = concentrationNeeded * childWeight;
                          totalDoseNeededText.text =
                              (totalDoseNeeded).toStringAsFixed(2) + "mg/dose";
                          numMg = totalDoseNeeded * numDaysTreatment;
                          if (numMg.isNaN || numMg.isInfinite) {
                            numMgText.text = (0).toStringAsFixed(2) + "mg";
                          } else {
                            numMgText.text = (numMg).toStringAsFixed(2) + "mg";
                          }
                          numTabsNeeded = (numMg / mgPerTablet).ceil();
                          if (numTabsNeeded.isNaN || numTabsNeeded.isInfinite) {
                            numTabsNeededText.text =
                                (0).toString() + " tablets";
                          } else {
                            numTabsNeededText.text =
                                (numTabsNeeded).toString() + " tablets";
                          }
                        });
                      }),
                ),

                // Total dosage needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDoseNeededText,
                    readOnly: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                        labelText: "Total Dosage Needed (mg/dose)",
                        hintText: "0mg/dose",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Number of days of treatment input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of Days of Treatment",
                        hintText: "Number of Days of Treatment",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          numDaysTreatment = x ?? 0;
                          calcNumMg();
                          calcNumTabsNeeded();
                        });
                      }),
                ),

                // Total mg output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: numMgText,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      labelText: "Total mg",
                      hintText: '0.00mg',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),

                // Drug concentration dropdown
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 30, bottom: 0),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.purple, width: 2.0),
                          ),
                          labelText: "Number of mg/tablet"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          // hint: Text('Please choose a location'),
                          isExpanded: true,
                          value: mgPerTablet,
                          onChanged: (newValue) {
                            setState(() {
                              mgPerTablet = newValue!;
                              calcNumTabsNeeded();
                            });
                          },
                          items: mgPerTabletItems.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.toString() + "mg"),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    )),

                // Total tablets needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 60),
                  child: TextField(
                    controller: numTabsNeededText,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      labelText: "Total Tablets Needed",
                      hintText: '0 tablets',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));

/*
    return Scaffold(
      appBar: AppBar(
        title: Text(medication['name']),
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
      backgroundColor: Colors.white, //page background color

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            formFieldContainer("Child's Weight (kg)"),
            formFieldContainer("Child's surface area (m2)"),
            dropDownList(
              listTitle: "Drug concentration (mg/ml)",
            ),

            ElevatedButton(
              onPressed: () {},
              child: Text("Calculate"),
            )

            //formFieldContainer("Drug concentration (mg/ml)"), //drop down  list
          ],
        ),
      ),  
    );
  
  */
  }
}

//Stateful widget to create the text form fields

class formFieldContainer extends StatefulWidget {
  final String formTitle;

  formFieldContainer(this.formTitle);

  @override
  State<formFieldContainer> createState() => _formFieldContainerState();
}

class _formFieldContainerState extends State<formFieldContainer> {
  final _valueHolder = TextEditingController();

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
                widget.formTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            TextField(
              controller: _valueHolder,
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
                  onChanged: (value) => setState(() => this.value = value),
                  value: value,
                  iconSize: 36,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  items: items.map(buildMenuItem).toList(),
                  isExpanded: true,
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
