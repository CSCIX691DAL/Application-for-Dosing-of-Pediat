import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isFavourited = false;
  List<Map<String, dynamic>> favs = [];
  // tab 1 output fields
  TextEditingController dosageNeededT1Text = TextEditingController();
  TextEditingController dosageNeededT1Text_mL_type3 = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  //adder
  TextEditingController drugRequiredT1Text_type3 = TextEditingController();
  TextEditingController drugRequiredT1Text_type4 = TextEditingController();
  TextEditingController volumeToDispenseT1Text_type4 = TextEditingController();
  TextEditingController mlRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();
  TextEditingController mgRequiredT1Text = TextEditingController();
  TextEditingController capsulesToDispenseT1Text = TextEditingController();

  // tab 1 variables
  double concentrationNeeded = 0;
  double childWeight = 0;
  double childSurfaceAreaT1 = 0;
  double dosageNeededT1 = 0;
  double dosageNeededT1_mL_type3 = 0;
  int concentrationT1 = 250;
  List<int> concentrationsT1 = [250];
  double drugRequiredT1 = 0;
  //adder
  double drugRequiredT1_type4 = 0;
  double mlRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  int numDosesPerDay_type3 = 0;
  int numDosesPerDay_type4 = 0;
  double volumeToDispenseT1 = 0;
  //adder
  double volumeToDispenseT1_type4 = 0;
  double mgRequiredT1 = 0;
  int capsulesToDispenseT1 = 0;
  List<String> concentrationTypeList = [
    "mg/kg/dose",
    "mg/m2",
    "mg/kg/day",
    "mg/dose"
  ];
  String concentrationType = "mg/kg/dose";
  bool show_mg_kg_dose = true;
  bool show_mg_m2 = false;
  bool show_mg_kg_day = false;
  bool show_mg_dose = false;
  String conc_NeededInputLabelText = '';
  String conc_NeededInputHintText = '';

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
        isFavourited = prefs.getBool('med2')!;
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

  // toggling different forms based on dropdown entry for tab 1
  void toggle_mg_kg_dose() {
    show_mg_kg_dose = true;
    show_mg_m2 = false;
    show_mg_kg_day = false;
    show_mg_dose = false;

    resetValuesT1();
  }

  void toggle_mg_m2() {
    show_mg_kg_dose = false;
    show_mg_m2 = true;
    show_mg_kg_day = false;
    show_mg_dose = false;
    conc_NeededInputLabelText = 'Concentration Needed (mg/m2)';
    conc_NeededInputHintText = 'Concentration Needed';
    resetValuesT1();
  }

  void toggle_mg_kg_day() {
    show_mg_kg_dose = false;
    show_mg_m2 = false;
    show_mg_kg_day = true;
    show_mg_dose = false;
    conc_NeededInputLabelText = 'Concentration Needed (mg/kg/day)';
    conc_NeededInputHintText = 'Concentration Needed';
    resetValuesT1();
  }

  void toggle_mg_dose() {
    show_mg_kg_dose = false;
    show_mg_m2 = false;
    show_mg_kg_day = false;
    show_mg_dose = true;
    conc_NeededInputLabelText = 'Concentration Needed (mg/dose)';
    conc_NeededInputHintText = 'Concentration Needed';
    resetValuesT1();
  }

  void handleDrugConcentrationDropDown() {
    if (concentrationType == "mg/kg/dose") {
      toggle_mg_kg_dose();
    } else if (concentrationType == "mg/m2") {
      toggle_mg_m2();
    } else if (concentrationType == "mg/kg/day") {
      toggle_mg_kg_day();
    } else if (concentrationType == "mg/dose") {
      toggle_mg_dose();
    }
  }

  void resetValuesT1() {
    concentrationNeeded = 0;
    childWeight = 0;
    childSurfaceAreaT1 = 0;
    dosageNeededT1 = 0;
    dosageNeededT1_mL_type3 = 0;
    drugRequiredT1 = 0;
    drugRequiredT1_type4 = 0;
    volumeToDispenseT1_type4 = 0;
    mlRequiredT1 = 0;
    numDaysTreatmentT1 = 0;
    numDosesPerDay_type3 = 0;
    numDosesPerDay_type4 = 0;
    volumeToDispenseT1 = 0;
    capsulesToDispenseT1 = 0;
    mgRequiredT1 = 0;
    dosageNeededT1Text.text = '';
    dosageNeededT1Text_mL_type3.text = '';
    drugRequiredT1Text.text = '';
    drugRequiredT1Text_type4.text = '';
    mlRequiredT1Text.text = '';
    volumeToDispenseT1Text.text = '';
    volumeToDispenseT1Text_type4.text = '';
    mgRequiredT1Text.text = '';
    capsulesToDispenseT1Text.text = '';
  }

  // dose calculation functions for tab 1
  void calcDosageNeeded_weight() {
    dosageNeededT1 = concentrationNeeded * childWeight;
    dosageNeededT1Text.text = (dosageNeededT1).toStringAsFixed(2) + "mg/dose";
  }

  void calcDosageNeeded_surfaceArea() {
    dosageNeededT1 = concentrationNeeded * childSurfaceAreaT1;
    dosageNeededT1Text.text = (dosageNeededT1).toStringAsFixed(2) + "mg/dose";
  }

  void calcDosageNeeded_mL_type3() {
    dosageNeededT1_mL_type3 = dosageNeededT1 / concentrationT1;
    dosageNeededT1Text_mL_type3.text =
        (dosageNeededT1_mL_type3).toStringAsFixed(2) + "mL";
  }

  void calcDrugRequiredT1() {
    drugRequiredT1 = dosageNeededT1 / concentrationT1;
    if (drugRequiredT1.isNaN || drugRequiredT1.isInfinite) {
      drugRequiredT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      drugRequiredT1Text.text = (drugRequiredT1).toStringAsFixed(2) + "mL";
    }
  }

  void calcDrugRequiredT1_type3() {
    drugRequiredT1_type4 = dosageNeededT1_mL_type3 / numDosesPerDay_type3;
    if (drugRequiredT1_type4.isNaN || drugRequiredT1_type4.isInfinite) {
      drugRequiredT1Text_type4.text = (0).toStringAsFixed(2) + "mL";
    } else {
      drugRequiredT1Text_type4.text =
          (drugRequiredT1_type4).toStringAsFixed(2) + "mL";
    }
  }

  void calcDrugRequiredT1_type4() {
    drugRequiredT1_type4 = concentrationNeeded / concentrationT1;
    if (drugRequiredT1_type4.isNaN || drugRequiredT1_type4.isInfinite) {
      drugRequiredT1Text_type4.text = (0).toStringAsFixed(2) + "mL";
    } else {
      drugRequiredT1Text_type4.text =
          (drugRequiredT1_type4).toStringAsFixed(2) + "mL";
    }
  }

  void calcMlRequiredT1() {
    mlRequiredT1 = drugRequiredT1 * 2;
    if (mlRequiredT1.isNaN || mlRequiredT1.isInfinite) {
      mlRequiredT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      mlRequiredT1Text.text = (mlRequiredT1).toStringAsFixed(2) + "mL";
    }
  }

  void calcVolumeToDispenseT1() {
    volumeToDispenseT1 = drugRequiredT1 * numDaysTreatmentT1;
    if (volumeToDispenseT1.isNaN || volumeToDispenseT1.isInfinite) {
      volumeToDispenseT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT1Text.text =
          (volumeToDispenseT1).toStringAsFixed(2) + "mL";
    }
  }

  void calcVolumeToDispenseT1_type3() {
    volumeToDispenseT1_type4 = drugRequiredT1_type4 * numDaysTreatmentT1;
    if (volumeToDispenseT1_type4.isNaN || volumeToDispenseT1_type4.isInfinite) {
      volumeToDispenseT1Text_type4.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT1Text_type4.text =
          (volumeToDispenseT1_type4).toStringAsFixed(2) + "mL";
    }
  }

  void calcVolumeToDispenseT1_type4() {
    volumeToDispenseT1_type4 =
        drugRequiredT1_type4 * numDaysTreatmentT1 * numDosesPerDay_type4;
    if (volumeToDispenseT1_type4.isNaN || volumeToDispenseT1_type4.isInfinite) {
      volumeToDispenseT1Text_type4.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT1Text_type4.text =
          (volumeToDispenseT1_type4).toStringAsFixed(2) + "mL";
    }
  }

  void calcMgRequiredT1() {
    mgRequiredT1 = dosageNeededT1 * 2;
    if (mgRequiredT1.isNaN || mgRequiredT1.isInfinite) {
      mgRequiredT1Text.text = (0).toStringAsFixed(2) + "mg";
    } else {
      mgRequiredT1Text.text = (mgRequiredT1).toStringAsFixed(2) + "mg";
    }
  }

  //TODO: fix calculation to use numDaysTreatment
  void calcCapsulesToDispenseT1() {
    capsulesToDispenseT1 = ((dosageNeededT1 / 250) * 2).ceil();
    if (capsulesToDispenseT1.isNaN || capsulesToDispenseT1.isInfinite) {
      capsulesToDispenseT1Text.text = (0).toStringAsFixed(2) + " capsules";
    } else {
      capsulesToDispenseT1Text.text =
          (capsulesToDispenseT1).toStringAsFixed(2) + " capsules";
    }
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
                        prefs.setBool('med2', isFavourited);
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
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Drug type dropdown
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
                          labelText: "Drug Concentration Needed"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: concentrationType,
                          onChanged: (newValue) {
                            concentrationType = newValue!;
                            setState(() {
                              handleDrugConcentrationDropDown();
                            });
                          },
                          items: concentrationTypeList.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    )),

                // ** mg/kg/dose (Type 1)**
                Visibility(
                    visible: (show_mg_kg_dose),
                    child: Column(children: [
                      // Concentration needed
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Concentration Needed (mg/kg/dose)",
                              hintText: "Concentration Needed",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationNeeded = x ?? 0;
                                calcDosageNeeded_surfaceArea();
                                calcDrugRequiredT1();
                                calcMlRequiredT1();
                                calcVolumeToDispenseT1();
                              });
                            }),
                      ),

                      // Child's weight input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Child's Weight (kg)",
                              hintText: "Child's Weight (kg)",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                childWeight = x ?? 0; // handle null and String
                                calcDosageNeeded_weight();
                                calcMgRequiredT1();
                                calcCapsulesToDispenseT1();
                              });
                            }),
                      ),

                      // Total dosage needed output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: dosageNeededT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
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
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2.0),
                                ),
                                labelText: "Drug Concentration"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: concentrationT1,
                                onChanged: (newValue) {
                                  concentrationT1 = newValue!;
                                  setState(() {
                                    calcDrugRequiredT1();
                                    calcMlRequiredT1();
                                    calcVolumeToDispenseT1();
                                  });
                                },
                                items: concentrationsT1.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Drug required output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: drugRequiredT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Drug Required (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // Number of days of treatment input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of Days of Treatment",
                              hintText: "Number of Days of Treatment",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT1 = x ?? 0;
                                calcVolumeToDispenseT1();
                              });
                            }),
                      ),

                      // Total volume to dispense output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 60),
                        child: TextField(
                          controller: volumeToDispenseT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Total Volume To Dispense (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),
                    ])),

                // ** mg/m2 (type 2) **

                Visibility(
                    visible: (show_mg_m2),
                    child: Column(children: [
                      // Concentration needed
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Concentration Needed (mg/m2)",
                              hintText: "Concentration Needed",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationNeeded = x ?? 0;
                                calcDosageNeeded_surfaceArea();
                                calcDrugRequiredT1();
                                calcMlRequiredT1();
                                calcVolumeToDispenseT1();
                              });
                            }),
                      ),

                      // Child surface area
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Child's Surface Area (m²)",
                              hintText: "Child's Surface Area (m²)",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                childSurfaceAreaT1 = x ?? 0;
                                calcDosageNeeded_surfaceArea();
                                calcDrugRequiredT1();
                                calcMlRequiredT1();
                                calcVolumeToDispenseT1();
                              });
                            }),
                      ),

                      // Total dosage needed output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: dosageNeededT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
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
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2.0),
                                ),
                                labelText: "Drug Concentration"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: concentrationT1,
                                onChanged: (newValue) {
                                  concentrationT1 = newValue!;
                                  setState(() {
                                    calcDrugRequiredT1();
                                    calcMlRequiredT1();
                                    calcVolumeToDispenseT1();
                                  });
                                },
                                items: concentrationsT1.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Drug required output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: drugRequiredT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Drug Required (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // mL required output field

                      // Number of days of treatment input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of Days of Treatment",
                              hintText: "Number of Days of Treatment",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT1 = x ?? 0;
                                calcVolumeToDispenseT1();
                              });
                            }),
                      ),

                      // Total volume to dispense output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 60),
                        child: TextField(
                          controller: volumeToDispenseT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Total Volume To Dispense (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),
                    ])),

                // ** mg/kg/day (type 3) **

                Visibility(
                    visible: (show_mg_kg_day),
                    child: Column(children: [
                      // Concentration needed
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: conc_NeededInputLabelText,
                              hintText: conc_NeededInputHintText,
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationNeeded = x ?? 0;
                                calcDosageNeeded_surfaceArea();
                                calcMgRequiredT1();
                                calcCapsulesToDispenseT1();
                              });
                            }),
                      ),

                      // Child's weight input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Child's Weight (kg)",
                              hintText: "Child's Weight (kg)",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                childWeight = x ?? 0; // handle null and String
                                calcDosageNeeded_weight();
                                calcMgRequiredT1();
                                calcCapsulesToDispenseT1();
                              });
                            }),
                      ),

                      // Total dosage needed output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: dosageNeededT1Text,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
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
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2.0),
                                ),
                                labelText: "Drug Concentration"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: concentrationT1,
                                onChanged: (newValue) {
                                  concentrationT1 = newValue!;
                                  setState(() {
                                    //calcDrugRequiredT1();
                                    //calcMlRequiredT1();
                                    //calcVolumeToDispenseT1();
                                    //calcDrugRequiredT1_type3();
                                    calcDosageNeeded_mL_type3();
                                  });
                                },
                                items: concentrationsT1.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Total Drug Dose Neededoutput field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: dosageNeededT1Text_mL_type3,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Total Drug Dose Needed(mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // NUmber of doses per day input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of doses per day",
                              hintText: "Number of doses per day",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDosesPerDay_type3 = x ?? 0;
                                calcDrugRequiredT1_type3();
                              });
                            }),
                      ),

                      // Drug required output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: drugRequiredT1Text_type4,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Drug Required (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // NUmber of days of treatment input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of Days of Treatment",
                              hintText: "Number of Days of Treatment",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT1 = x ?? 0;
                                //calcCapsulesToDispenseT1();
                                calcVolumeToDispenseT1_type3();
                              });
                            }),
                      ),

                      // Total number of capsules/tablets/intravenous to dispense
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: volumeToDispenseT1Text_type4,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Total Volume to Dispense (mL)",
                              hintText: "Total Volume to Dispense (mL)",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),
                    ])),

                // ** mg/dose (type 4) **
                Visibility(
                    visible: (show_mg_dose),
                    child: Column(children: [
                      // Concentration needed
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: conc_NeededInputLabelText,
                              hintText: conc_NeededInputHintText,
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationNeeded = x ?? 0;
                                calcDosageNeeded_surfaceArea();
                                calcMgRequiredT1();
                                calcCapsulesToDispenseT1();
                              });
                            }),
                      ),

                      // Drug concentration dropdown
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2.0),
                                ),
                                labelText: "Drug Concentration"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: concentrationT1,
                                onChanged: (newValue) {
                                  concentrationT1 = newValue!;
                                  setState(() {
                                    calcDrugRequiredT1_type4();
                                    // calcMlRequiredT1();
                                    calcVolumeToDispenseT1_type4(); //need to check this calculation
                                  });
                                },
                                items: concentrationsT1.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Drug required output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: drugRequiredT1Text_type4,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Drug Required (mL)",
                              hintText: "0mL",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // NUmber of doses per day input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of doses per day",
                              hintText: "Number of doses per day",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDosesPerDay_type4 = x ?? 0;
                                calcVolumeToDispenseT1_type4();
                              });
                            }),
                      ),

                      // NUmber of days of treatment input field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Number of Days of Treatment",
                              hintText: "Number of Days of Treatment",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT1 = x ?? 0;
                                //calcCapsulesToDispenseT1();
                                calcVolumeToDispenseT1_type4();
                              });
                            }),
                      ),

                      // Total number of capsules/tablets/intravenous to dispense
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: volumeToDispenseT1Text_type4,
                          readOnly: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.purple, width: 2.0),
                              ),
                              labelText: "Total Volume to Dispense (mL)",
                              hintText: "Total Volume to Dispense (mL)",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),
                    ])),
              ],
            ),
          ), //page background color
        ));
  }
}
