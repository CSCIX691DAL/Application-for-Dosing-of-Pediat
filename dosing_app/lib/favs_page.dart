import 'dart:ui';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage(
      {Key? key, required this.medications, required this.favMedications})
      : super(key: key);
  dynamic medications;
  dynamic favMedications;

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> favs = [];

  void loadFavs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        favs = jsonDecode(prefs.getString('favMedications')!);
      });
    } catch (e) {
      setState(() {
        favs = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadFavs();
  }

  Widget _buildFavPage(BuildContext context) {
    if (favs.isEmpty) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 30),
                child: Text(
                  "You haven't favorited any medications yet! Visit the all page to see all medications.",
                  textAlign: TextAlign.center,
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => HomePage(
                      medications: widget.medications,
                      favMedications: favs,
                    ),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
              child: const Text('All Medications'),
            )
          ]);
    } else {
      return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: favs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: Image.asset(widget.medications[index]['imagePath'],
                    width: 100),
                title: Text(favs[index]['name'].toString()),
                subtitle: Text(favs[index]['description'].toString()),
                isThreeLine: true,
                onTap: () {
                  Navigator.pushNamed(
                      context, (favs[index]['route']).toString());
                },
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: const Text("Favourites"),
          leading: IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(0.0),
                height: 140.0,
                width: 1000,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                  child: Text('App Info',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Image.asset('assets/Dalhousie_logo.png', height: 130),
                  )),
              Container(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          'This app was developed as a group project in CSCIX691 at Dalhousie University.\n\n',
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Developers:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Liam Moore - Team Leader\n'),
                        TextSpan(text: 'Dan Hallam - Developer\n'),
                        TextSpan(text: 'Faiyaz Tanim - Developer\n'),
                        TextSpan(text: 'Hamza Ali - Developer\n'),
                        TextSpan(text: 'Hongjing Bian - Developer\n'),
                        TextSpan(text: 'Ichiro Banskota - Developer\n'),
                        TextSpan(text: 'Jason Nguyen - Developer\n'),
                        TextSpan(text: 'Loren Wolfe - Developer\n'),
                        TextSpan(text: 'Minh Le - Developer\n'),
                        TextSpan(
                            text: '\nCSCIX691 Staff:\n\n',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'Dr. Mohammad Etemad - Instructor\n'),
                        TextSpan(text: 'Kartik Gevariya - TA\n'),
                        TextSpan(text: 'Shwetha Subash - TA\n'),
                        TextSpan(text: 'Srikrishnan Sengottai Kasi - TA\n'),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        body: Center(child: _buildFavPage(context)));
  }
}
