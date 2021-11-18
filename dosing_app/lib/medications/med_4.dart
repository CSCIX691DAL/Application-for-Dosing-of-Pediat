import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med4 extends StatefulWidget {
  Med4(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med4State createState() => _Med4State();
}

class _Med4State extends State<Med4> {
  TextEditingController totalDoseInjText = TextEditingController();
  TextEditingController mgPerTreatmentInjText = TextEditingController();
  TextEditingController mgTotalInjText = TextEditingController();
  TextEditingController mLNeededInjText = TextEditingController();

  TextEditingController drugRequiredT2Text = TextEditingController();
  TextEditingController volumeToDispenseT2Text = TextEditingController();

  double concentrationNeededInj = 0;
  double childWeightInj = 0;
  double totalDoseInj = 0;
  int numDosesInj = 0;
  double mgPerTreatmentInj = 0;
  int treatmentDaysInj = 0;
  double mgTotalInj = 0;
  final int mgPermLInj = 10;
  double mLNeededInj = 0;

  double concentrationNeededT2 = 0;
  double drugRequiredT2 = 0;
  double dosesPerDayT2 = 0;
  int numDaysTreatmentT2 = 0;
  double volumeToDispenseT2 = 0;

  List<int> drugConcentrationT2Items = [125, 250];
  int drugConcentrationT2 = 125;

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

  void calcDosageNeededInj() {
    totalDoseInj = concentrationNeededInj * childWeightInj;
    totalDoseInjText.text =
        (totalDoseInj).toStringAsFixed(2) + "mg";
  }

  void calcMgPerTreamentInj() {
     mgPerTreatmentInj = totalDoseInj / numDosesInj;
    if (mgPerTreatmentInj.isNaN || mgPerTreatmentInj.isInfinite) {
      mgPerTreatmentInjText.text = "0 mg/dose";
    } else {
      mgPerTreatmentInjText.text =
          (mgPerTreatmentInj).toStringAsFixed(2) + "mg/dose";
    }
  }

  void calcMgTotalInj() {
    mgTotalInj = totalDoseInj * treatmentDaysInj;
    mgTotalInjText.text = (mgTotalInj).toStringAsFixed(2) + "mg";
  }

  void calcMlTotalInj() {
    mLNeededInj = mgTotalInj / mgPermLInj;
    if (mLNeededInj.isNaN || mLNeededInj.isInfinite) {
      mLNeededInjText.text = "0 mL";
    } else {
      mLNeededInjText.text =
      (mLNeededInj).toStringAsFixed(2) + "mL";
    }
  }

  void calcDrugRequiredT2() {
    drugRequiredT2 = concentrationNeededT2 / (drugConcentrationT2 / 5);

    if (drugRequiredT2.isNaN || drugRequiredT2.isInfinite) {
      drugRequiredT2Text.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredT2Text.text = (drugRequiredT2).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispenseT2() {
    volumeToDispenseT2 = dosesPerDayT2 * numDaysTreatmentT2;
    volumeToDispenseT2Text.text =
        (volumeToDispenseT2).toStringAsFixed(2) + "mL";
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
                  title: Text("Azathioprine"),
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
                      Tab(text: "Subcutaneous Injection"),
                      Tab(text: "Oral"),
                    ],
                  ),
                ), //page background color

                body: TabBarView(
                  children: [
                    // *** INJECTION TAB ***
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
                                      concentrationNeededInj = x ?? 0;
                                      totalDoseInj =
                                          concentrationNeededInj * childWeightInj;
                                      totalDoseInjText.text =
                                          (totalDoseInj).toStringAsFixed(2) +
                                              "mg"; // handle null and String

                                      calcDosageNeededInj();
                                      calcMgPerTreamentInj();
                                      calcMgTotalInj();
                                      calcMlTotalInj();
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
                                      childWeightInj =
                                          x ?? 0; // handle null and String
                                      totalDoseInj =
                                          concentrationNeededInj * childWeightInj;
                                      totalDoseInjText.text =
                                          (totalDoseInj).toStringAsFixed(2) +
                                              "mg"; // handle null and String

                                      calcDosageNeededInj();
                                      calcMgPerTreamentInj();
                                      calcMgTotalInj();
                                      calcMlTotalInj();
                                    });
                                  }),
                            ),

                            // Total dosage needed output field
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller: totalDoseInjText,
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
                                    labelText: "Total Dosage Needed (mg)",
                                    hintText: "0mg",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),

                            // Number of doses
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                  keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Number of Doses",
                                    hintText: "Number of Doses",
                                  ),
                                  onChanged: (value) {
                                    final x = int.tryParse(value);
                                    setState(() {
                                      numDosesInj = x ?? 0;
                                      mgPerTreatmentInj =
                                          totalDoseInj / numDosesInj;
                                      if (mgPerTreatmentInj.isNaN ||
                                          mgPerTreatmentInj.isInfinite) {
                                        mgPerTreatmentInjText.text =
                                            (0).toStringAsFixed(2) + "mg";
                                      } else {
                                        mgPerTreatmentInjText.text =
                                            (mgPerTreatmentInj)
                                                .toStringAsFixed(2) +
                                                "mg";
                                      }
                                      calcDosageNeededInj();
                                      calcMgPerTreamentInj();
                                      calcMgTotalInj();
                                      calcMlTotalInj();
                                    });
                                  }),
                            ),

                            // Mg Per Treatment Output Field
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller: mgPerTreatmentInjText,
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
                                    labelText: "#mg/Treatment",
                                    hintText: "0mg",
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
                                      decimal: true),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Days of treatment",
                                    hintText: "Days of treatment",
                                  ),
                                  onChanged: (value) {
                                    final x = int.tryParse(value);
                                    setState(() {
                                      treatmentDaysInj = x ?? 0;
                                      mgTotalInj =
                                          totalDoseInj * treatmentDaysInj;

                                        mgTotalInjText.text =
                                            (mgTotalInj).toStringAsFixed(2) +
                                                "mg total";
                                       // handle null and String

                                      calcMgTotalInj();
                                      calcMlTotalInj();
                                    });
                                  }),
                            ),

                            // mg Total
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller: mgTotalInjText,
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
                                    labelText: "mg Total",
                                    hintText: "0mg",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),

                            //mL total
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 60),
                              child: TextField(
                                controller: mLNeededInjText,
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
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
                                      concentrationNeededT2 = x ?? 0;
                                      calcDrugRequiredT2();
                                      calcVolumeToDispenseT2();
                                    });
                                  }),
                            ),

                            //Drug concentration dropdown
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
                                      labelText: "Drug Concentration mg/mL"),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      // hint: Text('Please choose a location'),
                                      isExpanded: true,
                                      value: drugConcentrationT2,
                                      onChanged: (newValue) {
                                        setState(() {
                                          drugConcentrationT2 = newValue!;
                                          calcDrugRequiredT2();
                                          calcVolumeToDispenseT2();
                                        });
                                      },
                                      items: drugConcentrationT2Items.map((value) {
                                        return DropdownMenuItem(
                                          child: Text(value.toString() + "mg/5ml"),
                                          value: value,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                )),

                            // Drug required output
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
                                    labelText: "Drug Required (mL/dose)",
                                    hintText: "0mL/dose",
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
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.indigo, width: 2.0),
                                    ),
                                    labelText: "Number of doses per day",
                                    hintText: "0 doses per day",
                                  ),
                                  onChanged: (value) {
                                    final x = double.tryParse(value);
                                    setState(() {
                                      dosesPerDayT2 = x ?? 0;
                                      calcVolumeToDispenseT2();
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
                                      calcVolumeToDispenseT2();
                                    });
                                  }),
                            ),

                            // Volume to dispense
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
                          ],
                        )),
                  ],
                ))));
  }
}
