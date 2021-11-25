import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med12 extends StatefulWidget {
  Med12(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med12State createState() => _Med12State();
}

class _Med12State extends State<Med12> {
  // tab 1 output fields
  TextEditingController dosageNeededT1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController mlRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();
  TextEditingController mgRequiredT1Text = TextEditingController();
  TextEditingController capsulesToDispenseT1Text = TextEditingController();

  // tab 1 variables
  double concentrationNeededMgMDoseT1 = 0;
  double childSurfaceAreaT1 = 0;
  double dosageNeededT1 = 0;
  int concentrationT1 = 250;
  List<int> concentrationsT1 = [250];
  double drugRequiredT1 = 0;
  double mlRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  double volumeToDispenseT1 = 0;
  double mgRequiredT1 = 0;
  int capsulesToDispenseT1 = 0;
  List<String> methodsOfAdmin = [
    "Suspension",
    "Capsule",
    "Tablet",
    "Intravenous"
  ];
  String methodOfAdminT1 = "Suspension";
  bool showSuspensionT1 = true;
  bool showCapsuleT1 = false;
  bool showTabletT1 = false;
  bool showIntravenousT1 = false;
  String dispenseLabelTextT1 = '';
  String dispenseHintTextT1 = '';

  // tab 2 output fields
  TextEditingController drugRequiredMgT2Text = TextEditingController();
  TextEditingController drugRequiredMlT2Text = TextEditingController();
  TextEditingController volumeToDispenseT2Text = TextEditingController();
  TextEditingController unitPerDoseT2Text = TextEditingController();
  TextEditingController unitToDispenseT2Text = TextEditingController();

  // tab 2 variables
  double bodySurfaceAreaT2 = 0;
  int drugRequiredMgT2 = 0;
  double drugRequiredMlT2 = 0;
  int unitPerDoseT2 = 0;
  int dosesPerDayT2 = 0;
  int numDaysTreatmentT2 = 0;
  double volumeToDispenseT2 = 0;
  int numDosesPerDayT2 = 2;
  double unitToDispenseT2 = 0;
  String unitToDispenseStrT2 = '';

  String methodOfAdminT2 = "Suspension";
  bool showSuspensionT2 = true;
  bool showCapsuleT2 = false;
  bool showTabletT2 = false;
  bool showIntravenousT2 = false;
  String unitPerDoseLabelTextT2 = '';
  String unitPerDoseHintTextT2 = '';

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

  // toggling different forms based on dropdown entry for tab 1
  void toggleSuspensionT1() {
    showSuspensionT1 = true;
    showCapsuleT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = false;
    resetValuesT1();
  }

  void toggleCapsuleT1() {
    showSuspensionT1 = false;
    showCapsuleT1 = true;
    showTabletT1 = false;
    showIntravenousT1 = false;
    dispenseLabelTextT1 = 'Total Number of Capsules to Dispense';
    dispenseHintTextT1 = '0 capsules';
    resetValuesT1();
  }

  void toggleTabletT1() {
    showSuspensionT1 = false;
    showCapsuleT1 = false;
    showTabletT1 = true;
    showIntravenousT1 = false;
    dispenseLabelTextT1 = 'Total Number of Tablets to Dispense';
    dispenseHintTextT1 = '0 tablets';
    resetValuesT1();
  }

  void toggleIntravenousT1() {
    showSuspensionT1 = false;
    showCapsuleT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = true;
    dispenseLabelTextT1 = 'Total mg of Intravenous to Dispense';
    dispenseHintTextT1 = '0mg';
    resetValuesT1();
  }

  void handleDrugDeliveryDropDownT1() {
    if (methodOfAdminT1 == "Suspension") {
      toggleSuspensionT1();
    } else if (methodOfAdminT1 == "Capsule") {
      toggleCapsuleT1();
    } else if (methodOfAdminT1 == "Tablet") {
      toggleTabletT1();
    } else if (methodOfAdminT1 == "Intravenous") {
      toggleIntravenousT1();
    }
  }

  void resetValuesT1() {
    concentrationNeededMgMDoseT1 = 0;
    childSurfaceAreaT1 = 0;
    dosageNeededT1 = 0;
    drugRequiredT1 = 0;
    mlRequiredT1 = 0;
    numDaysTreatmentT1 = 0;
    volumeToDispenseT1 = 0;
    capsulesToDispenseT1 = 0;
    mgRequiredT1 = 0;
    dosageNeededT1Text.text = '';
    drugRequiredT1Text.text = '';
    mlRequiredT1Text.text = '';
    volumeToDispenseT1Text.text = '';
    mgRequiredT1Text.text = '';
    capsulesToDispenseT1Text.text = '';
  }

  // dose calculation functions for tab 1
  void calcDosageNeededT1() {
    dosageNeededT1 = concentrationNeededMgMDoseT1 * childSurfaceAreaT1;
    dosageNeededT1Text.text = (dosageNeededT1).toStringAsFixed(2) + "mg/dose";
  }

  void calcDrugRequiredT1() {
    drugRequiredT1 = dosageNeededT1 / concentrationT1;
    if (drugRequiredT1.isNaN || drugRequiredT1.isInfinite) {
      drugRequiredT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      drugRequiredT1Text.text = (drugRequiredT1).toStringAsFixed(2) + "mL";
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
    capsulesToDispenseT1 =
        ((dosageNeededT1 / 250) * 2).ceil() * numDaysTreatmentT1;
    if (capsulesToDispenseT1.isNaN || capsulesToDispenseT1.isInfinite) {
      capsulesToDispenseT1Text.text = (0).toStringAsFixed(2) + " capsules";
    } else {
      capsulesToDispenseT1Text.text =
          (capsulesToDispenseT1).toStringAsFixed(2) + " capsules";
    }
  }

  // toggling different forms based on dropdown entry for tab 2
  void toggleSuspensionT2() {
    showSuspensionT2 = true;
    showCapsuleT2 = false;
    showTabletT2 = false;
    showIntravenousT2 = false;
    resetValuesT2();
  }

  void toggleCapsuleT2() {
    showSuspensionT2 = false;
    showCapsuleT2 = true;
    showTabletT2 = false;
    showIntravenousT2 = false;
    unitPerDoseLabelTextT2 = 'Capsules per Dose';
    unitPerDoseHintTextT2 = '0 capsules';
    resetValuesT2();
  }

  void toggleTabletT2() {
    showSuspensionT2 = false;
    showCapsuleT2 = false;
    showTabletT2 = true;
    showIntravenousT2 = false;
    unitPerDoseLabelTextT2 = 'Tablets per Dose';
    unitPerDoseHintTextT2 = '0 tablets';
    resetValuesT2();
  }

  void toggleIntravenousT2() {
    showSuspensionT2 = false;
    showCapsuleT2 = false;
    showTabletT2 = false;
    showIntravenousT2 = true;
    unitPerDoseLabelTextT2 = 'mg Intravenous per Dose';
    unitPerDoseHintTextT2 = '0 mg';
    resetValuesT2();
  }

  void handleDrugDeliveryDropDownT2() {
    if (methodOfAdminT2 == "Suspension") {
      toggleSuspensionT2();
    } else if (methodOfAdminT2 == "Capsule") {
      toggleCapsuleT2();
    } else if (methodOfAdminT2 == "Tablet") {
      toggleTabletT2();
    } else if (methodOfAdminT2 == "Intravenous") {
      toggleIntravenousT2();
    }
  }

  void resetValuesT2() {
    bodySurfaceAreaT2 = 0;
    drugRequiredMgT2 = 0;
    drugRequiredMlT2 = 0;
    unitPerDoseT2 = 0;
    numDaysTreatmentT2 = 0;
    volumeToDispenseT2 = 0;
    unitPerDoseT2 = 0;

    drugRequiredMgT2Text.text = '';
    drugRequiredMlT2Text.text = '';
    unitPerDoseT2Text.text = '';
    volumeToDispenseT2Text.text = '';
  }

  // dose calculation functions for tab 2

  void calcDrugRequiredMgT2() {
    if (bodySurfaceAreaT2 >= 1.25 && bodySurfaceAreaT2 < 1.5) {
      drugRequiredMgT2 = 750;
    } else if (bodySurfaceAreaT2 >= 1.5) {
      drugRequiredMgT2 = 1000;
    } else {
      drugRequiredMgT2 = 0;
    }
    drugRequiredMgT2Text.text = drugRequiredMgT2.toString() + 'mg/dose';
  }

  void calcDrugRequiredMlT2() {
    drugRequiredMlT2 = drugRequiredMgT2 / 200;
    if (drugRequiredMlT2.isNaN || drugRequiredMlT2.isInfinite) {
      drugRequiredMlT2Text.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredMlT2Text.text =
          (drugRequiredMlT2).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispenseT2() {
    volumeToDispenseT2 =
        drugRequiredMlT2 * numDosesPerDayT2 * numDaysTreatmentT2;

    if (volumeToDispenseT2.isNaN || volumeToDispenseT2.isInfinite) {
      volumeToDispenseT2Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT2Text.text =
          (volumeToDispenseT2).toStringAsFixed(2) + "mL";
    }
  }

  void calcUnitPerDoseT2() {
    if (showCapsuleT2) {
      unitPerDoseT2 = (drugRequiredMgT2 / 250).round();
      unitPerDoseT2Text.text = '0 capsules';
    } else {
      unitPerDoseT2 = (drugRequiredMgT2 / 500).round();
      if (showTabletT2) {
        unitPerDoseT2Text.text = unitPerDoseT2.toString() + ' capsules';
      } else {
        unitPerDoseT2Text.text = unitPerDoseT2.toString() + 'mg';
      }
    }
  }

  calcUnitToDispenseT2() {
    unitToDispenseT2 =
        unitPerDoseT2.toDouble() * numDosesPerDayT2 * numDaysTreatmentT2;
    if (unitToDispenseT2.isNaN || unitToDispenseT2.isInfinite) {
      unitToDispenseStrT2 = '0';
    } else {
      unitToDispenseStrT2 = (unitToDispenseT2).toStringAsFixed(2);
    }

    if (showCapsuleT2) {
      unitToDispenseT2Text.text = unitToDispenseStrT2 + " capsules";
    } else if (showTabletT2) {
      unitToDispenseT2Text.text = unitToDispenseStrT2 + " tablets";
    } else if (showIntravenousT2) {
      unitToDispenseT2Text.text = unitToDispenseStrT2 + "mg intravenous";
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
        child: DefaultTabController(
            length: 2,
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
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "Concentration"),
                      Tab(text: "Surface Area"),
                    ],
                  ),
                ),
                backgroundColor: Colors.white, //page background color

                body: TabBarView(children: [
                  // *** TAB 1 ***
                  SingleChildScrollView(
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
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                  ),
                                  labelText: "Drug Delivery Method"),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: methodOfAdminT1,
                                  onChanged: (newValue) {
                                    methodOfAdminT1 = newValue!;
                                    setState(() {
                                      handleDrugDeliveryDropDownT1();
                                    });
                                  },
                                  items: methodsOfAdmin.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),

                        // **SUSPENSION**
                        Visibility(
                            visible: (showSuspensionT1),
                            child: Column(children: [
                              // Concentration needed
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText:
                                          "Concentration Needed (mg/m²/dose)",
                                      hintText:
                                          "Concentration Needed (mg/m²/dose)",
                                    ),
                                    onChanged: (value) {
                                      final x = double.tryParse(value);
                                      setState(() {
                                        concentrationNeededMgMDoseT1 = x ?? 0;
                                        calcDosageNeededT1();
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
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                        calcDosageNeededT1();
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
                                      labelText:
                                          "Total Dosage Needed (mg/dose)",
                                      hintText: "0mg/dose",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
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
                                            child:
                                                Text(value.toString() + "mg"),
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
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // mL required output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: mlRequiredT1Text,
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
                                      labelText: "mL Required BID Dosing",
                                      hintText: "0mL",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // Number of days of treatment input field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                      labelText:
                                          "Total Volume To Dispense (mL)",
                                      hintText: "0mL",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),
                            ])),

                        // **Capsule or Tablet or Intravenous**
                        Visibility(
                            visible: (showCapsuleT1 ||
                                showTabletT1 ||
                                showIntravenousT1),
                            child: Column(children: [
                              // Concentration needed
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText:
                                          "Concentration Needed (mg/m²/dose)",
                                      hintText:
                                          "Concentration Needed (mg/m²/dose)",
                                    ),
                                    onChanged: (value) {
                                      final x = double.tryParse(value);
                                      setState(() {
                                        concentrationNeededMgMDoseT1 = x ?? 0;
                                        calcDosageNeededT1();
                                        calcMgRequiredT1();
                                        calcCapsulesToDispenseT1();
                                      });
                                    }),
                              ),

                              // Child surface area
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                        calcDosageNeededT1();
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
                                      labelText:
                                          "Total Dosage Needed (mg/dose)",
                                      hintText: "0mg/dose",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // mg required output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: mgRequiredT1Text,
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
                                      labelText: "mg Required BID Dosing",
                                      hintText: "0mg",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // NUmber of days of treatment input field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                        calcCapsulesToDispenseT1();
                                      });
                                    }),
                              ),

                              // Total number of capsules/tablets/intravenous to dispense
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: capsulesToDispenseT1Text,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 2.0),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.purple, width: 2.0),
                                      ),
                                      labelText: dispenseLabelTextT1,
                                      hintText: dispenseHintTextT1,
                                      labelStyle: const TextStyle(
                                          color: Colors.purple)),
                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),

                  // *** TAB 2 ***
                  SingleChildScrollView(
                      child: Column(children: [
                    //Drug type dropdown
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
                              labelText: "Drug Delivery Method"),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: methodOfAdminT2,
                              onChanged: (newValue) {
                                methodOfAdminT2 = newValue!;
                                setState(() {
                                  handleDrugDeliveryDropDownT2();
                                });
                              },
                              items: methodsOfAdmin.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                    // **SUSPENSION**
                    Visibility(
                        visible: (showSuspensionT2),
                        child: Column(children: [
                          // Body surface area input field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 0),
                            child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Body Surface Area (m²)",
                                  hintText: "Body Surface Area (m²)",
                                ),
                                onChanged: (value) {
                                  final x = double.tryParse(value);
                                  setState(() {
                                    bodySurfaceAreaT2 = x ?? 0;
                                    calcDrugRequiredMgT2();
                                    calcDrugRequiredMlT2();
                                    calcVolumeToDispenseT2();
                                  });
                                }),
                          ),

                          // drug required mg output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextField(
                              controller: drugRequiredMgT2Text,
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
                                  labelText: "Drug Required (mg/dose)",
                                  hintText: "0mg/dose",
                                  labelStyle: TextStyle(color: Colors.purple)),
                            ),
                          ),

                          // drug required ml output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextField(
                              controller: drugRequiredMlT2Text,
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
                                  labelText: "Drug Required (mL/dose)",
                                  hintText: "0mL/dose",
                                  labelStyle: TextStyle(color: Colors.purple)),
                            ),
                          ),

                          // Num doses per day
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextFormField(
                              initialValue: numDosesPerDayT2.toString(),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Number of Doses per Day",
                                hintText: "Number of Doses per Day",
                              ),
                            ),
                          ),

                          // Number of days of treatment input field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 0),
                            child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Number of Days of Treatment",
                                  hintText: "Number of Days of Treatment",
                                ),
                                onChanged: (value) {
                                  final x = int.tryParse(value);
                                  setState(() {
                                    numDaysTreatmentT2 = x ?? 0;
                                    calcVolumeToDispenseT2();
                                  });
                                }),
                          ),

                          // Total volume to dispense output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextField(
                              controller: volumeToDispenseT2Text,
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
                                  hintText: "0mL",
                                  labelStyle: TextStyle(color: Colors.purple)),
                            ),
                          ),
                        ])),

                    // **CAPSULE or TABLET or INTRAVENOUS**
                    Visibility(
                        visible: (showCapsuleT2 ||
                            showTabletT2 ||
                            showIntravenousT2),
                        child: Column(children: [
                          // Body surface area input field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 0),
                            child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Body Surface Area (m²)",
                                  hintText: "Body Surface Area (m²)",
                                ),
                                onChanged: (value) {
                                  final x = double.tryParse(value);
                                  setState(() {
                                    bodySurfaceAreaT2 = x ?? 0;
                                    calcDrugRequiredMgT2();
                                    calcUnitPerDoseT2();
                                    calcUnitToDispenseT2();
                                  });
                                }),
                          ),

                          // drug required mg output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextField(
                              controller: drugRequiredMgT2Text,
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
                                  labelText: "Drug Required (mg/dose)",
                                  hintText: "0mg/dose",
                                  labelStyle: TextStyle(color: Colors.purple)),
                            ),
                          ),

                          // unit per dose output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextField(
                              controller: unitPerDoseT2Text,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                  ),
                                  labelText: unitPerDoseLabelTextT2,
                                  hintText: unitPerDoseHintTextT2,
                                  labelStyle:
                                      const TextStyle(color: Colors.purple)),
                            ),
                          ),
                          // Num doses per day
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 0),
                            child: TextFormField(
                              initialValue: numDosesPerDayT2.toString(),
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Number of Doses per Day",
                                hintText: "Number of Doses per Day",
                              ),
                            ),
                          ),
                          // number of days of treatment input field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 0),
                            child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: false),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Number of Days of Treatment",
                                  hintText: "Number of Days of Treatment",
                                ),
                                onChanged: (value) {
                                  final x = int.tryParse(value);
                                  setState(() {
                                    numDaysTreatmentT2 = x ?? 0;
                                    calcUnitToDispenseT2();
                                  });
                                }),
                          ),
                          // unit to dispense output field
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 60),
                            child: TextField(
                              controller: unitToDispenseT2Text,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.purple, width: 2.0),
                                  ),
                                  labelText: unitPerDoseLabelTextT2,
                                  hintText: unitPerDoseHintTextT2,
                                  labelStyle:
                                      const TextStyle(color: Colors.purple)),
                            ),
                          ),
                        ]))
                  ]))
                ]))));
  }
}
