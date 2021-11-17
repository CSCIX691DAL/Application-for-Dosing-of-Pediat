import 'package:dosing_app/medications/med_5.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'medications/med_1.dart';
import 'medications/med_2.dart';
import 'medications/med_3.dart';
import 'medications/med_5.dart';
import 'medications/med_9.dart';
import 'medications/med_15.dart';

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
      'route': '/med2',
    },
    {
      'name': 'Amoxicillin',
      'description': 'Calculate the dosage for Amoxicillin',
      'route': '/med3',
    },
    {
      'name': 'Azathioprine',
      'description': 'Calculate the dosage for Azathioprine',
      'route': '/med4',
    },
    {
      'name': 'Cephalexin',
      'description': 'Calculate the dosage for Cephalexin',
      'route': '/med5',
    },
    {
      'name': 'Cyclosporin',
      'description': 'Calculate the dosage for Cyclosporin',
      'route': '/med6',
    },
    {
      'name': 'Hemangiol/Propranolol',
      'description': 'Calculate the dosage for Hemangiol/Propranolol',
      'route': '/med7',
    },
    {
      'name': 'Hydroxyzine',
      'description': 'Calculate the dosage for Hydroxyzine',
      'route': '/med8',
    },
    {
      'name': 'Isotretinoin',
      'description': 'Calculate the dosage for Isotretinoin',
      'route': '/med9',
    },
    {
      'name': 'Itraconazole',
      'description': 'Calculate the dosage for Itraconazole',
      'route': '/med10',
    },
    {
      'name': 'Methotrexate',
      'description': 'Calculate the dosage for Methotrexate',
      'route': '/med11',
    },
    {
      'name': 'Mycophenalate Mofetil',
      'description': 'Calculate the dosage for Mycophenalate Mofetil',
      'route': '/med12',
    },
    {
      'name': 'Mycophenalate Sodium',
      'description': 'Calculate the dosage for Mycophenalate Sodium',
      'route': '/med13',
    },
    {
      'name': 'Prednisolone',
      'description': 'Calculate the dosage for Prednisolone',
      'route': '/med14',
    },
    {
      'name': 'Prednisone',
      'description': 'Calculate the dosage for Prednisone',
      'route': '/med15',
    },
    {
      'name': 'Terbinafine',
      'description': 'Calculate the dosage for Terbinafine',
      'route': '/med16',
    },
    {
      'name': 'Valacyclovir',
      'description': 'Calculate the dosage for Valacyclovir',
      'route': '/med17',
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
          '/med2': (context) => Med2(
              index: 1,
              medications: medications,
              favMedications: favMedications),
          '/med3': (context) => Med3(
              index: 2,
              medications: medications,
              favMedications: favMedications),
          '/med5': (context) => Med5(
              index: 4,
              medications: medications,
              favMedications: favMedications),
          '/med9': (context) => Med9(
              index: 8,
              medications: medications,
              favMedications: favMedications),
          '/med15': (context) => Med15(
              index: 14,
              medications: medications,
              favMedications: favMedications),
        }
        // home: const HomePage(),
        );
  }
}
