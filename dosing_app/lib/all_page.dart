import 'package:flutter/material.dart';
import 'medications/med_1.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // medication 1
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 1'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 2
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 2'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 3
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 3'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 4
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 4'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 5
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 5'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 6
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 6'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 7
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 7'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 8
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 8'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 9
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 9'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 10
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 10'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 11
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 11'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 12
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 12'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 13
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 13'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
            // medication 14
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Med1()),
                );
              },
              child: Card(
                child: ListTile(
                  leading: FlutterLogo(size: 72.0),
                  title: Text('Medication 14'),
                  subtitle: Text(
                      'A sufficiently long subtitle warrants three lines.'),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
