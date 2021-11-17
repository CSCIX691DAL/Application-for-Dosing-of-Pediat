import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
        ),
        body: Center(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.favMedications.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Image.asset(widget.medications[index]['imagePath'],
                        width: 100),
                    title:
                        Text(widget.favMedications[index]['name'].toString()),
                    subtitle: Text(
                        widget.favMedications[index]['description'].toString()),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                          context, widget.favMedications[index]['route']);
                    },
                  ),
                );
              }),
        ));
  }
}
