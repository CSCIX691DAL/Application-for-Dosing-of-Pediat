import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
class Med7 extends StatefulWidget {
  Med7(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med7State createState() => _Med7State();
}

class _Med7State extends State<Med7> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDrugDoseNeededText = TextEditingController();
  TextEditingController DailyPropanololrequired = TextEditingController();
  TextEditingController BIdproponol = TextEditingController();
  TextEditingController TotalVolumeToDisperse = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double BIdproponoldose = 0;
  double DailyPropanolol = 0;
  double finalDropdown=0;
  double totalvolumetodisperse=0;
  int days=0;
  List<String> PropranololConcentration = ["0","3.75", "4.28", "5"];

  int mgPerTablet = 10;
String dropdownvalue="0";
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

  // Functions for each output field
  String calcTotalDosagePropranol(double concentrationNeeded, double childWeight) {
    totalDoseNeeded = concentrationNeeded * childWeight;
    totalDrugDoseNeededText.text = (totalDoseNeeded).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
    return totalDrugDoseNeededText.text;
  }
  String DailyRequired(double totalNeed, double concentration){
     DailyPropanolol= totalNeed/concentration;
     DailyPropanololrequired.text=(DailyPropanolol).toStringAsFixed(2)+"ml";
    return DailyPropanololrequired.text;

  }
  String BidPropranol(double dailyproponol) {
    BIdproponoldose = dailyproponol/2;
    BIdproponol.text = (BIdproponoldose).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
    return BIdproponol.text;
  }
  String calcTotalVolumeDisperse(double dailyproponol , int days) {
    totalvolumetodisperse =dailyproponol  * days;
    TotalVolumeToDisperse.text = (totalvolumetodisperse).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
    return TotalVolumeToDisperse.text;
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

                //drug concentration need
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Drug Concentration Needed (mg/kg/dose)",
                      hintText: "0mg/kg/dose",
                    ),
                      onChanged: (value){
                        final output = double.tryParse(value);
                        setState((){
                          concentrationNeeded=output ?? 0;
                          concentrationNeededText.text= (concentrationNeeded.toString() + "mg/kg/dose");
                        });
                      }
                  ),
                ),



                // Child's weight input field
                Padding(

                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Child's Weight (kg)",
                        hintText: "Child's Weight (kg)",
                      ),
                      onChanged:(value){
                        final output = double.tryParse(value);
                        setState(() {
                          childWeight = output ?? 0;
                        calcTotalDosagePropranol(concentrationNeeded,childWeight);

                        });

                      }
                     ),
                ),

                // Total dosage needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: totalDrugDoseNeededText,
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
                        labelText: "Total Drug Dosage Needed (mg/dose)",
                        hintText: "0mg",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),
                //concentration:drop down
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
                          labelText: "Propranolol Concentration (mg/mL)"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownvalue,
                          isExpanded: true,
                          items: PropranololConcentration.map((String value) {
                            return DropdownMenuItem(
                              child: Text(value+ " mg"),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              if(newValue=="0"){
                               }else{
                               dropdownvalue = newValue!;
                               final tryParse = double.tryParse(dropdownvalue);
                               finalDropdown=tryParse ?? 0;
                               DailyRequired(totalDoseNeeded, finalDropdown);
                               BidPropranol(DailyPropanolol);}
                            });
                          },
                        ),
                      ),
                    )),
               //Daily Propranolol Required (mL)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: DailyPropanololrequired,
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
                      labelText: "Daily Propranolol Required (mL)",
                      hintText: '0.00mL',
                      labelStyle: TextStyle(color: Colors.purple),

                    ),
                  ),
                ),
                //BID Propranolol Dose (mL/dose)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: BIdproponol,
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
                      labelText: "BID Propranolol Dose (mL/dose)",
                      hintText: '0.00mL',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),

                // Number of days of treatment input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of Days of Treatment",
                        hintText: "Number of Days of Treatment",
                      ),
                      onChanged: (value){
                        final output = int.tryParse(value);
                        setState(() {
                          days=output ?? 0;
                          calcTotalVolumeDisperse(DailyPropanolol,days);
                        });
                      }
                     ),
                ),

                // Total mg output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: TotalVolumeToDisperse,
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
                      labelText: "Total Volume to Dispense (mL)",
                      hintText: '0.00mL',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ));
  }
}
