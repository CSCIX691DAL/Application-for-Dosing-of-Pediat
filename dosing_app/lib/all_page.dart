import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  AllPage({Key? key, required this.medications, required this.favMedications})
      : super(key: key);
  dynamic medications;
  dynamic favMedications;

  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        appBar: AppBar(
          title: const Text("All"),
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
        body: Center(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.medications.length,
              itemBuilder: (BuildContext context, int index) {
                String title = widget.medications[index]['name'];
                String description = widget.medications[index]['description'];
                String imagePath = widget.medications[index]['imagePath'];
                return Card(
                  child: ListTile(
                    leading: Image.asset(imagePath, width: 100),
                    title: Text(title),
                    subtitle: Text(description),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                          context, widget.medications[index]['route']);
                    },
                  ),
                );
              }),
        ));
  }
}
