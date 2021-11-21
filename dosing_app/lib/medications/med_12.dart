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
  TextEditingController dosageNeededT1Text = TextEditingController();
  // TextEditingController totalDoseNeededText = TextEditingController();
  // TextEditingController numMgText = TextEditingController();
  // TextEditingController numTabsNeededText = TextEditingController();
  double concentrationNeededMgMDoseT1 = 0;
  double childSurfaceAreaT1 = 0;
  double dosageNeededT1 = 0;

  int dosesPerDay = 0;

  List<String> methodsOfAdmin = [
    "Suspension",
    "Capsul",
    "Tablet",
    "Intravenous"
  ];
  String methodOfAdminT1 = "Suspension";
  bool showSuspensionT1 = true;
  bool showCapsulT1 = false;
  bool showTabletT1 = false;
  bool showIntravenousT1 = false;

  String methodOfAdminT2 = "Suspension";
  bool showSuspensionT2 = true;
  bool showCapsulT2 = false;
  bool showTabletT2 = false;
  bool showIntravenousT2 = false;

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

  //toggling different forms based on dropdown entry for tab 1
  void toggleSuspensionT1() {
    showSuspensionT1 = true;
    showCapsulT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = false;
  }

  void toggleCapsulT1() {
    showSuspensionT1 = false;
    showCapsulT1 = true;
    showTabletT1 = false;
    showIntravenousT1 = false;
  }

  void toggleTabletT1() {
    showSuspensionT1 = false;
    showCapsulT1 = false;
    showTabletT1 = true;
    showIntravenousT1 = false;
  }

  void toggleIntravenousT1() {
    showSuspensionT1 = false;
    showCapsulT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = true;
  }

  void handleDrugDeliveryDropDownT1() {
    if (methodOfAdminT1 == "Suspension") {
      toggleSuspensionT1();
    } else if (methodOfAdminT1 == "Capsul") {
      toggleCapsulT1();
    } else if (methodOfAdminT1 == "Tablet") {
      toggleTabletT1();
    } else if (methodOfAdminT1 == "Intravenous") {
      toggleIntravenousT1();
    }
    resetValuesT1();
  }

  void resetValuesT1() {
    concentrationNeededMgMDoseT1 = 0;
    childSurfaceAreaT1 = 0;
    dosageNeededT1 = 0;
    dosageNeededT1Text.text = '';
  }

  // functions for tab 1
  void calcDosageNeededT1() {
    dosageNeededT1 = concentrationNeededMgMDoseT1 * childSurfaceAreaT1;
    dosageNeededT1Text.text = (dosageNeededT1).toStringAsFixed(2) + "mg/dose";
  }

  //toggling different forms based on dropdown entry for tab 2
  void toggleSuspensionT2() {
    showSuspensionT1 = true;
    showCapsulT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = false;
  }

  void toggleCapsulT2() {
    showSuspensionT1 = false;
    showCapsulT1 = true;
    showTabletT1 = false;
    showIntravenousT1 = false;
  }

  void toggleTabletT2() {
    showSuspensionT1 = false;
    showCapsulT1 = false;
    showTabletT1 = true;
    showIntravenousT1 = false;
  }

  void toggleIntravenousT2() {
    showSuspensionT1 = false;
    showCapsulT1 = false;
    showTabletT1 = false;
    showIntravenousT1 = true;
  }

  void handleDrugDeliveryDropDownT2() {
    if (methodOfAdminT2 == "Suspension") {
      toggleSuspensionT2();
    } else if (methodOfAdminT2 == "Capsul") {
      toggleCapsulT2();
    } else if (methodOfAdminT2 == "Tablet") {
      toggleTabletT1();
    } else if (methodOfAdminT2 == "Intravenous") {
      toggleIntravenousT1();
    }
    resetValuesT2();
  }

  void resetValuesT2() {}

  // dose calculation functions

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
                                      });
                                    }),
                              ),

                              // Child weight
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
                  ]))
                ]))));
  }
}
