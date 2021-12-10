import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isFavourited = false;
  List<Map<String, dynamic>> favs = [];

  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDrugDoseNeededText = TextEditingController();
  TextEditingController dailyPropanololrequired = TextEditingController();
  TextEditingController bIdproponol = TextEditingController();
  TextEditingController totalVolumeToDispenseText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double bIdproponoldose = 0;
  double dailyPropanolol = 0;
  double finalDropdown = 3.75;
  double totalVolumeToDispense = 0;
  int days = 0;
  List<double> propranololConcentration = [3.75, 4.28, 5];

  int mgPerTablet = 10;
  double dropdownvalue = 3.75;
  // Handle closing the keyboard when use taps anywhere else on the screen
  late FocusNode myFocusNode;

  void loadFavs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        favs = (jsonDecode(prefs.getString('favMedications')!) as List)
            .map((dynamic e) => e as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      setState(() {
        favs = [];
      });
    }
  }

  void getFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        isFavourited = prefs.getBool('med7')!;
      } catch (e) {
        isFavourited = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    loadFavs();
    getFavoriteStatus();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  // Functions for each output field
  String calcTotalDosagePropranol(
      double concentrationNeeded, double childWeight) {
    totalDoseNeeded = concentrationNeeded * childWeight;
    totalDrugDoseNeededText.text = (totalDoseNeeded).toStringAsFixed(2) +
        "mg/dose"; // handle null and String
    return totalDrugDoseNeededText.text;
  }

  String DailyRequired(double totalNeed, double concentration) {
    dailyPropanolol = totalNeed / concentration;
    if (dailyPropanolol.isNaN || dailyPropanolol.isInfinite) {
      dailyPropanololrequired.text = (0).toStringAsFixed(2) + "ml";
    } else {
      dailyPropanololrequired.text =
          (dailyPropanolol).toStringAsFixed(2) + "ml";
    }
    return dailyPropanololrequired.text;
  }

  String BidPropranol(double dailyproponol) {
    bIdproponoldose = dailyproponol / 2;
    if (bIdproponoldose.isNaN || bIdproponoldose.isInfinite) {
      bIdproponol.text = (0).toStringAsFixed(2) + "mg/dose";
    } else {
      bIdproponol.text = (bIdproponoldose).toStringAsFixed(2) + "mg/dose";
    }
    return bIdproponol.text;
  }

  String calcTotalVolumeDisperse(double dailyproponol, int days) {
    totalVolumeToDispense = dailyproponol * days;
    totalVolumeToDispenseText.text =
        (totalVolumeToDispense).toStringAsFixed(2) +
            "mg/dose"; // handle null and String
    return totalVolumeToDispenseText.text;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> medication = widget.medications[widget.index];

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
                      onTap: () async {
                        setState(() {
                          if (isFavourited) {
                            favs.removeWhere(
                                (item) => item["name"] == medication["name"]);
                            isFavourited = false;
                          } else {
                            favs.add(medication);
                            isFavourited = true;
                          }
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('favMedications', jsonEncode(favs));
                        prefs.setBool('med7', isFavourited);
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
                      onChanged: (value) {
                        final output = double.tryParse(value);
                        setState(() {
                          concentrationNeeded = output ?? 0;
                          calcTotalDosagePropranol(
                              concentrationNeeded, childWeight);
                          DailyRequired(totalDoseNeeded, finalDropdown);
                          BidPropranol(dailyPropanolol);
                          calcTotalVolumeDisperse(dailyPropanolol, days);
                          concentrationNeededText.text =
                              (concentrationNeeded.toString() + "mg/kg/dose");
                        });
                      }),
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
                      onChanged: (value) {
                        final output = double.tryParse(value);
                        setState(() {
                          childWeight = output ?? 0;
                          calcTotalDosagePropranol(
                              concentrationNeeded, childWeight);
                          DailyRequired(totalDoseNeeded, finalDropdown);
                          BidPropranol(dailyPropanolol);
                          calcTotalVolumeDisperse(dailyPropanolol, days);
                        });
                      }),
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
                        child: DropdownButton<double>(
                          value: dropdownvalue,
                          isExpanded: true,
                          items: propranololConcentration.map((double value) {
                            return DropdownMenuItem(
                              child: Text(value.toStringAsFixed(2) + "mg"),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                              final tryParse = double.tryParse(
                                  dropdownvalue.toStringAsFixed(2));
                              finalDropdown = tryParse ?? 0;
                              DailyRequired(totalDoseNeeded, finalDropdown);
                              BidPropranol(dailyPropanolol);
                              calcTotalVolumeDisperse(dailyPropanolol, days);
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
                    controller: dailyPropanololrequired,
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
                    controller: bIdproponol,
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
                      onChanged: (value) {
                        final output = int.tryParse(value);
                        setState(() {
                          days = output ?? 0;
                          calcTotalVolumeDisperse(dailyPropanolol, days);
                        });
                      }),
                ),

                // Total mg output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 60),
                  child: TextField(
                    controller: totalVolumeToDispenseText,
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
