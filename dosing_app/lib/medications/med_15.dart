import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med15 extends StatefulWidget {
  Med15(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med15State createState() => _Med15State();
}

class _Med15State extends State<Med15> with TickerProviderStateMixin {
  TextEditingController drugConcentrationNeededT1Text = TextEditingController();
  TextEditingController dosesPerDayT1Text = TextEditingController();
  TextEditingController mgPerDoseT1Text = TextEditingController();
  TextEditingController numTabletsPerDoseT1Text = TextEditingController();
  TextEditingController tabletsToDispenseT1Text = TextEditingController();

  double concentrationNeededT1 = 0;
  double childWeightT1 = 0;
  double drugConcentrationNeededT1 = 0;
  double drugConcentrationT1 = 0;
  int dosesPerDayT1 = 0;
  double mgPerDoseT1 = 0;
  double mgPerTabletT1 = 0;
  double numTabletsPerDoseT1 = 0;
  int numDaysTreatmentT1 = 0;
  int tabletsToDispenseT1 = 0;

  TextEditingController dosesPerDayT2Text = TextEditingController();
  TextEditingController mgPerDoseT2Text = TextEditingController();
  TextEditingController numTabletsPerDoseT2Text = TextEditingController();
  TextEditingController tabletsToDispenseT2Text = TextEditingController();

  double drugConcentrationNeededT2 = 0;
  double mgPerDoseT2 = 0;
  double mgPerTabletT2 = 0;
  double numTabletsPerDoseT2 = 0;
  int dosesPerDayT2 = 0;
  int numDaysTreatmentT2 = 0;
  int tabletsToDispenseT2 = 0;

  late FocusNode myFocusNode;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  void calcConcentrationNeededT1() {
    drugConcentrationNeededT1 = concentrationNeededT1 * childWeightT1;
    drugConcentrationNeededT1Text.text =
        (drugConcentrationNeededT1).toStringAsFixed(2) + "mg/day";
  }

  void calcMgPerDoseT1() {
    mgPerDoseT1 = dosesPerDayT1 / drugConcentrationNeededT1;
    if (mgPerDoseT1.isNaN || mgPerDoseT1.isInfinite) {
      mgPerDoseT1Text.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      mgPerDoseT1Text.text = (mgPerDoseT1).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcTabletsPerDoseT1() {
    try {
      numTabletsPerDoseT1 = (mgPerTabletT1 / mgPerDoseT1);
      if (numTabletsPerDoseT1.isNaN || numTabletsPerDoseT1.isInfinite) {
        numTabletsPerDoseT1Text.text = (0).toStringAsFixed(2) + " tablets/dose";
      } else {
        numTabletsPerDoseT1Text.text =
            (numTabletsPerDoseT1).toStringAsFixed(2) + " tablets/dose";
      }
    } catch (e) {
      numTabletsPerDoseT1 = 0;
      numTabletsPerDoseT1Text.text = (0).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcTabletsToDispenseT1() {
    try {
      tabletsToDispenseT1 =
          (numTabletsPerDoseT1 * dosesPerDayT1 * numDaysTreatmentT1).ceil();
      if (tabletsToDispenseT1.isNaN || tabletsToDispenseT1.isInfinite) {
        tabletsToDispenseT1Text.text = (0).toStringAsFixed(2) + " tablets";
      } else {
        tabletsToDispenseT1Text.text =
            (tabletsToDispenseT1).toStringAsFixed(2) + " tablets";
      }
    } catch (e) {
      tabletsToDispenseT1 = 0;
      tabletsToDispenseT1Text.text = (0).toString() + " tablets";
    }
  }

  void calcMgPerDoseT2() {
    mgPerDoseT2 = dosesPerDayT2 / drugConcentrationNeededT2;
    if (mgPerDoseT2.isNaN || mgPerDoseT2.isInfinite) {
      mgPerDoseT2Text.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      mgPerDoseT2Text.text = (mgPerDoseT2).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcTabletsPerDoseT2() {
    try {
      numTabletsPerDoseT2 = (mgPerTabletT2 / mgPerDoseT2);
      if (numTabletsPerDoseT2.isNaN || numTabletsPerDoseT2.isInfinite) {
        numTabletsPerDoseT2Text.text = (0).toStringAsFixed(2) + " tablets/dose";
      } else {
        numTabletsPerDoseT2Text.text =
            (numTabletsPerDoseT2).toStringAsFixed(2) + " tablets/dose";
      }
    } catch (e) {
      numTabletsPerDoseT2 = 0;
      numTabletsPerDoseT2Text.text = (0).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcTabletsToDispenseT2() {
    try {
      tabletsToDispenseT2 =
          (numTabletsPerDoseT2 * dosesPerDayT2 * numDaysTreatmentT2).ceil();
      if (tabletsToDispenseT2.isNaN || tabletsToDispenseT2.isInfinite) {
        tabletsToDispenseT2Text.text = (0).toString() + " tablets";
      } else {
        tabletsToDispenseT2Text.text =
            (tabletsToDispenseT2).toString() + " tablets";
      }
    } catch (e) {
      tabletsToDispenseT2 = 0;
      tabletsToDispenseT2Text.text = (0).toString() + " tablets";
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
                      Tab(text: "mg/kg/day"),
                      Tab(text: "mg/day"),
                    ],
                  ),
                ), //page background color

                body: TabBarView(
                  children: [
                    // *** TAB 1 ***
                    SingleChildScrollView(
                        child: Column(
                      children: [
                        // Concentration needed
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Concentration Needed (mg/kg/day)",
                                hintText: "Concentration Needed (mg/kg/day)",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  concentrationNeededT1 = x ?? 0;
                                  calcConcentrationNeededT1();
                                  calcMgPerDoseT1();
                                  calcTabletsPerDoseT1();
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

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
                                  childWeightT1 = x ?? 0;
                                  calcConcentrationNeededT1();
                                  calcMgPerDoseT1();
                                  calcTabletsPerDoseT1();
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

                        // Drug concentration needed (mg/day) output field
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: drugConcentrationNeededT1Text,
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
                                labelText: "Drug Concentration Needed (mg/day)",
                                hintText: "0mg/day",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // doses per day slider output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            focusNode: myFocusNode,
                            controller: dosesPerDayT1Text,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo, width: 2.0),
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
                            value: dosesPerDayT1.toDouble(),
                            min: 0.0,
                            max: 5.0,
                            divisions: 5,
                            label: dosesPerDayT1.toString(),
                            onChanged: (value) {
                              myFocusNode.requestFocus();
                              setState(() {
                                dosesPerDayT1 = value.toInt();
                                if (dosesPerDayT1 == 1) {
                                  dosesPerDayT1Text.text =
                                      (dosesPerDayT1.toString() +
                                          " dose per day");
                                } else {
                                  dosesPerDayT1Text.text =
                                      (dosesPerDayT1.toString() +
                                          " doses per day");
                                }

                                calcMgPerDoseT1();
                                calcTabletsPerDoseT1();
                                calcTabletsToDispenseT1();
                              });
                            },
                          ),
                        ),

                        // Mg per dose
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgPerDoseT1Text,
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
                                labelText: "mg/dose",
                                hintText: "0mg/dose",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Number of mg per tablet
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "mg per Tablet",
                                hintText: "mg per Tablet",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  mgPerTabletT1 = x ?? 0;
                                  calcTabletsPerDoseT1();
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

                        // Tablets per dose output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: numTabletsPerDoseT1Text,
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
                                labelText: "Tablets per Dose",
                                hintText: "0 tablets",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Number of days of treatment
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
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
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

                        // Total volume to dispense
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 60),
                          child: TextField(
                            controller: tabletsToDispenseT1Text,
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
                                labelText: "Tablets to Dispense",
                                hintText: "0 tablets",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )),

                    // *** TAB 2 ***
                    SingleChildScrollView(
                        child: Column(
                      children: [
                        // Concentration needed
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Concentration Needed (mg/day)",
                                hintText: "Concentration Needed (mg/day)",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  drugConcentrationNeededT2 = x ?? 0;
                                  calcMgPerDoseT2();
                                  calcTabletsPerDoseT2();
                                  calcTabletsToDispenseT2();
                                });
                              }),
                        ),

                        // doses per day slider output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            focusNode: myFocusNode,
                            controller: dosesPerDayT2Text,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo, width: 2.0),
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
                            value: dosesPerDayT2.toDouble(),
                            min: 0.0,
                            max: 5.0,
                            divisions: 5,
                            label: dosesPerDayT2.toString(),
                            onChanged: (value) {
                              myFocusNode.requestFocus();
                              setState(() {
                                dosesPerDayT2 = value.toInt();
                                if (dosesPerDayT2 == 1) {
                                  dosesPerDayT2Text.text =
                                      (dosesPerDayT2.toString() +
                                          " dose per day");
                                } else {
                                  dosesPerDayT2Text.text =
                                      (dosesPerDayT2.toString() +
                                          " doses per day");
                                }
                                calcMgPerDoseT2();
                                calcTabletsPerDoseT2();
                                calcTabletsToDispenseT2();
                              });
                            },
                          ),
                        ),

                        // Mg per dose
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgPerDoseT2Text,
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
                                labelText: "mg/dose",
                                hintText: "0mg/dose",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Number of mg per tablet
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "mg per Tablet",
                                hintText: "mg per Tablet",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  mgPerTabletT2 = x ?? 0;
                                  calcTabletsPerDoseT2();
                                  calcTabletsToDispenseT2();
                                });
                              }),
                        ),

                        // Tablets per dose output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: numTabletsPerDoseT2Text,
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
                                labelText: "Tablets per Dose",
                                hintText: "0 tablets",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Number of days of treatment
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.indigo, width: 2.0),
                                ),
                                labelText: "Number of Days of Treatment",
                                hintText: "0 days",
                              ),
                              onChanged: (value) {
                                final x = int.tryParse(value);
                                setState(() {
                                  numDaysTreatmentT2 = x ?? 0;
                                  calcTabletsToDispenseT2();
                                });
                              }),
                        ),

                        // Tablets to dispense
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 60),
                          child: TextField(
                            controller: tabletsToDispenseT2Text,
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
                                labelText: "Number of Tablets to Dispense",
                                hintText: "0 tablets",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )),
                  ],
                ))));
  }
}
