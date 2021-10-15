import 'package:flutter/material.dart';

// class Med1 extends StatelessWidget {
//   Med1(
//       {Key? key,
//       required this.index,
//       required this.medications,
//       required this.favMedications})
//       : super(key: key);
//   dynamic index;
//   dynamic medications;
//   dynamic favMedications;

//   @override
//   Widget build(BuildContext context) {
//     Map medication = medications[index];
//     bool isFavourited = favMedications.contains(medication);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Medication 1"),
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                   // onTap: () {
//                   //   setState(() {
//                   //     if (isFavourited) {
//                   //       favedWords.remove(word);
//                   //     } else {
//                   //       favedWords.add(word);
//                   //     }
//                   //   });
//                   // },
//                   child: Icon(Icons.bookmark)))
//         ],
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }

class Med1 extends StatefulWidget {
  Med1(
      {Key? key,
      required this.index,
      required this.medications,
      required this.favMedications})
      : super(key: key);
  dynamic index;
  dynamic medications;
  dynamic favMedications;

  @override
  _Med1State createState() => _Med1State();
}

class _Med1State extends State<Med1> {
  @override
  Widget build(BuildContext context) {
    Map medication = widget.medications[widget.index];
    bool isFavourited = widget.favMedications.contains(medication);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication 1"),
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
