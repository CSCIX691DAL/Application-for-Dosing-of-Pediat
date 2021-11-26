import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med13 extends StatefulWidget {
  Med13(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med1State createState() => _Med1State();
}

class _Med1State extends State<Med13> {
  TextEditingController drugRequiredText = TextEditingController();
  TextEditingController numTabFinal = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();
  TextEditingController numDosePerDay = TextEditingController();

  double bodySurfaceArea = 0;
  double drugRequiredNeeded = 0;
  double numDaysTreatment = 0;
  double numTabDispense = 0;


  List<int> numTabPerDose = [180, 360];
  int numTab = 180;
  int numTabsNeeded = 0;

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

  void setDay(){
    numDosePerDay.text= "2 doses";
  }

  // Functions for each output field
  void calcTotalDrugRequired() {
    if(bodySurfaceArea <= 1.19){
      drugRequiredNeeded = 0;
      drugRequiredText.text = "Not recommended";
    }
    else if(bodySurfaceArea < 1.58){
      drugRequiredNeeded = 540;
      drugRequiredText.text = drugRequiredNeeded.toStringAsFixed(0) + "mg BID";
    }
    else{
      drugRequiredNeeded = 720;
      drugRequiredText.text = drugRequiredNeeded.toStringAsFixed(0) + "mg BID";
    }
  }



  void calcNumTabsNeeded() {
    numTabsNeeded = (drugRequiredNeeded/ numTab).ceil();
    if (numTabsNeeded.isNaN || numTabsNeeded.isInfinite) {
      numTabsNeededText.text = (0).toString() + " tablets/dose";
    } else {
      numTabsNeededText.text = (numTabsNeeded).toString() + " tablets/dose";
    }
  }
  void calcNumTabDispense() {
    numTabDispense = numDaysTreatment * numTabsNeeded * 2;
    numTabFinal.text = (numTabDispense).toStringAsFixed(0) + " tablets";
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

                // Body surface input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Body Surface Area (m2)",
                        hintText: "Body Surface Area (m2)",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          bodySurfaceArea = x ?? 0; // handle null and String
                          setDay();
                          calcTotalDrugRequired();
                          calcNumTabsNeeded();
                          calcNumTabDispense();
                        });
                      }),
                ),

                // #tablet size dropdown
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
                          labelText: "Tablet size"),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          hint: Text('Please choose an option'),
                          isExpanded: true,
                          value: numTab,
                          onChanged: (newValue) {
                            setState(() {
                              numTab = newValue!;
                              setDay();
                              calcTotalDrugRequired();
                              calcNumTabsNeeded();
                              calcNumTabDispense();
                            });
                          },
                          items: numTabPerDose.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.toString() + "mg"),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    )),

                // Total drug required output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: drugRequiredText,
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
                        labelText: "Drug required (mg/dose)",
                        hintText: "0mg/dose",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

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
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.purple, width: 2.0),
                      ),
                      labelText: "Number of tablets per dose",
                      hintText: '0 tablets/dose',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),

                // Number of doses/day output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: numDosePerDay,
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
                        labelText: "Number of doses/day",
                        hintText: "doses",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Treatment days input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 0),
                  child: TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number of days of Treatment",
                        hintText: "Number of days of Treatment",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          numDaysTreatment = x ?? 0; // handle null and String
                          setDay();
                          calcTotalDrugRequired();
                          calcNumTabsNeeded();
                          calcNumTabDispense();
                        });
                      }),
                ),

                // Number of tabs dispense output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 60),
                  child: TextField(
                    controller: numTabFinal,
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
                        labelText: "Total number of tablets to dispense",
                        hintText: "tablets",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),


              ],
            ),
          ),
        ));
  }
}