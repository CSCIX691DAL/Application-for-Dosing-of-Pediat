import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med16 extends StatefulWidget {
  Med16(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med16State createState() => _Med16State();
}

class _Med16State extends State<Med16> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController dosePerTabletText = TextEditingController();
  TextEditingController tabletsPerDayText = TextEditingController();
  TextEditingController tabletsDispenseText = TextEditingController();

  double childWeight = 0;
  double drugConcentration = 0;
  double dosePerTablet =250;
  double tabletsPerDay = 0;
  double daysTreatment = 0;
  double tabletsDispense = 0;
  int numTabsNeeded = 0;


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
  void calcDrugConcentration() {
    if(childWeight >= 10 && childWeight <= 19.99){
      drugConcentration = 62.5;
    }
    else if(childWeight >= 20 && childWeight <= 39.99){
      drugConcentration = 125;
    }
    else{
      drugConcentration = 250;
    }
    concentrationNeededText.text = (drugConcentration).toStringAsFixed(2) +
        "mg/day"; // handle null and String
  }

  void calcDosePerTablet() {
    dosePerTabletText.text = (dosePerTablet).toStringAsFixed(0) +
        "mg"; // handle null and String
  }

  void calcTabletsPerDay() {
    tabletsPerDay = drugConcentration/dosePerTablet;

    tabletsPerDayText.text = (tabletsPerDay).toStringAsFixed(2) +
    " tablet(s)"; // handle null and String
  }

  void calcTabletsToDispense() {
    tabletsDispense = tabletsPerDay*daysTreatment;

    tabletsDispenseText.text = (tabletsDispense).toStringAsFixed(0) +
        " tablet(s)"; // handle null and String
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
                      const TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Child's Weight (kg)",
                        hintText: "Child's Weight (kg)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          childWeight = x ?? 0;
                          calcDrugConcentration();
                          calcDosePerTablet();
                          calcTabletsPerDay();
                        });
                      }),
                ),
                // Drug Concentration Needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: concentrationNeededText,
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
                        labelText: "Drug Concentration Needed (mg/day)",
                        hintText: "0mg/day",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Num mg per tablet
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextFormField(
                    initialValue:
                    dosePerTablet.toStringAsFixed(0) + "mg",
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Dose per Tablet",
                      hintText: "Dose per Tablet",
                    ),
                  ),
                ),
                // tablets per Day output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: tabletsPerDayText,
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
                      labelText: "Tablets per Day",
                      hintText: '0 tablets',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                // Days Treatment input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "# Days of Treatment",
                        hintText: "# Days of Treatment",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          daysTreatment = x ?? 0;
                          calcTabletsToDispense();
                        });
                      }),
                ),
                // Total # Tablets to Dispense output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: tabletsDispenseText,
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
                      labelText: "Total # Tablets to Dispense",
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
