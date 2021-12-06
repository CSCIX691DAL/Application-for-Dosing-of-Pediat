import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med9 extends StatefulWidget {
  Med9(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med9State createState() => _Med9State();
}

class _Med9State extends State<Med9> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController totalPriorDose1Text = TextEditingController();
  TextEditingController totalPriorDose2Text = TextEditingController();
  TextEditingController totalCurrentDoseText = TextEditingController();
  TextEditingController totalCumulativeDoseText = TextEditingController();
  TextEditingController doseNeeded120mgText = TextEditingController();
  TextEditingController doseNeeded150mgText = TextEditingController();
  TextEditingController doseNeeded180mgText = TextEditingController();
  TextEditingController doseRemaining120mgText = TextEditingController();
  TextEditingController doseRemaining150mgText = TextEditingController();
  TextEditingController doseRemaining180mgText = TextEditingController();
  TextEditingController daysRemaining120mgText = TextEditingController();
  TextEditingController daysRemaining150mgText = TextEditingController();
  TextEditingController daysRemaining180mgText = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

  double patientWeight = 0;
  double dosePerDay = 0;
  double durationCurrentDose = 0;
  double totalCurrentDose = 0;
  double priorDosePerDay1 = 0;
  double durationPriorDose1 = 0;
  double totalPriorDose1 = 0;
  double priorDosePerDay2 = 0;
  double durationPriorDose2 = 0;
  double totalPriorDose2 = 0;
  double totalCumulativeDose = 0;
  double doseNeeded120mg = 0;
  double doseNeeded150mg = 0;
  double doseNeeded180mg = 0;
  double doseRemaining120mg = 0;
  double doseRemaining150mg = 0;
  double doseRemaining180mg = 0;
  double daysRemaining120mg = 0;
  double daysRemaining150mg = 0;
  double daysRemaining180mg = 0;
  double numMg = 0;
  int numTabsNeeded = 0;
  double numDaysTreatment = 0;
  List<int> mgPerTabletItems = [10, 25];
  int mgPerTablet = 10;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double concentrationNeeded = 0;

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

  void calcTotalCumulativeDose() {
    totalCumulativeDose = totalCurrentDose + totalPriorDose1 + totalPriorDose2;
    totalCumulativeDoseText.text =
        (totalCumulativeDose).toStringAsFixed(2) + "mg";
  }

  void calcDoseNeeded120mg() {
    doseNeeded120mg = patientWeight * 120;
    doseNeeded120mgText.text = (doseNeeded120mg).toStringAsFixed(2) + "mg";
  }

  void calcDoseNeeded150mg() {
    doseNeeded150mg = patientWeight * 150;
    doseNeeded150mgText.text = (doseNeeded150mg).toStringAsFixed(2) + "mg";
  }

  void calcDoseNeeded180mg() {
    doseNeeded180mg = patientWeight * 180;
    doseNeeded180mgText.text = (doseNeeded180mg).toStringAsFixed(2) + "mg";
  }

  void calcDoseRemaining120mg() {
    doseRemaining120mg = doseNeeded120mg - totalCumulativeDose;
    if(doseRemaining120mg < 0){
      doseRemaining120mg = 0;
    }
    doseRemaining120mgText.text =
        (doseRemaining120mg).toStringAsFixed(2) + "mg";
  }

  void calcDoseRemaining150mg() {
    doseRemaining150mg = doseNeeded150mg - totalCumulativeDose;
    if(doseRemaining150mg < 0){
      doseRemaining150mg = 0;
    }
    doseRemaining150mgText.text =
        (doseRemaining150mg).toStringAsFixed(2) + "mg";
  }

  void calcDoseRemaining180mg() {
    doseRemaining180mg = doseNeeded180mg - totalCumulativeDose;
    if(doseRemaining180mg < 0){
      doseRemaining180mg = 0;
    }
    doseRemaining180mgText.text =
        (doseRemaining180mg).toStringAsFixed(2) + "mg";
  }

  void calcDaysRemaining120mg() {
    daysRemaining120mg = doseRemaining120mg / dosePerDay;
    if(daysRemaining120mg < 0){
      daysRemaining120mg = 0;
    }
    daysRemaining120mgText.text =
        (daysRemaining120mg).toStringAsFixed(0) + " days";
  }

  void calcDaysRemaining150mg() {
    daysRemaining150mg = doseRemaining150mg / dosePerDay;
    if(daysRemaining150mg < 0){
      daysRemaining150mg = 0;
    }
    daysRemaining150mgText.text =
        (daysRemaining150mg).toStringAsFixed(0) + " days";
  }

  void calcDaysRemaining180mg() {
    daysRemaining180mg = doseRemaining180mg / dosePerDay;
    if(daysRemaining180mg < 0){
      daysRemaining180mg = 0;
    }
    daysRemaining180mgText.text =
        (daysRemaining180mg).toStringAsFixed(0) + " days";
  }

  void calcTotalCurrentDose() {
    totalCurrentDose = dosePerDay * durationCurrentDose;
    totalCurrentDoseText.text = (totalCurrentDose).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
  }

  void calcTotalPriorDose1() {
    totalPriorDose1 = priorDosePerDay1 * durationPriorDose1;
    totalPriorDose1Text.text = (totalDoseNeeded).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
  }

  void calcNumMg() {
    numMg = totalDoseNeeded * numDaysTreatment;
    numMgText.text = (numMg).toStringAsFixed(2) + "mg";
  }

  void calcNumTabsNeeded() {
    numTabsNeeded = (numMg / mgPerTablet).ceil();
    if (numTabsNeeded.isNaN || numTabsNeeded.isInfinite) {
      numTabsNeededText.text = (0).toString() + " tablets";
    } else {
      numTabsNeededText.text = (numTabsNeeded).toString() + " tablets";
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
          ),
          backgroundColor: Colors.white, //page background color

          body: SingleChildScrollView(
            child: Column(
              children: [
                // Patient's weight input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Patient's Weight (kg)",
                        hintText: "Patient's Weight (kg)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          patientWeight = x ?? 0; // handle null and String
                          totalDoseNeeded = concentrationNeeded * childWeight;
                          totalDoseNeededText.text =
                              (totalDoseNeeded).toStringAsFixed(2) + "mg/dose";
                          calcDoseNeeded120mg();
                          calcDoseNeeded150mg();
                          calcDoseNeeded180mg();
                        });
                      }),
                ),

                // Current Dose per Day's input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Current Dose per Day (mg)",
                        hintText: "Current Dose per Day (mg)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          dosePerDay = x ?? 0; // handle null and String
                          totalCurrentDose = dosePerDay * durationCurrentDose;
                          totalCurrentDoseText.text =
                              (totalCurrentDose).toStringAsFixed(2) + "mg";
                        });
                      }),
                ),
                //Duration of Current Dose
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Duration of Current Dose (days)",
                        hintText: "Duration of Current Dose (days)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          durationCurrentDose =
                              x ?? 0; // handle null and String
                          totalCurrentDose = dosePerDay * durationCurrentDose;
                          totalCurrentDoseText.text =
                              (totalCurrentDose).toStringAsFixed(2) + "mg";
                        });
                      }),
                ),

                // Total Current Dose output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalCurrentDoseText,
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
                        labelText: "Total Current Dose (mg)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Prior Dose per Day's input field 1
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Prior Dose per Day (mg)",
                        hintText: "Prior Dose per Day (mg)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          priorDosePerDay1 = x ?? 0; // handle null and String
                          totalPriorDose1 =
                              priorDosePerDay1 * durationPriorDose1;
                          totalPriorDose1Text.text =
                              (totalPriorDose1).toStringAsFixed(2) + "mg";
                          calcTotalCumulativeDose();
                        });
                      }),
                ),
                //Duration of Prior Dose Input field 1
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Duration of Prior Dose (days)",
                        hintText: "Duration of Prior Dose (days)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          durationPriorDose1 = x ?? 0; // handle null and String
                          totalPriorDose1 =
                              priorDosePerDay1 * durationPriorDose1;
                          totalPriorDose1Text.text =
                              (totalPriorDose1).toStringAsFixed(2) + "mg";
                          calcTotalCumulativeDose();
                        });
                      }),
                ),

                // Total Prior Dose output field 1
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalPriorDose1Text,
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
                        labelText: "Total Prior Dose (mg)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Prior Dose per Day's input field 2
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Prior Dose per Day (mg) 2",
                        hintText: "Prior Dose per Day (mg) 2",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          priorDosePerDay2 = x ?? 0; // handle null and String
                          totalPriorDose2 =
                              priorDosePerDay2 * durationPriorDose2;
                          totalPriorDose2Text.text =
                              (totalPriorDose2).toStringAsFixed(2) + "mg";
                          calcTotalCumulativeDose();
                        });
                      }),
                ),
                //Duration of Prior Dose Input field 2
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Duration of Prior Dose (days) 2",
                        hintText: "Duration of Prior Dose (days) 2",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          durationPriorDose2 = x ?? 0; // handle null and String
                          totalPriorDose2 =
                              priorDosePerDay2 * durationPriorDose2;
                          totalPriorDose2Text.text =
                              (totalPriorDose2).toStringAsFixed(2) + "mg";

                          calcTotalCumulativeDose();
                          calcDoseRemaining120mg();
                          calcDoseRemaining150mg();
                          calcDoseRemaining180mg();
                          calcDaysRemaining120mg();
                          calcDaysRemaining150mg();
                          calcDaysRemaining180mg();
                        });
                      }),
                ),

                // Total Prior Dose output field 2
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalPriorDose2Text,
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
                        labelText: "Total Prior Dose (mg) 2",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
                //Total Cumulative Dose Output
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalCumulativeDoseText,
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
                        labelText: "Total Cumulative Dose (mg)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Needed for 120 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseNeeded120mgText,
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
                        labelText: "Total Dose Needed for 120mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Needed for 150 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseNeeded150mgText,
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
                        labelText: "Total Dose Needed for 150mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Needed for 180 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseNeeded180mgText,
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
                        labelText: "Total Dose Needed for 180mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Remaining for 120 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseRemaining120mgText,
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
                        labelText: "Total Dose Remaining @ 120mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Remaining for 150 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseRemaining150mgText,
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
                        labelText: "Total Dose Remaining @ 150mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Dose Remaining for 180 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: doseRemaining180mgText,
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
                        labelText: "Total Dose Remaining @ 180mg/kg",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Days Remaining for 120 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: daysRemaining120mgText,
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
                        labelText: "Total Days Remaining @ 120mg/kg",
                        hintText: "0 days",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Days Remaining for 150 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: daysRemaining150mgText,
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
                        labelText: "Total Days Remaining @ 150mg/kg",
                        hintText: "0 days",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                //Days Remaining for 180 mg
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 60),
                  child: TextField(
                    controller: daysRemaining180mgText,
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
                        labelText: "Total Days Remaining @ 180mg/kg",
                        hintText: "0 days",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
