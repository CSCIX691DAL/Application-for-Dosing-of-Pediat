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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All"),
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       const DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Colors.indigo,
        //         ),
        //         child: Text('Drawer Header'),
        //       ),
        //       ListTile(
        //         title: const Text('Item 1'),
        //         onTap: () {
        //           // Update state of the app
        //           // ...
        //           // Then close drawer
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        body: Center(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.medications.length,
              itemBuilder: (BuildContext context, int index) {
                String title = widget.medications[index]['name'];
                String description = widget.medications[index]['description'];
                return Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 72.0),
                    title: Text(title),
                    subtitle: Text(description),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(context, '/med1');
                    },
                  ),
                );
              }),
        ));
  }
}
