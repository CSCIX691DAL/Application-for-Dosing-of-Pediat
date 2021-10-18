import 'package:dosing_app/medications/med_5.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'medications/med_1.dart';

void main() {
  // myApp was const
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // was const
  MyApp({Key? key}) : super(key: key);

  List<Map<String, String>> medications = [
    {
      'name': 'Acitretin',
      'description': 'Calculate the dosage for Acitretin',
      'route': '/med1',
    },
    {
      'name': 'Acyclovir',
      'description': 'Calculate the dosage for Acyclovir',
      'route': '/med1',
    },
    {
      'name': 'Amoxicillin',
      'description': 'Calculate the dosage for Amoxicillin',
      'route': '/med1',
    },
    {
      'name': 'Azathioprine',
      'description': 'Calculate the dosage for Azathioprine',
      'route': '/med1',
    },
    {
      'name': 'Cephalexin',
      'description': 'Calculate the dosage for Cephalexin',
      'route': '/med5',
    },
    {
      'name': 'Cyclosporin',
      'description': 'Calculate the dosage for Cyclosporin',
      'route': '/med1',
    },
    {
      'name': 'Hemangiol/Propranolol',
      'description': 'Calculate the dosage for Hemangiol/Propranolol',
      'route': '/med1',
    },
    {
      'name': 'Hydroxyzine',
      'description': 'Calculate the dosage for Hydroxyzine',
      'route': '/med1',
    },
    {
      'name': 'Isotretinoin',
      'description': 'Calculate the dosage for Isotretinoin',
      'route': '/med1',
    },
    {
      'name': 'Itraconazole',
      'description': 'Calculate the dosage for Itraconazole',
      'route': '/med1',
    },
    {
      'name': 'Methotrexate',
      'description': 'Calculate the dosage for Methotrexate',
      'route': '/med1',
    },
    {
      'name': 'Mycophenalate Mofetil',
      'description': 'Calculate the dosage for Mycophenalate Mofetil',
      'route': '/med1',
    },
    {
      'name': 'Mycophenalate Sodium',
      'description': 'Calculate the dosage for Mycophenalate Sodium',
      'route': '/med1',
    },
    {
      'name': 'Prednisolone',
      'description': 'Calculate the dosage for Prednisolone',
      'route': '/med1',
    },
    {
      'name': 'Prednisone',
      'description': 'Calculate the dosage for Prednisone',
      'route': '/med1',
    },
    {
      'name': 'Terbinafine',
      'description': 'Calculate the dosage for Terbinafine',
      'route': '/med1',
    },
    {
      'name': 'Valacyclovir',
      'description': 'Calculate the dosage for Valacyclovir',
      'route': '/med1',
    },
  ];

  List<Map<String, String>> favMedications = [];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(
                medications: medications,
                favMedications: favMedications,
              ),
          '/med1': (context) => Med1(
              index: 0,
              medications: medications,
              favMedications: favMedications),
          '/med5': (context) => Med5(
            index:4,
            medications: medications,
            favMedications: favMedications)
        }
        // home: const HomePage(),
        );
  }
}
