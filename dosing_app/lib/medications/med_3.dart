import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med3 extends StatefulWidget {
  Med3(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med3State createState() => _Med3State();
}

class _Med3State extends State<Med3> {
  TextEditingController concentrationNeededT1Text = TextEditingController();
  TextEditingController totalDoseNeededMgT1Text = TextEditingController();
  TextEditingController totalDoseNeededMlT1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

  double concentrationNeededT1 = 0;
  double childWeightT1 = 0;
  double totalDoseNeededMgT1 = 0;
  double totalDoseNeededMlT1 = 0;
  double drugConcentrationT1 = 0;
  double dosesPerDayT1 = 0;
  double drugRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  double volumeToDispenseT1 = 0;
  double numDaysTreatment = 0;
  double numMg = 0;
  int numTabsNeeded = 0;

  List<int> mgPerTabletItems = [10, 25];
  int mgPerTablet = 10;

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
    totalDoseNeededMlT1 = totalDoseNeededMgT1 / drugConcentrationT1;
    if (totalDoseNeededMlT1.isNaN || totalDoseNeededMlT1.isInfinite) {
      totalDoseNeededMlT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      totalDoseNeededMlT1Text.text =
          (totalDoseNeededMlT1).toStringAsFixed(2) + "mL";
    }
  }

  void calcDrugRequiredT1() {
    drugRequiredT1 = totalDoseNeededMlT1 / dosesPerDayT1;
    if (drugRequiredT1.isNaN || drugRequiredT1.isInfinite) {
      drugRequiredT1Text.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredT1Text.text = (drugRequiredT1).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispenseT1() {
    volumeToDispenseT1 = drugRequiredT1 * numDaysTreatmentT1;
    volumeToDispenseT1Text.text =
        (volumeToDispenseT1).toStringAsFixed(2) + "mL";
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
                                  totalDoseNeededMgT1 =
                                      concentrationNeededT1 * childWeightT1;
                                  totalDoseNeededMgT1Text.text =
                                      (totalDoseNeededMgT1).toStringAsFixed(2) +
                                          "mg/dose"; // handle null and String

                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
                                  calcVolumeToDispenseT1();
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
                                  childWeightT1 =
                                      x ?? 0; // handle null and String
                                  totalDoseNeededMgT1 =
                                      concentrationNeededT1 * childWeightT1;
                                  totalDoseNeededMgT1Text.text =
                                      (totalDoseNeededMgT1).toStringAsFixed(2) +
                                          "mg/dose"; // handle null and String

                                  calcDosageNeededMlT1();
                                  calcDrugRequiredT1();
                                  calcVolumeToDispenseT1();
                                });
                              }),
                        ),

                        // Total dosage needed output field
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
                                labelText: "Total Dosage Needed (mg/dose)",
                                hintText: "0mg/dose",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Drug concentration
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Drug Concentration (mg/ml)",
                                hintText: "Drug Concentration (mg/ml)",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  drugConcentrationT1 = x ?? 0;
                                  totalDoseNeededMlT1 =
                                      totalDoseNeededMgT1 / drugConcentrationT1;
                                  if (totalDoseNeededMlT1.isNaN ||
                                      totalDoseNeededMlT1.isInfinite) {
                                    totalDoseNeededMlT1Text.text =
                                        (0).toStringAsFixed(2) + "mL";
                                  } else {
                                    totalDoseNeededMlT1Text.text =
                                        (totalDoseNeededMlT1)
                                                .toStringAsFixed(2) +
                                            "mL";
                                  }
                                  calcDrugRequiredT1();
                                  calcVolumeToDispenseT1();
                                });
                              }),
                        ),

                        // Total dosage needed (ml) output field
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
                                labelText: "Total Dosage Needed (mL)",
                                hintText: "0mL",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Number of doses per day
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
                                hintText: "Doses per day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  dosesPerDayT1 = x ?? 0;
                                  drugRequiredT1 =
                                      totalDoseNeededMlT1 / dosesPerDayT1;
                                  if (drugRequiredT1.isNaN ||
                                      drugRequiredT1.isInfinite) {
                                    drugRequiredT1Text.text =
                                        (0).toStringAsFixed(2) + "mL/dose";
                                  } else {
                                    drugRequiredT1Text.text =
                                        (drugRequiredT1).toStringAsFixed(2) +
                                            "mL/dose";
                                  } // handle null and String

                                  calcVolumeToDispenseT1();
                                });
                              }),
                        ),

                        // Drug required
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
                                  volumeToDispenseT1 =
                                      drugRequiredT1 * numDaysTreatmentT1;
                                  volumeToDispenseT1Text.text =
                                      (volumeToDispenseT1).toStringAsFixed(2) +
                                          "mL"; // handle null and String
                                });
                              }),
                        ),

                        // Total volume to dispense
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
                                labelText: "Total Volume to Dispense (mL/dose)",
                                hintText: "0mL",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )),

                    // *** TAB 2 ***
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            // focusNode: myFocusNode,
                            // controller: concentrationNeededText,
                            readOnly: true,
                            decoration: InputDecoration(
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
