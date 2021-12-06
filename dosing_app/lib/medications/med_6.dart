import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med6 extends StatefulWidget {
  Med6(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med6State createState() => _Med6State();
}

class _Med6State extends State<Med6> {
  TextEditingController totalDoseNeededMgText = TextEditingController();
  TextEditingController totalDoseNeededMlText = TextEditingController();
  TextEditingController dosesPerDayText = TextEditingController();
  TextEditingController drugRequiredText = TextEditingController();
  TextEditingController volumeToDispenseText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeededMg = 0;
  double totalDoseNeededMl = 0;
  int dosesPerDay = 0;
  double drugRequired = 0;
  int numDaysTreatment = 0;
  double volumeToDispense = 0;

  List<int> drugConcentrationItems = [100];
  int drugConcentration = 100;

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

  void calcDosageNeededMg() {
    totalDoseNeededMg = concentrationNeeded * childWeight;
    totalDoseNeededMgText.text =
        (totalDoseNeededMg).toStringAsFixed(2) + "mg/dose";
  }

  void calcDosageNeededMl() {
    totalDoseNeededMl = totalDoseNeededMg / drugConcentration;
    if (totalDoseNeededMl.isNaN || totalDoseNeededMl.isInfinite) {
      totalDoseNeededMlText.text = (0).toStringAsFixed(2) + "mL";
    } else {
      totalDoseNeededMlText.text =
          (totalDoseNeededMl).toStringAsFixed(2) + "mL";
    }
  }

  void calcDrugRequired() {
    drugRequired = totalDoseNeededMl / dosesPerDay;
    if (drugRequired.isNaN || drugRequired.isInfinite) {
      drugRequiredText.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredText.text = (drugRequired).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispense() {
    volumeToDispense = drugRequired * numDaysTreatment;
    volumeToDispenseText.text = (volumeToDispense).toStringAsFixed(2) + "mL";
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
                // Concentration needed
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Concentration Needed (mg/kg/day)",
                        hintText: "Concentration Needed (mg/kg/day)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          concentrationNeeded = x ?? 0;
                          calcDosageNeededMg();
                          calcDosageNeededMl();
                          calcDrugRequired();
                          calcVolumeToDispense();
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
                          childWeight = x ?? 0;
                          calcDosageNeededMg();
                          calcDosageNeededMl();
                          calcDrugRequired();
                          calcVolumeToDispense();
                        });
                      }),
                ),

                // Total dosage needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDoseNeededMgText,
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
                          labelText: "Drug Concentration (mg/mL)"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          // hint: Text('Please choose a location'),
                          isExpanded: true,
                          value: drugConcentration,
                          onChanged: (newValue) {
                            setState(() {
                              drugConcentration = newValue!;
                              calcDosageNeededMl();
                              calcDrugRequired();
                              calcVolumeToDispense();
                            });
                          },
                          items: drugConcentrationItems.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.toString() + "mg/mL"),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    )),

                // Total dosage needed (ml) output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDoseNeededMlText,
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
                        labelText: "Total Dosage Needed (mL)",
                        hintText: "0mL",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // doses per day slider output
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    focusNode: myFocusNode,
                    controller: dosesPerDayText,
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
                      labelText: "Doses per Day",
                      hintText: "0 doses per day",
                    ),
                  ),
                ),

                // doses per day slider
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 0),
                  child: Slider(
                    value: dosesPerDay.toDouble(),
                    min: 0.0,
                    max: 5.0,
                    divisions: 5,
                    label: dosesPerDay.toString(),
                    onChanged: (value) {
                      myFocusNode.requestFocus();
                      setState(() {
                        dosesPerDay = value.toInt();
                        if (dosesPerDay == 1) {
                          dosesPerDayText.text =
                              (dosesPerDay.toString() + " dose per day");
                        } else {
                          dosesPerDayText.text =
                              (dosesPerDay.toString() + " doses per day");
                        }
                        calcDrugRequired();
                        calcVolumeToDispense();
                      });
                    },
                  ),
                ),

                // Drug required
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: drugRequiredText,
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
                        labelText: "Drug Required (mL/dose)",
                        hintText: "0mL/dose",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Number of days of treatment
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
                        final x = int.tryParse(value);
                        setState(() {
                          numDaysTreatment = x ?? 0;
                          calcVolumeToDispense();
                        });
                      }),
                ),

                // Total volume to dispense
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 60),
                  child: TextField(
                    controller: volumeToDispenseText,
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
                        labelText: "Total Volume to Dispense (mL/dose)",
                        hintText: "0mL",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
