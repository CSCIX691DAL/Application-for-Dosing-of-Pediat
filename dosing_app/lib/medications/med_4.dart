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
  //Tab 1 Text Controllers
  TextEditingController totalDoseInjText = TextEditingController();
  TextEditingController mgPerTreatmentInjText = TextEditingController();
  TextEditingController mgTotalInjText = TextEditingController();
  TextEditingController mLNeededInjText = TextEditingController();

  //Tab 2 Text Controller
  TextEditingController totalDoseOralText = TextEditingController();
  TextEditingController mgPerTreatmentOralText = TextEditingController();
  TextEditingController mgTotalOralText = TextEditingController();
  TextEditingController tabletsNeededOralText = TextEditingController();

  //Tab 3 Text Controller
  TextEditingController totalDoseInfText = TextEditingController();
  TextEditingController mgPerTreatmentInfText = TextEditingController();
  TextEditingController mgTotalInfText = TextEditingController();
  TextEditingController mLNeededInfText = TextEditingController();

  //Tab 1 variables
  double concentrationInj = 0;
  double childWeightInj = 0;
  double totalDoseInj = 0;
  int numDosesInj = 0;
  double mgPerTreatmentInj = 0;
  int treatmentDaysInj = 0;
  double mgTotalInj = 0;
  final int mgPermLInj = 10;
  double mLNeededInj = 0;

  //Tab 2 variables
  double concentrationOral = 0;
  double childWeightOral = 0;
  double totalDoseOral = 0;
  int numDosesOral = 0;
  double mgPerTreatmentOral = 0;
  int treatmentDaysOral = 0;
  double mgTotalOral = 0;
  final int mgPerTabletOral = 50;
  double tabletsNeededOral = 0;

  //Tab 3 variables
  double concentrationInf = 0;
  double childWeightInf = 0;
  double totalDoseInf = 0;
  int numDosesInf = 0;
  double mgPerTreatmentInf = 0;
  int treatmentDaysInf = 0;
  double mgTotalInf = 0;
  final int mgPermLInf = 10;
  double mlNeededInf = 0;

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
    totalDoseInj = concentrationInj * childWeightInj;
    totalDoseInjText.text = (totalDoseInj).toStringAsFixed(2) + " mg";
  }

  void calcMgPerTreamentInj() {
    mgPerTreatmentInj = totalDoseInj / numDosesInj;
    if (mgPerTreatmentInj.isNaN || mgPerTreatmentInj.isInfinite) {
      mgPerTreatmentInjText.text = "0 mg/dose";
    } else {
      mgPerTreatmentInjText.text =
          (mgPerTreatmentInj).toStringAsFixed(2) + " mg/dose";
    }
  }

  void calcMgTotalInj() {
    mgTotalInj = totalDoseInj * treatmentDaysInj;
    mgTotalInjText.text = (mgTotalInj).toStringAsFixed(2) + " mg";
  }

  void calcMlTotalInj() {
    mLNeededInj = mgTotalInj / mgPermLInj;
    if (mLNeededInj.isNaN || mLNeededInj.isInfinite) {
      mLNeededInjText.text = "0 mL";
    } else {
      mLNeededInjText.text = (mLNeededInj).toStringAsFixed(2) + " mL";
    }
  }

  void calcTotalDoseOral() {
    totalDoseOral = concentrationOral * childWeightOral;
    totalDoseOralText.text = (totalDoseOral).toStringAsFixed(2) + " mg";
  }

  void calcMgPerTreatmentOral() {
    mgPerTreatmentOral = totalDoseOral / numDosesOral;
    if (mgPerTreatmentOral.isNaN || mgPerTreatmentOral.isInfinite) {
      mgPerTreatmentOralText.text = "0 mg";
    } else {
      mgPerTreatmentOralText.text =
          (mgPerTreatmentOral).toStringAsFixed(2) + " mg";
    }
  }

  void calcMgTotalOral() {
    mgTotalOral = treatmentDaysOral * totalDoseOral;
    mgTotalOralText.text = (mgTotalOral).toStringAsFixed(2) + " mg";
  }

  void calcTabletsOral() {
    tabletsNeededOral = mgTotalOral / mgPerTabletOral;
    if (tabletsNeededOral.isNaN || tabletsNeededOral.isInfinite) {
      tabletsNeededOralText.text = "0 Tablets";
    } else {
      tabletsNeededOralText.text =
          (tabletsNeededOral).toStringAsFixed(1) + " Tablets";
    }
  }

  void calcTotalDoseInf() {
    totalDoseInf = concentrationInf * childWeightInf;
    totalDoseInfText.text = (totalDoseInf).toStringAsFixed(2) + " mg";
  }

  void calcMgPerTreatmentInf() {
    mgPerTreatmentInf = totalDoseInf / numDosesInf;
    if (mgPerTreatmentInf.isNaN || mgPerTreatmentInf.isInfinite) {
      mgPerTreatmentInfText.text = "0 mg";
    } else {
      mgPerTreatmentInfText.text =
          (mgPerTreatmentInf).toStringAsFixed(2) + " mg";
    }
  }

  void calcMgTotalInf() {
    mgTotalInf = totalDoseInf * treatmentDaysInf;
    mgTotalInfText.text = (mgTotalInf).toStringAsFixed(2) + " mg";
  }

  void calcMlTotalInf() {
    mlNeededInf = mgTotalInf / mgPermLInf;
    if (mlNeededInf.isNaN || mlNeededInf.isInfinite) {
      mLNeededInfText.text = "0 mL";
    } else {
      mLNeededInfText.text = (mlNeededInf).toStringAsFixed(2) + " mL";
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
            length: 3,
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
                      Tab(text: "Subcutaneous Injection"),
                      Tab(text: "Oral"),
                      Tab(text: "Infusion"),
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
                                  concentrationInj = x ?? 0;
                                  totalDoseInj =
                                      concentrationInj * childWeightInj;
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
                                      concentrationInj * childWeightInj;
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
                                        (mgPerTreatmentInj).toStringAsFixed(2) +
                                            "mg";
                                  }
                                  calcMgPerTreamentInj();
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
                                  mgTotalInj = totalDoseInj * treatmentDaysInj;

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

                    // *** ORAL TAB ***
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
                                labelText: "Concentration Needed (mg/kg/day)",
                                hintText: "0 mg/kg/day",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  concentrationOral = x ?? 0;
                                  calcTotalDoseOral();
                                  calcMgPerTreatmentOral();
                                  calcMgTotalOral();
                                  calcTabletsOral();
                                });
                              }),
                        ),

                        //Child's Weight Input
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
                                labelText: "Child's Weight (kg)",
                                hintText: "0 kg",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  childWeightOral = x ?? 0;
                                  calcTotalDoseOral();
                                  calcMgPerTreatmentOral();
                                  calcMgTotalOral();
                                  calcTabletsOral();
                                });
                              }),
                        ),

                        // Total Dose Output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: totalDoseOralText,
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
                                labelText: "Total Dose Needed (mg)",
                                hintText: "0 mg",
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
                                labelText: "Number of doses per day",
                                hintText: "0 doses per day",
                              ),
                              onChanged: (value) {
                                final x = int.tryParse(value);
                                setState(() {
                                  numDosesOral = x ?? 0;
                                  calcMgPerTreatmentOral();
                                });
                              }),
                        ),

                        // Mg per Treatment Output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgPerTreatmentOralText,
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
                                labelText: "Dose per Treatment (mg/treatment)",
                                hintText: "0 mg/treatment",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Treatment Days
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
                                labelText: "Number of days of treatment",
                                hintText: "0 days",
                              ),
                              onChanged: (value) {
                                final x = int.tryParse(value);
                                setState(() {
                                  treatmentDaysOral = x ?? 0;
                                  calcMgTotalOral();
                                  calcTabletsOral();
                                });
                              }),
                        ),

                        // Mg Total Output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgTotalOralText,
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
                                labelText: "Mg Total",
                                hintText: "0 mg",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),

                        // Tablets total output
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: tabletsNeededOralText,
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
                                labelText: "Tablets Needed Total",
                                hintText: "0 tablets",
                                labelStyle: TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )),

                    // *** INFUSION TAB ***
                    SingleChildScrollView(
                        child: Column(
                      children: [
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
                                  concentrationInf = x ?? 0;
                                  totalDoseInf =
                                      concentrationInf * childWeightInf;
                                  totalDoseInfText.text =
                                      (totalDoseInf).toStringAsFixed(2) +
                                          "mg"; // handle null and String

                                  calcTotalDoseInf();
                                  calcMgPerTreatmentInf();
                                  calcMgTotalInf();
                                  calcMlTotalInf();
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
                                  childWeightInf =
                                      x ?? 0; // handle null and String
                                  totalDoseInf =
                                      concentrationInf * childWeightInf;
                                  totalDoseInfText.text =
                                      (totalDoseInf).toStringAsFixed(2) +
                                          "mg"; // handle null and String

                                  calcTotalDoseInf();
                                  calcMgPerTreatmentInf();
                                  calcMgTotalInf();
                                  calcMlTotalInf();
                                });
                              }),
                        ),

                        // Total dosage needed output field
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: totalDoseInfText,
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
                                  numDosesInf = x ?? 0;
                                  mgPerTreatmentInf =
                                      totalDoseInf / numDosesInf;
                                  if (mgPerTreatmentInf.isNaN ||
                                      mgPerTreatmentInf.isInfinite) {
                                    mgPerTreatmentInfText.text =
                                        (0).toStringAsFixed(2) + " mg";
                                  } else {
                                    mgPerTreatmentInfText.text =
                                        (mgPerTreatmentInf).toStringAsFixed(2) +
                                            " mg";
                                  }
                                  calcMgPerTreatmentInf();
                                });
                              }),
                        ),

                        // Mg Per Treatment Output Field
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgPerTreatmentInfText,
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
                                  treatmentDaysInf = x ?? 0;
                                  mgTotalInf = totalDoseInf * treatmentDaysInf;

                                  mgTotalInfText.text =
                                      (mgTotalInf).toStringAsFixed(2) +
                                          "mg total";
                                  // handle null and String

                                  calcMgTotalInf();
                                  calcMlTotalInf();
                                });
                              }),
                        ),

                        // mg Total
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            controller: mgTotalInfText,
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
                            controller: mLNeededInfText,
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
