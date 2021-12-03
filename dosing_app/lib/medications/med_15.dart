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

class _Med15State extends State<Med15> {
  TextEditingController totalDoseNeededMgT1Text = TextEditingController();
  TextEditingController totalDoseNeededMlT1Text = TextEditingController();
  TextEditingController dosesPerDayT1Text = TextEditingController();
  TextEditingController dosesPerDay2T1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController tabletsToDispenseT1Text = TextEditingController();
  TextEditingController numMgText = TextEditingController();

  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();
  TextEditingController numTabFinal = TextEditingController();

  TextEditingController drugRequiredT2Text = TextEditingController();
  TextEditingController dosesPerDayT2Text = TextEditingController();
  TextEditingController dosesPerDay2T2Text = TextEditingController();
  TextEditingController tabletsToDispenseT2Text = TextEditingController();
  TextEditingController numTabsNeededT2Text = TextEditingController();

  int numTabsNeeded = 0;
  int numTabsNeededT2 = 0;

  double drugRequiredNeeded = 0;

  double numMg = 0;
  double totalDoseNeeded = 0;

  double concentrationNeededT1 = 0;
  double childWeightT1 = 0;
  double totalDoseNeededMgT1 = 0;
  double totalDoseNeededMlT1 = 0;
  double drugConcentrationT1 = 0;
  double dosesPerDayT1 = 0;
  double dosesPerDay2T1 = 0;
  double drugRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  double tabletsToDispenseT1 = 0;

  double concentrationNeededT2 = 0;
  double drugRequiredT2 = 0;
  double dosesPerDayT2 = 0;
  double dosesPerDay2T2 = 0;
  int numDaysTreatmentT2 = 0;
  double tabletsToDispenseT2 = 0;

  double numDaysTreatment = 0;

  List<int> mgPerTabletT2Items = [1, 5];
  int mgPerTabletT2 = 1;

  List<int> mgPerTabletItems = [1, 5];
  int mgPerTablet = 1;

  int numTab = 1;

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

  void calcDosageNeededMgT1() {
    totalDoseNeededMgT1 = concentrationNeededT1 * childWeightT1;
    totalDoseNeededMgT1Text.text =
        (totalDoseNeededMgT1).toStringAsFixed(2) + "mg/dose";
  }

  void calcDosageNeededMlT1() {
    totalDoseNeededMlT1 = dosesPerDayT1 / totalDoseNeededMgT1;
    if (totalDoseNeededMlT1.isNaN || totalDoseNeededMlT1.isInfinite) {
      totalDoseNeededMlT1Text.text = (0).toStringAsFixed(2) + "mg";
    } else {
      totalDoseNeededMlT1Text.text =
          (totalDoseNeededMlT1).toStringAsFixed(2) + "mg";
    }
  }

  void calcDrugRequiredT1() {
    drugRequiredT1 = dosesPerDayT1 / totalDoseNeededMlT1;
    if (drugRequiredT1.isNaN || drugRequiredT1.isInfinite) {
      drugRequiredT1Text.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      drugRequiredT1Text.text = (drugRequiredT1).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcTabletsToDispenseT1() {
    tabletsToDispenseT1 = dosesPerDay2T1 * numDaysTreatmentT1 * numTabsNeeded;
    tabletsToDispenseT1Text.text =
        (tabletsToDispenseT1).toStringAsFixed(2) + "mg";
  }

  void calcDrugRequiredT2() {
    drugRequiredT2 = dosesPerDayT2 / concentrationNeededT2;

    if (drugRequiredT2.isNaN || drugRequiredT2.isInfinite) {
      drugRequiredT2Text.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      drugRequiredT2Text.text = (drugRequiredT2).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcTabletsToDispenseT2() {
    tabletsToDispenseT2 = numTabsNeededT2 * dosesPerDay2T2 * numDaysTreatmentT2;
    tabletsToDispenseT2Text.text =
        (tabletsToDispenseT2).toStringAsFixed(2) + "mg";
  }

  void calcNumTabsNeeded() {
    numTabsNeeded = (mgPerTablet / totalDoseNeededMlT1).ceil();
    if (numTabsNeeded.isNaN || numTabsNeeded.isInfinite) {
      numTabsNeededText.text = (0).toString() + " tablets/dose";
    } else {
      numTabsNeededText.text = (numTabsNeeded).toString() + " tablets/dose";
    }
  }

  void calcNumTabsNeededT2() {
    numTabsNeededT2 = (mgPerTabletT2 / drugRequiredT2).ceil();
    if (numTabsNeededT2.isNaN || numTabsNeededT2.isInfinite) {
      numTabsNeededT2Text.text = (0).toString() + " tablets/dose";
    } else {
      numTabsNeededT2Text.text = (numTabsNeededT2).toString() + " tablets/dose";
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
                      Tab(text: "mg/dose"),
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
                                  calcDosageNeededMgT1();
                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
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
                                  calcDosageNeededMgT1();
                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

                        // Total Dosage Needed
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: totalDoseNeededMgT1Text,
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
                                labelText: "Total Dosage Needed (mg/day)",
                                hintText: "0mg/day",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Doses per day
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Doses per day",
                                hintText: "0 doses per day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  dosesPerDayT1 = x ?? 0;
                                  calcDosageNeededMgT1();
                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
                                  calcTabletsToDispenseT1();
                                });
                              }),
                        ),

                        // Drug required (mg/dose)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: totalDoseNeededMlT1Text,
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
                        // # of mg per Tablet
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
                                  labelText: "Number of mg/tablet"),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  // hint: Text('Please choose a location'),
                                  isExpanded: true,
                                  value: mgPerTablet,
                                  onChanged: (newValue) {
                                    setState(() {
                                      mgPerTablet = newValue!;
                                      calcNumTabsNeeded();
                                    });
                                  },
                                  items: mgPerTabletItems.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value.toString() + "mg"),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),
                        // Number of tablets per dose
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: numTabsNeededText,
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
                              labelText: "Number of Tablets per dose",
                              hintText: '0 tablets/dose',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ),

                        // # of Doses per Day
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Doses per day",
                                hintText: "0 doses per day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  dosesPerDay2T1 = x ?? 0;
                                  calcDosageNeededMgT1();
                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
                                  calcTabletsToDispenseT1();
                                  calcNumTabsNeeded();
                                });
                              }),
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

                        // Total # of tablets to dispense
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
                        // Concentration needed (mg/day)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
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
                                labelText: "Concentration Needed (mg/day)",
                                hintText: "0mg/day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  concentrationNeededT2 = x ?? 0;
                                  calcDrugRequiredT2();
                                  calcTabletsToDispenseT2();
                                  calcNumTabsNeededT2();
                                });
                              }),
                        ),
                        // # of Doses per day
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Doses per day",
                                hintText: "0 doses per day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  dosesPerDayT2 = x ?? 0;
                                  calcDrugRequiredT2();
                                  calcTabletsToDispenseT2();
                                  calcNumTabsNeededT2();
                                });
                              }),
                        ),
                        // Drug required (mg/dose)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: drugRequiredT2Text,
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

                        //# of mg per Tablet
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
                                  labelText: "Number of mg/Tablet"),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  // hint: Text('Please choose a location'),
                                  isExpanded: true,
                                  value: mgPerTabletT2,
                                  onChanged: (newValue) {
                                    setState(() {
                                      mgPerTabletT2 = newValue!;
                                      calcNumTabsNeededT2();
                                    });
                                  },
                                  items: mgPerTabletT2Items.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value.toString() + "mg"),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),

                        // # of Tablets per dose
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: numTabsNeededT2Text,
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
                                labelText: "Number of Tablets per dose",
                                hintText: "0 tablets/dose",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),
                        // Doses per Day
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Doses per day",
                                hintText: "0 doses per day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  dosesPerDay2T2 = x ?? 0;
                                  calcDrugRequiredT2();
                                  calcTabletsToDispenseT2();
                                  calcNumTabsNeededT2();
                                });
                              }),
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

                        // # of Tablets to dispense
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
                                labelText: "Number of tablets to dispense",
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
