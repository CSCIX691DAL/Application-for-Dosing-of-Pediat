import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Med3 extends StatefulWidget {
  Med3(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);

  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med3State createState() => _Med3State();
}

class _Med3State extends State<Med3> {
  TextEditingController concentrationNeededText = TextEditingController();
  TextEditingController totalDoseNeededText = TextEditingController();
  TextEditingController numMgText = TextEditingController();
  TextEditingController numTabsNeededText = TextEditingController();

  double concentrationNeeded = 0;
  double childWeight = 0;
  double totalDoseNeeded = 0;
  double numDaysTreatment = 0;
  double numMg = 0;
  int numTabsNeeded = 0;

  List<int> mgPerTabletItems = [10, 25];
  int mgPerTablet = 10;

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
                    // Concentration needed

                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            // focusNode: myFocusNode,
                            // controller: concentrationNeededText,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo, width: 2.0),
                              ),
                              labelText: "Concentration Needed (mg/kg/day)",
                              hintText: "0mg/kg/day",
                            ),
                          ),
                        ),
                      ],
                    ),

                    // *** TAB 2 ***
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 0),
                          child: TextField(
                            // focusNode: myFocusNode,
                            // controller: concentrationNeededText,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.indigo, width: 2.0),
                              ),
                              labelText: "Concentration Needed (mg/dose)",
                              hintText: "0mg/dose",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
