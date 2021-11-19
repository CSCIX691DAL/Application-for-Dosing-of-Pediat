import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
class Med7 extends StatefulWidget {
  Med7(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med7State createState() => _Med7State();
}

class _Med7State extends State<Med7> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDrugDoseNeededText = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double numDaysTreatment = 0;
  double numMg = 0;
  int numTabsNeeded = 0;

  List<String> PropranololConcentration = ["3.75", "4.28", "5"];

  int mgPerTablet = 10;
String dropdownvalue="3.75";
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
    totalDrugDoseNeededText.text = (totalDoseNeeded).toStringAsFixed(2) +
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
                     ),
                ),

                // Total dosage needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDrugDoseNeededText,
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
                        labelText: "Total Drug Dosage Needed (mg/dose)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
                //
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
                          labelText: "Propranolol Concentration (mg/mL)"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownvalue,
                          isExpanded: true,
                          items: PropranololConcentration.map((String value) {
                            return DropdownMenuItem(
                              child: Text(value+ " mg"),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                               dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    )),

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
                     ),
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
                      labelText: "Total Volume to Dispense (mL)",
                      hintText: '0.00mL',
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
