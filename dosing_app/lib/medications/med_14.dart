import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Med14 extends StatefulWidget {
  Med14(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med14State createState() => _Med14State();
}

class _Med14State extends State<Med14> {
  bool isFavourited = false;
  List<Map<String, dynamic>> favs = [];

  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController drugRequiredText = TextEditingController();
  TextEditingController dosesPerDayText = TextEditingController();
  TextEditingController mlPerDoseText = TextEditingController();
  TextEditingController volumeToDispenseText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  int concentration = 1;
  double drugRequired = 0;
  int dosesPerDay = 0;
  double mlPerDose = 0;
  int numDaysTreatment = 0;
  double volumeToDispense = 0;

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
        isFavourited = prefs.getBool('med14')!;
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
    totalDoseNeededText.text =
        (totalDoseNeeded).toStringAsFixed(2) + "mg"; // handle null and String
  }

  void calcDrugRequired() {
    drugRequired = totalDoseNeeded * concentration;
    drugRequiredText.text = drugRequired.toStringAsFixed(2) + "mL";
  }

  void calcMlPerDose() {
    mlPerDose = drugRequired / dosesPerDay;
    if (mlPerDose.isNaN || mlPerDose.isInfinite) {
      mlPerDoseText.text = (0).toStringAsFixed(2) + " mL/dose";
    } else {
      mlPerDoseText.text = (mlPerDose).toStringAsFixed(2) + " mL/dose";
    }
  }

  void calcVolumeToDispense() {
    volumeToDispense = drugRequired * numDaysTreatment;
    volumeToDispenseText.text = volumeToDispense.toStringAsFixed(2) + " mL";
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
                        prefs.setBool('med14', isFavourited);
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
                // Drug concentration needed input field
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
                          calcDrugRequired();
                          calcMlPerDose();
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
                          childWeight = x ?? 0; // handle null and String
                          calcTotalDosageNeeded();
                          calcDrugRequired();
                          calcMlPerDose();
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
                        labelText: "Total Dosage Needed (mg)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Concentration
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextFormField(
                    initialValue: concentration.toStringAsFixed(1),
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Concentration (mg/mL)",
                      hintText: "Concentration (mg/mL)",
                    ),
                  ),
                ),

                // Daily drug required output
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
                        labelText: "Daily Drug Required (mL)",
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
                        calcMlPerDose();
                        calcVolumeToDispense();
                      });
                    },
                  ),
                ),

                // mL per dose output
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: mlPerDoseText,
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
                        labelText: "mL/dose",
                        hintText: "0mL/dose",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Num days treatment input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
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
                          numDaysTreatment = x ?? 0; // handle null and String
                          calcVolumeToDispense();
                        });
                      }),
                ),

                // mL per dose output
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
                        labelText: "Volume to Dispense",
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
