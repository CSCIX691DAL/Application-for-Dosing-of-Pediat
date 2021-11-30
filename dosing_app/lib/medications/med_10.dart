import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med10 extends StatefulWidget {
  Med10(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med10State createState() => _Med10State();
}

class _Med10State extends State<Med10> {
  TextEditingController totalDoseNeededMgT1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();

  TextEditingController drugRequiredT2Text = TextEditingController();
  TextEditingController dosesPerDayT2Text = TextEditingController();
  TextEditingController volumeToDispenseT2Text = TextEditingController();

  double concentrationNeededT1 = 0;
  double childWeightT1 = 0;
  double totalDoseNeededMgT1 = 0;
  double drugConcentrationT1 = 0;
  double drugRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  double volumeToDispenseT1 = 0;

  double concentrationNeededT2 = 0;
  double drugRequiredT2 = 0;
  int dosesPerDayT2 = 0;
  int numDaysTreatmentT2 = 0;
  double volumeToDispenseT2 = 0;
  String unitT2 = 'mg';

  List<String> drugConcentrationT2Items = ['10mg (Capsule)', '100mg/mL'];
  String drugConcentrationT2 = '10mg (Capsule)';

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

  void calcDrugRequiredT1() {
    drugRequiredT1 = totalDoseNeededMgT1 / drugConcentrationT1;
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

  int drugConcentrationIntT2(drugConcentration) {
    return int.parse(drugConcentration.split("m")[0]);
  }

  String dispenseLabelT2() {
    if (drugConcentrationIntT2(drugConcentrationT2) == 10) {
      unitT2 = 'mg';
      return "Total mg to Dispense";
    } else {
      unitT2 = 'mL';
      return "Total Volume to Dispense (mL)";
    }
  }

  void calcDrugRequiredT2() {
    drugRequiredT2 =
        concentrationNeededT2 / drugConcentrationIntT2(drugConcentrationT2);

    if (drugRequiredT2.isNaN || drugRequiredT2.isInfinite) {
      drugRequiredT2Text.text = (0).toStringAsFixed(2) + "mL/dose";
    } else {
      drugRequiredT2Text.text = (drugRequiredT2).toStringAsFixed(2) + "mL/dose";
    }
  }

  void calcVolumeToDispenseT2() {
    volumeToDispenseT2 = drugRequiredT2 * dosesPerDayT2 * numDaysTreatmentT2;
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
                                labelText: "Concentration Needed (mg/kg/dose)",
                                hintText: "Concentration Needed (mg/kg/dose)",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  concentrationNeededT1 = x ?? 0;
                                  calcDosageNeededMgT1();
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
                                  childWeightT1 = x ?? 0;
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
                                labelText: "Drug Concentration (mg/mL)",
                                hintText: "Drug Concentration (mg/mL)",
                              ),
                              onChanged: (value) {
                                final x = double.tryParse(value);
                                setState(() {
                                  drugConcentrationT1 = x ?? 0;
                                  calcDrugRequiredT1();
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
                                  calcVolumeToDispenseT1();
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
                                child: DropdownButton<String>(
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
                                      child: Text(value),
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
                                calcVolumeToDispenseT2();
                              });
                            },
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
                                  calcVolumeToDispenseT2();
                                });
                              }),
                        ),

                        // Volume to dispense
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 60),
                          child: TextField(
                            controller: volumeToDispenseT2Text,
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
                                labelText: dispenseLabelT2(),
                                hintText: "0" + unitT2,
                                labelStyle:
                                    const TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )),
                  ],
                ))));
  }
}
