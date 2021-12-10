import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Med5 extends StatefulWidget {
  Med5(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  List<dynamic> favMedications;

  @override
  _Med5State createState() => _Med5State();
}

class _Med5State extends State<Med5> {
  bool isFavourited = false;
  List<Map<String, dynamic>> favs = [];

  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController totalDoseNeededTextMl = TextEditingController();
  TextEditingController totalDrugDoseRequiredText = TextEditingController();
  TextEditingController volumeToDispenseText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  int totalDoseNeededMl = 0;
  double doesPerDay = 0;
  int totalDoseRequired = 0;
  int daysOfTreatment = 0;
  int volumeToDispense = 0;

  List<int> drugConcentrationItems = [25, 250];
  int drugConcentrationDropDown = 25;

  // Handle closing the keyboard when use taps anywhere else on the screen
  late FocusNode myFocusNode;

  void loadFavs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        favs = (jsonDecode(prefs.getString('favMedications')!) as List)
            .map((dynamic e) => e as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      setState(() {
        favs = [];
      });
    }
  }

  void getFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        isFavourited = prefs.getBool('med5')!;
      } catch (e) {
        isFavourited = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    loadFavs();
    getFavoriteStatus();
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

  void calcTotalDosageNeededMl() {
    totalDoseNeededMl = (totalDoseNeeded / drugConcentrationDropDown).ceil();
    if (totalDoseNeededMl.isNaN || totalDoseNeededMl.isInfinite) {
      totalDoseNeededTextMl.text = (0).toString() + "ml";
    } else {
      totalDoseNeededTextMl.text = (totalDoseNeededMl).toString() + "ml";
    }
  }

  void calcDrugRequired() {
    try {
      totalDoseRequired = (totalDoseNeededMl / doesPerDay).ceil();
      if (totalDoseRequired.isNaN || totalDoseRequired.isInfinite) {
        totalDrugDoseRequiredText.text = (0).toString() + "mL/dose";
      } else {
        totalDrugDoseRequiredText.text =
            (totalDoseRequired).toString() + "mL/dose";
      }
    } catch (e) {
      totalDoseRequired = 0;
      totalDrugDoseRequiredText.text = (0).toString() + "mL/dose";
    }
  }

  void calcVolumeToDispense() {
    volumeToDispense = totalDoseRequired * daysOfTreatment;
    volumeToDispenseText.text =
        (volumeToDispense).toStringAsFixed(2) + "mL"; // handle null and String
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> medication = widget.medications[widget.index];

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
                      onTap: () async {
                        setState(() {
                          if (isFavourited) {
                            favs.removeWhere(
                                (item) => item["name"] == medication["name"]);
                            isFavourited = false;
                          } else {
                            favs.add(medication);
                            isFavourited = true;
                          }
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('favMedications', jsonEncode(favs));
                        prefs.setBool('med5', isFavourited);
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Drug Concentration Needed (mg/kg/day)",
                        hintText: "Drug Concentration Needed (mg/kg/day)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          concentrationNeeded =
                              x ?? 0; // handle null and String
                          calcTotalDosageNeeded();
                          calcTotalDosageNeededMl();
                          calcDrugRequired();
                          calcVolumeToDispense();
                        });
                      }),
                ),
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
                          calcTotalDosageNeededMl();
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
                        hintText: "Total Dosage Needed (mg/dose)",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

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
                          labelText: "Drug Concentration (mg/ml)"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          // hint: Text('Please choose a location'),
                          isExpanded: true,
                          value: drugConcentrationDropDown,
                          onChanged: (x) {
                            setState(() {
                              drugConcentrationDropDown = x!;
                              calcTotalDosageNeededMl();
                              calcDrugRequired();
                              calcVolumeToDispense();
                            });
                          },
                          items: drugConcentrationItems.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.toString() + "mg/ml"),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDoseNeededTextMl,
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
                        labelText: "Total Drug Dosage Needed (ml)",
                        hintText: "Total Drug Dosage Needed (ml)",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of doses/day",
                        hintText: "Number of doses/day",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          doesPerDay = x ?? 0;
                          calcDrugRequired();
                          calcVolumeToDispense(); // handle null and String
                        });
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDrugDoseRequiredText,
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
                        hintText: "Drug Required (mL/dose)",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of Days of Treatment",
                        hintText: "Number of Days of Treatment",
                      ),
                      onChanged: (value) {
                        final x = int.tryParse(value);
                        setState(() {
                          daysOfTreatment = x ?? 0;
                          calcVolumeToDispense(); // handle null and String
                        });
                      }),
                ),

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
                        labelText: "Total Volume to Dispense (mL)",
                        hintText: "Total Volume to Dispense (mL)",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
