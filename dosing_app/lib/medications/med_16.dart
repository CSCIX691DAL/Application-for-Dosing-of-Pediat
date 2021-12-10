import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Med16 extends StatefulWidget {
  Med16(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med16State createState() => _Med16State();
}

class _Med16State extends State<Med16> {
  bool isFavourited = false;
  List<Map<String, dynamic>> favs = [];

  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController dosePerTabletText = TextEditingController();
  TextEditingController tabletsPerDayText = TextEditingController();
  TextEditingController tabletsDispenseText = TextEditingController();

  double childWeight = 0;
  double drugConcentration = 0;
  double dosePerTablet = 250;
  double tabletsPerDay = 0;
  double daysTreatment = 0;
  double tabletsDispense = 0;
  int numTabsNeeded = 0;

  int mgPerTablet = 10;

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
        isFavourited = prefs.getBool('med16')!;
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
  void calcDrugConcentration() {
    if (childWeight >= 10 && childWeight <= 19.99) {
      drugConcentration = 62.5;
    } else if (childWeight >= 20 && childWeight <= 39.99) {
      drugConcentration = 125;
    } else {
      drugConcentration = 250;
    }
    concentrationNeededText.text = (drugConcentration).toStringAsFixed(2) +
        "mg/day"; // handle null and String
  }

  void calcDosePerTablet() {
    dosePerTabletText.text =
        (dosePerTablet).toStringAsFixed(0) + "mg"; // handle null and String
  }

  void calcTabletsPerDay() {
    tabletsPerDay = drugConcentration / dosePerTablet;

    tabletsPerDayText.text = (tabletsPerDay).toStringAsFixed(2) +
        " tablet(s)"; // handle null and String
  }

  void calcTabletsToDispense() {
    tabletsDispense = tabletsPerDay * daysTreatment;

    tabletsDispenseText.text = (tabletsDispense).toStringAsFixed(0) +
        " tablet(s)"; // handle null and String
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
                        prefs.setBool('med16', isFavourited);
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
                        final x = double.tryParse(value);
                        setState(() {
                          childWeight = x ?? 0;
                          calcDrugConcentration();
                          calcDosePerTablet();
                          calcTabletsPerDay();
                        });
                      }),
                ),
                // Drug Concentration Needed output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: concentrationNeededText,
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
                        labelText: "Drug Concentration Needed (mg/day)",
                        hintText: "0mg/day",
                        labelStyle: TextStyle(color: Colors.purple)),
                  ),
                ),

                // Num mg per tablet
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextFormField(
                    initialValue: dosePerTablet.toStringAsFixed(0) + "mg",
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Dose per Tablet",
                      hintText: "Dose per Tablet",
                    ),
                  ),
                ),
                // tablets per Day output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: tabletsPerDayText,
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
                      labelText: "Tablets per Day",
                      hintText: '0 tablets',
                      labelStyle: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                // Days Treatment input field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "# Days of Treatment",
                        hintText: "# Days of Treatment",
                      ),
                      onChanged: (value) {
                        final x = double.tryParse(value);
                        setState(() {
                          daysTreatment = x ?? 0;
                          calcTabletsToDispense();
                        });
                      }),
                ),
                // Total # Tablets to Dispense output field
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 0),
                  child: TextField(
                    controller: tabletsDispenseText,
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
                      labelText: "Total # Tablets to Dispense",
                      hintText: '0 tablets',
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
