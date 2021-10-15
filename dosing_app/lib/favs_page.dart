import 'package:flutter/material.dart';

class FavouritesPage extends StatefulWidget {
  FavouritesPage(
      {Key? key, required this.medications, required this.favMedications})
      : super(key: key);
  dynamic medications;
  dynamic favMedications = Set<Map<String, dynamic>>();

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All"),
        ),
        body: Center(
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: widget.favMedications.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                      // leading: FlutterLogo(size: 72.0),
                      // title: Text(widget.favMedications.elementAt(index)),
                      // subtitle: Text(widget.favMedications.elementAt(index)),
                      // isThreeLine: true,
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Med1(
                      //             index: index,
                      //             medications: widget.medications,
                      //             favMedications: widget.favMedications)),
                      //   );
                      // },
                      ),
                );
              }),
        ));
  }
}
