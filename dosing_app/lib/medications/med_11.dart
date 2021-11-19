import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med11 extends StatefulWidget {
  Med11(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med11State createState() => _Med11State();
}

class _Med11State extends State<Med11> {
  TextEditingController dosageNeededT1Text = TextEditingController();
  TextEditingController numTabletsT1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();

  TextEditingController dosageNeededMgT2Text = TextEditingController();
  TextEditingController numTabletsT2Text = TextEditingController();
  TextEditingController dosageNeededMlT2Text = TextEditingController();
  TextEditingController volumeToDispenseT2Text = TextEditingController();

  double concentrationNeededT1 = 0;
  double childSurfaceAreaT1 = 0;
  double dosageNeededT1 = 0;
  int numWeeksTreatmentT1 = 0;
  double mgPerTabletT1 = 2.5;
  int numTabletsT1 = 0;
  double concentrationT1 = 0;
  double drugRequiredT1 = 0;
  double volumeToDispenseT1 = 0;

  List<String> drugTypeT1Items = ["Tablet", "Subcutaneous"];
  String drugTypeT1 = "Tablet";
  bool showTabletT1 = true;

  double concentrationNeededT2 = 0;
  double childWeightT2 = 0;
  double dosageNeededMgT2 = 0;
  int numWeeksTreatmentT2 = 0;
  double mgPerTabletT2 = 2.5;
  int numTabletsT2 = 0;
  double concentrationT2 = 0;
  double dosageNeededMlT2 = 0;
  double volumeToDispenseT2 = 0;

  List<String> drugTypeT2Items = ["Tablet", "Subcutaneous"];
  String drugTypeT2 = "Tablet"; // false would show subcutaneous options
  bool showTabletT2 = true;

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

  void resetValues() {
    // Tab 1 values
    concentrationNeededT1 = 0;
    childSurfaceAreaT1 = 0;
    dosageNeededT1 = 0;
    numWeeksTreatmentT1 = 0;
    numTabletsT1 = 0;
    concentrationT1 = 0;
    drugRequiredT1 = 0;
    volumeToDispenseT1 = 0;
    dosageNeededT1Text.text = '';
    numTabletsT1Text.text = '';
    drugRequiredT1Text.text = '';
    volumeToDispenseT1Text.text = '';

    // Tab 2 values
    concentrationNeededT2 = 0;
    childWeightT2 = 0;
    dosageNeededMgT2 = 0;
    numWeeksTreatmentT2 = 0;
    concentrationT2 = 0;
    dosageNeededMlT2 = 0;
    volumeToDispenseT2 = 0;
    dosageNeededMgT2Text.text = '';
    numTabletsT2Text.text = '';
    dosageNeededMlT2Text.text = '';
    volumeToDispenseT2Text.text = '';
  }

  void calcDosageNeededMgT1() {
    dosageNeededT1 = concentrationNeededT1 * childSurfaceAreaT1;
    dosageNeededT1Text.text = (dosageNeededT1).toStringAsFixed(2) + "mg/dose";
  }

  void calcNumTabletsT1() {
    numTabletsT1 =
        (dosageNeededT1 * numWeeksTreatmentT1 / mgPerTabletT1).ceil();
    numTabletsT1Text.text = (numTabletsT1).toString() + " tablets";
  }

  void calcDrugRequiredT1() {
    drugRequiredT1 = dosageNeededT1 / concentrationT1;
    if (drugRequiredT1.isNaN || drugRequiredT1.isInfinite) {
      drugRequiredT1Text.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredT1Text.text = (drugRequiredT1).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispenseT1() {
    volumeToDispenseT1 = drugRequiredT1 * numWeeksTreatmentT1;
    if (volumeToDispenseT1.isNaN || volumeToDispenseT1.isInfinite) {
      volumeToDispenseT1Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT1Text.text =
          (volumeToDispenseT1).toStringAsFixed(2) + "mL";
    }
  }

  void calcDosageNeededMgT2() {
    dosageNeededMgT2 = concentrationNeededT2 * childWeightT2;
    dosageNeededMgT2Text.text =
        (dosageNeededMgT2).toStringAsFixed(2) + "mg/dose";
  }

  void calcNumTabletsT2() {
    numTabletsT2 =
        (dosageNeededMgT2 * numWeeksTreatmentT2 / mgPerTabletT2).ceil();
    numTabletsT2Text.text = (numTabletsT2).toString() + " tablets";
  }

  void calcDosageNeededMlT2() {
    dosageNeededMlT2 = dosageNeededMgT2 / concentrationT2;
    if (dosageNeededMlT2.isNaN || dosageNeededMlT2.isInfinite) {
      dosageNeededMlT2Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      dosageNeededMlT2Text.text = (dosageNeededMlT2).toStringAsFixed(2) + "mL";
    }
  }

  void calcVolumeToDispenseT2() {
    volumeToDispenseT2 = dosageNeededMlT2 * numWeeksTreatmentT2;
    if (volumeToDispenseT2.isNaN || volumeToDispenseT2.isInfinite) {
      volumeToDispenseT2Text.text = (0).toStringAsFixed(2) + "mL";
    } else {
      volumeToDispenseT2Text.text =
          (volumeToDispenseT2).toStringAsFixed(2) + "mL";
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
                      Tab(text: "Surface Area"),
                      Tab(text: "Weight"),
                    ],
                  ),
                ), //page background color

                body: TabBarView(
                  children: [
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
                                  labelText: "Drug Type"),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: drugTypeT1,
                                  onChanged: (newValue) {
                                    drugTypeT1 = newValue!;
                                    setState(() {
                                      if (drugTypeT1 == "Tablet") {
                                        showTabletT1 = true;
                                      } else {
                                        showTabletT1 = false;
                                      }
                                      resetValues();
                                    });
                                  },
                                  items: drugTypeT1Items.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),

                        // **TABLET**
                        Visibility(
                            visible: (showTabletT1),
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
                                        labelText:
                                            "Concentration Needed (mg/m²/week)",
                                        hintText:
                                            "Concentration Needed (mg/m²/week)",
                                      ),
                                      onChanged: (value) {
                                        final x = double.tryParse(value);
                                        setState(() {
                                          concentrationNeededT1 = x ?? 0;
                                          calcDosageNeededMgT1();
                                          calcNumTabletsT1();
                                        });
                                      }),
                                ),

                                // Child's surface area input field
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
                                          calcDosageNeededMgT1();
                                          calcNumTabletsT1();
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

                                // Num weeks of treatment
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 0),
                                  child: TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: false),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            "Number of Weeks of Treatment",
                                        hintText:
                                            "Number of Weeks of Treatment",
                                      ),
                                      onChanged: (value) {
                                        final x = int.tryParse(value);
                                        setState(() {
                                          numWeeksTreatmentT1 = x ?? 0;
                                          calcNumTabletsT1();
                                        });
                                      }),
                                ),

                                // Num mg per tablet
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 0),
                                  child: TextFormField(
                                    initialValue:
                                        mgPerTabletT1.toStringAsFixed(1),
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Number mg's per Tablet",
                                      hintText: "Number mg's per Tablet",
                                    ),
                                  ),
                                ),

                                // Num tablets output field
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 0),
                                  child: TextField(
                                    controller: numTabletsT1Text,
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
                                        labelText: "Total Number of Tablets",
                                        hintText: "0 tablets",
                                        labelStyle:
                                            TextStyle(color: Colors.purple)),
                                  ),
                                ),
                              ],
                            )),

                        // **SUBCUTANEOUS**
                        Visibility(
                            visible: (!showTabletT1),
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
                                        labelText:
                                            "Concentration Needed (mg/m²/week)",
                                        hintText:
                                            "Concentration Needed (mg/m²/week)",
                                      ),
                                      onChanged: (value) {
                                        final x = double.tryParse(value);
                                        setState(() {
                                          concentrationNeededT2 = x ?? 0;
                                          calcDosageNeededMlT2();
                                          calcDrugRequiredT1();
                                          calcVolumeToDispenseT1();
                                        });
                                      }),
                                ),

                                // Child's surface area input field
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
                                          calcDosageNeededMgT1();
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

                                // Concentration input field
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 0),
                                  child: TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Concentration (mg/mL)",
                                        hintText: "Concentration (mg/mL)",
                                      ),
                                      onChanged: (value) {
                                        final x = double.tryParse(value);
                                        setState(() {
                                          concentrationT1 = x ?? 0;
                                          calcDrugRequiredT1();
                                          calcVolumeToDispenseT1();
                                        });
                                      }),
                                ),

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
                                        labelText: "Drug Required (mL/dose)",
                                        hintText: "0mL/dose",
                                        labelStyle:
                                            TextStyle(color: Colors.purple)),
                                  ),
                                ),

                                // Number of weeks of treatment input field
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 0),
                                  child: TextField(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: false),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText:
                                            "Number of Weeks of Treatment",
                                        hintText:
                                            "Number of Weeks of Treatment",
                                      ),
                                      onChanged: (value) {
                                        final x = int.tryParse(value);
                                        setState(() {
                                          numWeeksTreatmentT1 = x ?? 0;
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
                                            "Total Volume to Dispense (mL)",
                                        hintText: "0mL",
                                        labelStyle:
                                            TextStyle(color: Colors.purple)),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )),

                    // *** TAB 2 ***
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
                                  labelText: "Drug Type"),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: drugTypeT2,
                                  onChanged: (newValue) {
                                    drugTypeT2 = newValue!;
                                    setState(() {
                                      if (drugTypeT2 == "Tablet") {
                                        showTabletT2 = true;
                                      } else {
                                        showTabletT2 = false;
                                      }
                                      resetValues();
                                    });
                                  },
                                  items: drugTypeT2Items.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            )),

                        // **TABLET**
                        Visibility(
                            visible: (showTabletT2),
                            child: Column(children: [
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
                                      labelText:
                                          "Concentration Needed (mg/kg/week)",
                                      hintText:
                                          "Concentration Needed (mg/kg/week)",
                                    ),
                                    onChanged: (value) {
                                      final x = double.tryParse(value);
                                      setState(() {
                                        concentrationNeededT2 = x ?? 0;
                                        calcDosageNeededMgT2();
                                        calcNumTabletsT2();
                                      });
                                    }),
                              ),

                              // Child's surface area input field
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
                                        childWeightT2 = x ?? 0;
                                        calcDosageNeededMgT2();
                                        calcNumTabletsT2();
                                      });
                                    }),
                              ),

                              // Total dosage needed output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: dosageNeededMgT2Text,
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
                              // Num weeks of treatment
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Number of Weeks of Treatment",
                                      hintText: "Number of Weeks of Treatment",
                                    ),
                                    onChanged: (value) {
                                      final x = int.tryParse(value);
                                      setState(() {
                                        numWeeksTreatmentT2 = x ?? 0;
                                        calcNumTabletsT2();
                                      });
                                    }),
                              ),

                              // Num mg per tablet
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextFormField(
                                  initialValue:
                                      mgPerTabletT2.toStringAsFixed(1),
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Number mg's per Tablet",
                                    hintText: "Number mg's per Tablet",
                                  ),
                                ),
                              ),

                              // Num tablets output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: numTabletsT2Text,
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
                                      labelText: "Total Number of Tablets",
                                      hintText: "0 tablets",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),
                            ])),

                        // **SUBCUTANEOUS**
                        Visibility(
                            visible: (!showTabletT2),
                            child: Column(children: [
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
                                      labelText:
                                          "Concentration Needed (mg/kg/week)",
                                      hintText:
                                          "Concentration Needed (mg/kg/week)",
                                    ),
                                    onChanged: (value) {
                                      final x = double.tryParse(value);
                                      setState(() {
                                        concentrationNeededT2 = x ?? 0;
                                        calcDosageNeededMgT2();
                                        calcDosageNeededMlT2();
                                        calcVolumeToDispenseT2();
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
                                        childWeightT2 = x ?? 0;
                                        calcDosageNeededMgT2();
                                        calcDosageNeededMlT2();
                                        calcVolumeToDispenseT2();
                                      });
                                    }),
                              ),

                              // Total dosage needed (mg) output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: dosageNeededMgT2Text,
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
                                          "Total Drug Dose Needed (mg/dose)",
                                      hintText: "0mg/dose",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // Concentration input field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Concentration (mg/mL)",
                                      hintText: "Concentration (mg/mL)",
                                    ),
                                    onChanged: (value) {
                                      final x = double.tryParse(value);
                                      setState(() {
                                        concentrationT2 = x ?? 0;
                                        calcDosageNeededMlT2();
                                        calcVolumeToDispenseT2();
                                      });
                                    }),
                              ),

                              // Total dosage needed (ml) output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: TextField(
                                  controller: dosageNeededMlT2Text,
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
                                      labelText: "Total Drug Dose Needed (mL)",
                                      hintText: "0mL",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),

                              // Number of weeks of treatment input field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 0),
                                child: TextField(
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Number of Weeks of Treatment",
                                      hintText: "Number of Weeks of Treatment",
                                    ),
                                    onChanged: (value) {
                                      final x = int.tryParse(value);
                                      setState(() {
                                        numWeeksTreatmentT2 = x ?? 0;
                                        calcVolumeToDispenseT2();
                                      });
                                    }),
                              ),

                              // Total volume to dispense output field
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 60),
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
                                      labelText:
                                          "Total Volume to Dispense (mL)",
                                      hintText: "0mL",
                                      labelStyle:
                                          TextStyle(color: Colors.purple)),
                                ),
                              ),
                            ]))
                      ],
                    )),
                  ],
                ))));
  }
}
