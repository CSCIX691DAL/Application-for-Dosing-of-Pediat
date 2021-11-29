import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med8 extends StatefulWidget {
  Med8(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med8State createState() => _Med8State();
}
class _Med8State extends State<Med8>{
  TextEditingController totalDoseNeededMgT1Text = TextEditingController();
  TextEditingController totalDoseNeededMlT1Text = TextEditingController();
  TextEditingController drugRequiredT1Text = TextEditingController();
  TextEditingController volumeToDispenseT1Text = TextEditingController();

  TextEditingController drugRequiredT2Text = TextEditingController();
  TextEditingController volumeToDispenseT2Text = TextEditingController();

  double concentrationNeededT1 = 0;
  double childWeightT1 = 0;
  double totalDoseNeededMgT1 = 0;
  double totalDoseNeededMlT1 = 0;
  double drugConcentrationT1 = 0;

  double drugRequiredT1 = 0;
  int numDaysTreatmentT1 = 0;
  double volumeToDispenseT1 = 0;
  double volumeToDispenseT2 = 0;

  double concentrationNeededT2 = 0;
  double drugRequiredT2 = 0;
  int numDaysTreatmentT2 = 0;
double  dosesPerDayT2=0;
  List<String> HydroxyzineConcentration = ["0","10","5"];
  String dropdownvalue="0";
  double finalDropdown=0;
  double finalDropdown2=0;




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
  String calcDosageNeededMgT1(double concentrationNeededT1, double childWeightT1 ) {
    totalDoseNeededMgT1 = concentrationNeededT1 * childWeightT1;
    totalDoseNeededMgT1Text.text =
        (totalDoseNeededMgT1).toStringAsFixed(2) + "mg/dose";
    return totalDoseNeededMgT1Text.text;
  }
  String totalDrugNMLT1(double totalNeedT1, double DrugconcentrationT1){
    totalDoseNeededMlT1 = totalNeedT1/DrugconcentrationT1;
    totalDoseNeededMlT1Text.text=(totalDoseNeededMlT1).toStringAsFixed(2)+"ml";
    return totalDoseNeededMlT1Text.text;

  }
  String DrugRQPD(double totalNeedMlT1, double numDosePerDay){
    drugRequiredT1 = totalNeedMlT1/numDosePerDay;
    drugRequiredT1Text.text=(drugRequiredT1).toStringAsFixed(2)+"ml";
    return drugRequiredT1Text.text;

  }
  String DrugRQ2(double totalNeedMlT2, double numDosePerDay){
     drugRequiredT2 = totalNeedMlT2/numDosePerDay;
    drugRequiredT2Text.text=(drugRequiredT2).toStringAsFixed(2)+"ml";
    return drugRequiredT2Text.text;

  }

  String volumeToDisperseT1(double DrugReq, int daysTreatment){
    volumeToDispenseT1 = DrugReq*daysTreatment;
    volumeToDispenseT1Text.text=(volumeToDispenseT1).toStringAsFixed(2)+"ml";
    return   volumeToDispenseT1Text.text;

  }
  String volumeToDisperseT2(double DrugReq, int daysTreatment){
    volumeToDispenseT2 = DrugReq*daysTreatment;
    volumeToDispenseT2Text.text=(volumeToDispenseT2).toStringAsFixed(2)+"ml";
    return   volumeToDispenseT2Text.text;

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
                                    labelText: "Drug Concentration Needed (mg/kg/day)",
                                    hintText: " Drug Concentration Needed (mg/kg/day)",
                                  ),
                                  onChanged: (value) {
                                    final x = double.tryParse(value);
                                    setState(() {
                                      concentrationNeededT1 = x ?? 0;
                                      calcDosageNeededMgT1(concentrationNeededT1,childWeightT1);

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
                                      calcDosageNeededMgT1(concentrationNeededT1,childWeightT1);

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
                            //Hydroxyzine Concentration
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 30, bottom: 0),
                                child: InputDecorator(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.purple, width: 2.0),
                                      ),
                                      labelText: "Hydroxyzine Concentration (mg/mL)"),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownvalue,
                                      isExpanded: true,
                                      items: HydroxyzineConcentration.map((String value) {
                                        return DropdownMenuItem(
                                          child: Text(value+ " mg"),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          if(newValue=="0"){}else {
                                            dropdownvalue = newValue!;
                                            final tryParse = double.tryParse(
                                                dropdownvalue);
                                            finalDropdown = tryParse ?? 0;
                                            totalDrugNMLT1(totalDoseNeededMgT1,
                                                finalDropdown);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller:  totalDoseNeededMlT1Text,
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
                                    labelText: "Total Drug Dosage Needed (mL)",
                                    hintText: "0mL",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                  keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "# of doses per day(mg/kg/day)",
                                    hintText: " # of doses per day (mg/kg/day)",
                                  ),
                                  onChanged: (value) {
                                    final x = double.tryParse(value);
                                    setState(() {
                                      drugRequiredT1 = x ?? 0;
                                      DrugRQPD(totalDoseNeededMlT1,drugRequiredT1);

                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller:  drugRequiredT1Text,
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
                                    hintText: "0mL",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                  keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "# of days of treatment",
                                    hintText: " # of days of treatment",
                                  ),
                                  onChanged: (value) {
                                    final y = int.tryParse(value);
                                    setState(() {
                                      numDaysTreatmentT1 = y ?? 0;
                                      volumeToDisperseT1(drugRequiredT1,numDaysTreatmentT1);

                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
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
                                    labelText: "total volume to dispense [Brand comes in 473mL and 500mL bottles. Brand contains EtOH and menthol. Generic comes in 473mL bottles]",
                                    hintText: "Brand comes in 473mL and 500mL bottles. Brand contains EtOH and menthol. Generic comes in 473mL bottles",
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
                                        borderSide:
                                        BorderSide(color: Colors.purple, width: 2.0),
                                      ),
                                      labelText: "Hydroxyzine Concentration (mg/mL)"),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: dropdownvalue,
                                      isExpanded: true,
                                      items: HydroxyzineConcentration.map((String value) {
                                        return DropdownMenuItem(
                                          child: Text(value+ " mg"),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                          final tryParse2 = double.tryParse(dropdownvalue);
                                          finalDropdown2=tryParse2 ?? 0;
                                          DrugRQ2(concentrationNeededT2,finalDropdown2);

                                        });
                                      },
                                    ),
                                  ),
                                )),
                            //Drug Required
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 0),
                              child: TextField(
                                controller:  drugRequiredT2Text,
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
                                    labelText: "Drug Required",
                                    hintText: "0ml/dose",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),
                            //#doses/days
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
                                    labelText: "#of doses/day",
                                    hintText: "0ml/days",
                                  ),
                                  onChanged: (value) {
                                    final doseperdayT2 = double.tryParse(value);
                                    setState(() {
                                      dosesPerDayT2 = doseperdayT2 ?? 0;

                                    });
                                  }),
                            ),
                            //days of treatment
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
                                    labelText: "Days of treatment",
                                    hintText: "days",
                                  ),
                                  onChanged: (value) {
                                    final days = int.tryParse(value);
                                    setState(() {
                                      numDaysTreatmentT2 = days ?? 0;
                                      volumeToDisperseT2(drugRequiredT2,numDaysTreatmentT2);
                                    });
                                  }),
                            ),
                            //total volume to disperse
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
                                    labelText: "Total Volume to Dispense (mL) [Brand comes in 473mL and 500mL bottles. Brand contains EtOH and menthol. Generic comes in 473mL bottles]",
                                    hintText: "[Brand comes in 473mL and 500mL bottles. Brand contains EtOH and menthol. Generic comes in 473mL bottles]",
                                    labelStyle: TextStyle(color: Colors.purple)),
                              ),
                            ),







                          ],
                        )),
                  ],
                ))));


  }

}