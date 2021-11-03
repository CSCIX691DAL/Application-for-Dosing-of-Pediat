import 'package:flutter/material.dart';

class Med4 extends StatefulWidget {
  Med4(
      {Key? key,
        required this.index,
        required this.medications,
        required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med4State createState() => _Med4State();
}

class _Med4State extends State<Med4> {
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Azathioprine"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavourited) {
                        widget.favMedications.remove(medication);
                      } else {
                        widget.favMedications.add(medication);
                      }
                    });
                    print(widget.favMedications);
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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}