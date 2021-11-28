import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med17 extends StatefulWidget {
  Med17(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med17State createState() => _Med17State();
}

class _Med17State extends State<Med17> {
  TextEditingController concentrationMgT1Text = TextEditingController();
  TextEditingController tabletsPerDoseT1Text = TextEditingController();
  TextEditingController dosesPerDayT1Text = TextEditingController();
  TextEditingController tabletsToDispenseT1Text = TextEditingController();

  TextEditingController tabletsPerDoseT2Text = TextEditingController();
  TextEditingController dosesPerDayT2Text = TextEditingController();
  TextEditingController tabletsToDispenseT2Text = TextEditingController();

  double concentrationMgKgT1 = 0;
  double childWeightT1 = 0;
  double concentrationMgT1 = 0;
  List<int> mgPerTabletT1Items = [500, 1000];
  int mgPerTabletT1 = 500;
  int tabletsPerDoseT1 = 0;
  int tabletsToDispenseT1 = 0;
  int dosesPerDayT1 = 0;
  int numDaysTreatmentT1 = 0;

  double concentrationT2 = 0;
  List<int> mgPerTabletT2Items = [500, 1000];
  int mgPerTabletT2 = 500;
  int tabletsPerDoseT2 = 0;
  int dosesPerDayT2 = 0;
  int numDaysTreatmentT2 = 0;
  int tabletsToDispenseT2 = 0;

  late FocusNode myFocusNode;

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

  void calcConcentrationMgT1() {
    concentrationMgT1 = concentrationMgKgT1 * childWeightT1;
    if (concentrationMgT1.isNaN || concentrationMgT1.isInfinite) {
      concentrationMgT1Text.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      concentrationMgT1Text.text =
          (concentrationMgT1).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcTabletsPerDoseT1() {
    if (concentrationMgT1 == 0) {
      tabletsPerDoseT1 = 0;
      tabletsPerDoseT1Text.text =
          (tabletsPerDoseT1).toStringAsFixed(0) + " tablets";
    } else {
      tabletsPerDoseT1 = (mgPerTabletT1 / concentrationMgT1).ceil();
      if (tabletsPerDoseT1.isNaN || tabletsPerDoseT1.isInfinite) {
        tabletsPerDoseT1Text.text = (0).toStringAsFixed(2) + " tablets";
      } else {
        tabletsPerDoseT1Text.text =
            (tabletsPerDoseT1).toStringAsFixed(0) + " tablets";
      }
    }
  }

  // TODO: rename variables
  void calcTabletsToDispenseT1() {
    tabletsToDispenseT1 = tabletsPerDoseT1 * dosesPerDayT1 * numDaysTreatmentT1;
    if (tabletsToDispenseT1.isNaN || tabletsToDispenseT1.isInfinite) {
      tabletsToDispenseT1Text.text = (0).toStringAsFixed(2) + " tablets";
    } else {
      tabletsToDispenseT1Text.text =
          (tabletsToDispenseT1).toStringAsFixed(0) + " tablets";
    }
  }

  void calcTabletsPerDoseT2() {
    if (concentrationT2 == 0) {
      tabletsPerDoseT2 = 0;
      tabletsPerDoseT2Text.text =
          (tabletsPerDoseT2).toStringAsFixed(0) + " tablets";
    } else {
      tabletsPerDoseT2 = (mgPerTabletT2 / concentrationT2).ceil();
      if (tabletsPerDoseT2.isNaN || tabletsPerDoseT2.isInfinite) {
        tabletsPerDoseT2Text.text = (0).toStringAsFixed(2) + " tablets";
      } else {
        tabletsPerDoseT2Text.text =
            (tabletsPerDoseT2).toStringAsFixed(0) + " tablets";
      }
    }
  }

  void calcTabletsToDispenseT2() {
    tabletsToDispenseT2 = tabletsPerDoseT2 * dosesPerDayT2 * numDaysTreatmentT2;
    if (tabletsToDispenseT2.isNaN || tabletsToDispenseT2.isInfinite) {
      tabletsToDispenseT2Text.text = (0).toStringAsFixed(2) + " tablets";
    } else {
      tabletsToDispenseT2Text.text =
          (tabletsToDispenseT2).toStringAsFixed(0) + " tablets";
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
                      Tab(text: "mg/kg/dose"),
                      Tab(text: "mg/dose"),
                    ],
                  ),
                ), //page background color

                body: TabBarView(children: [
                  // *** TAB 1 ***
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      // Concentration needed
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Concentration Needed (mg/kg/day)",
                              hintText: "Concentration Needed (mg/kg/day)",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationMgKgT1 = x ?? 0;
                                calcConcentrationMgT1();
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
                                childWeightT1 = x ?? 0;
                                calcConcentrationMgT1();
                                calcTabletsPerDoseT1();
                                calcTabletsToDispenseT1();
                              });
                            }),
                      ),

                      // Concentration needed output field
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: concentrationMgT1Text,
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
                              labelText: "DrugConcentrationNeeded (mg/dose)",
                              hintText: "0mg/dose",
                              labelStyle: TextStyle(color: Colors.purple)),
                        ),
                      ),

                      // mg/tablet dropdown
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
                                labelText: "mg/tablet"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                // hint: Text('Please choose a location'),
                                isExpanded: true,
                                value: mgPerTabletT2,
                                onChanged: (newValue) {
                                  setState(() {
                                    mgPerTabletT1 = newValue!;
                                    calcTabletsPerDoseT1();
                                    calcTabletsToDispenseT1();
                                  });
                                },
                                items: mgPerTabletT2Items.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg/tablet"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Tablets per dose output
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: tabletsPerDoseT1Text,
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
                              labelText: "Tablets/dose",
                              hintText: "0 tablets",
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
                              calcTabletsToDispenseT1();
                            });
                          },
                        ),
                      ),

                      // Number of days of treatment
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
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
                              labelText: "Number of Days of Treatment",
                              hintText: "0 days",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT1 = x ?? 0;
                                calcTabletsToDispenseT1();
                              });
                            }),
                      ),

                      // Tablets to dispense
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
                              labelText: "Number of Tablets to Dispense",
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
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
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
                              labelText: "Concentration Needed (mg/dose)",
                              hintText: "0mg/dose",
                            ),
                            onChanged: (value) {
                              final x = double.tryParse(value);
                              setState(() {
                                concentrationT2 = x ?? 0;
                                calcTabletsPerDoseT2();
                                calcTabletsToDispenseT2();
                              });
                            }),
                      ),

                      // mg/tablet dropdown
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
                                labelText: "mg/tablet"),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                // hint: Text('Please choose a location'),
                                isExpanded: true,
                                value: mgPerTabletT2,
                                onChanged: (newValue) {
                                  setState(() {
                                    mgPerTabletT2 = newValue!;
                                    calcTabletsPerDoseT2();
                                    calcTabletsToDispenseT2();
                                  });
                                },
                                items: mgPerTabletT2Items.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value.toString() + "mg/tablet"),
                                    value: value,
                                  );
                                }).toList(),
                              ),
                            ),
                          )),

                      // Tablets per dose output
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                          controller: tabletsPerDoseT2Text,
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
                              labelText: "Tablets/dose",
                              hintText: "o tablets",
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
                              calcTabletsToDispenseT2();
                            });
                          },
                        ),
                      ),

                      // Number of days of treatment
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 0),
                        child: TextField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: false),
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
                              labelText: "Number of Days of Treatment",
                              hintText: "0 days",
                            ),
                            onChanged: (value) {
                              final x = int.tryParse(value);
                              setState(() {
                                numDaysTreatmentT2 = x ?? 0;
                                calcTabletsToDispenseT1();
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
                ]))));
  }
}
