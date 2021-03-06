import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'medications/med_1.dart';
import 'medications/med_2.dart';
import 'medications/med_3.dart';
import 'medications/med_4.dart';
import 'medications/med_5.dart';
import 'medications/med_6.dart';
import 'medications/med_7.dart';
import 'medications/med_8.dart';
import 'medications/med_9.dart';
import 'medications/med_10.dart';
import 'medications/med_11.dart';
import 'medications/med_12.dart';
import 'medications/med_13.dart';
import 'medications/med_14.dart';
import 'medications/med_15.dart';
import 'medications/med_16.dart';
import 'medications/med_17.dart';

void main() {
  // myApp was const
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // was const
  MyApp({Key? key}) : super(key: key);

  List<dynamic> favMedications = [];

  List<dynamic> medications = [
    {
      'name': 'Acitretin',
      'imagePath': 'assets/Acitretin.png',
      'description': 'Calculate the dosage for Acitretin',
      'route': '/med1',
    },
    {
      'name': 'Acyclovir',
      'imagePath': 'assets/Aciclovir.png',
      'description': 'Calculate the dosage for Acyclovir',
      'route': '/med2',
    },
    {
      'name': 'Amoxicillin',
      'imagePath': 'assets/Amoxicillin.png',
      'description': 'Calculate the dosage for Amoxicillin',
      'route': '/med3',
    },
    {
      'name': 'Azathioprine',
      'imagePath': 'assets/Azathioprine.png',
      'description': 'Calculate the dosage for Azathioprine',
      'route': '/med4',
    },
    {
      'name': 'Cephalexin',
      'imagePath': 'assets/Cefalexin.png',
      'description': 'Calculate the dosage for Cephalexin',
      'route': '/med5',
    },
    {
      'name': 'Ciclosporin',
      'imagePath': 'assets/Ciclosporin.png',
      'description': 'Calculate the dosage for Ciclosporin',
      'route': '/med6',
    },
    {
      'name': 'Hemangiol/Propranolol',
      'imagePath': 'assets/Propranolol.png',
      'description': 'Calculate the dosage for Hemangiol/Propranolol',
      'route': '/med7',
    },
    {
      'name': 'Hydroxyzine',
      'imagePath': 'assets/Hydroxyzine.png',
      'description': 'Calculate the dosage for Hydroxyzine',
      'route': '/med8',
    },
    {
      'name': 'Isotretinoin',
      'imagePath': 'assets/Isotretinoin.png',
      'description': 'Calculate the dosage for Isotretinoin',
      'route': '/med9',
    },
    {
      'name': 'Itraconazole',
      'imagePath': 'assets/Itraconazole.png',
      'description': 'Calculate the dosage for Itraconazole',
      'route': '/med10',
    },
    {
      'name': 'Methotrexate',
      'imagePath': 'assets/Methotrexate.png',
      'description': 'Calculate the dosage for Methotrexate',
      'route': '/med11',
    },
    {
      'name': 'Mycophenalate Mofetil',
      'imagePath': 'assets/Mycophenolate_mofetil.png',
      'description': 'Calculate the dosage for Mycophenalate Mofetil',
      'route': '/med12',
    },
    {
      'name': 'Mycophenalate Sodium',
      'imagePath': 'assets/Mycophenolic_sodium.png',
      'description': 'Calculate the dosage for Mycophenalate Sodium',
      'route': '/med13',
    },
    {
      'name': 'Prednisolone',
      'imagePath': 'assets/Prednisolone.png',
      'description': 'Calculate the dosage for Prednisolone',
      'route': '/med14',
    },
    {
      'name': 'Prednisone',
      'imagePath': 'assets/Prednisone.png',
      'description': 'Calculate the dosage for Prednisone',
      'route': '/med15',
    },
    {
      'name': 'Terbinafine',
      'imagePath': 'assets/Terbinafine.png',
      'description': 'Calculate the dosage for Terbinafine',
      'route': '/med16',
    },
    {
      'name': 'Valacyclovir',
      'imagePath': 'assets/Valaciclovir.png',
      'description': 'Calculate the dosage for Valacyclovir',
      'route': '/med17',
    },
  ];

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
          '/med4': (context) => Med4(
              index: 3,
              medications: medications,
              favMedications: favMedications),
          '/med5': (context) => Med5(
              index: 4,
              medications: medications,
              favMedications: favMedications),
          '/med6': (context) => Med6(
              index: 5,
              medications: medications,
              favMedications: favMedications),
          '/med7': (context) => Med7(
              index: 6,
              medications: medications,
              favMedications: favMedications),
          '/med8': (context) => Med8(
              index: 7,
              medications: medications,
              favMedications: favMedications),
          '/med9': (context) => Med9(
              index: 8,
              medications: medications,
              favMedications: favMedications),
          '/med10': (context) => Med10(
              index: 9,
              medications: medications,
              favMedications: favMedications),
          '/med11': (context) => Med11(
              index: 10,
              medications: medications,
              favMedications: favMedications),
          '/med12': (context) => Med12(
              index: 11,
              medications: medications,
              favMedications: favMedications),
          '/med13': (context) => Med13(
              index: 12,
              medications: medications,
              favMedications: favMedications),
          '/med14': (context) => Med14(
              index: 13,
              medications: medications,
              favMedications: favMedications),
          '/med15': (context) => Med15(
              index: 14,
              medications: medications,
              favMedications: favMedications),
          '/med16': (context) => Med16(
              index: 15,
              medications: medications,
              favMedications: favMedications),
          '/med17': (context) => Med17(
              index: 16,
              medications: medications,
              favMedications: favMedications),
        }
        // home: const HomePage(),
        );
  }
}
