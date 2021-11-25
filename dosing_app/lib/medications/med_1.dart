import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med1 extends StatefulWidget {
  Med1(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med1State createState() => _Med1State();
}

class _Med1State extends State<Med1> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

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
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 20, right: 20, top: 30, bottom: 0),
                //   child: TextField(
                //     focusNode: myFocusNode,
                //     controller: concentrationNeededText,
                //     readOnly: true,
                //     decoration: const InputDecoration(
                //       border: OutlineInputBorder(),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.grey, width: 1.0),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Colors.indigo, width: 2.0),
                //       ),
                //       labelText: "Concentration Needed (mg/kg/dose)",
                //       hintText: "0mg/kg/dose",
                //     ),
                //   ),
                // ),

                // // Drug concentration needed slider
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 5, right: 5, top: 5, bottom: 0),
                //   child: Slider(
                //     value: concentrationNeeded,
                //     min: 0.0,
                //     max: 1.0,
                //     divisions: 10,
                //     label: concentrationNeeded.toString(),
                //     onChanged: (value) {
                //       myFocusNode.requestFocus();
                //       setState(() {
                //         concentrationNeeded = value;
                //         concentrationNeededText.text =
                //             (concentrationNeeded.toString() + "mg/kg/dose");
                //         calcTotalDosageNeeded();
                //         calcNumMg();
                //         calcNumTabsNeeded();
                //       });
                //     },
                //   ),
                // ),

                // Drug concentration input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Concentration Needed (mg/kg/dose)",
                        hintText: "Concentration Needed (mg/kg/dose)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          concentrationNeeded =
                              x ?? 0; // handle null and String
                          calcTotalDosageNeeded();
                          calcNumMg();
                          calcNumTabsNeeded();
                        });
                      }),
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
                          calcTotalDosageNeeded();
                          calcNumMg();
                          calcNumTabsNeeded();
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
  }
}
