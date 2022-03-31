// ignore_for_file: prefer_const_constructors_in_immutables, unrelated_type_equality_checks, prefer_const_constructors, duplicate_ignore, deprecated_member_use, unused_element, unused_label

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      /* light theme settings */
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      /* dark theme settings */
    ),
    themeMode: ThemeMode.light,
    /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  late String deger = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText:
                  'Lütfen kullanıcı idnizi eksiksiz bir biçimde yazınız.',
            ),
            onChanged: (girilenText) {
              deger = girilenText;
            },
          ),
          FloatingActionButton.extended(
            backgroundColor: const Color(0xff03dac6),
            foregroundColor: Colors.black,
            onPressed: () {
              databaseReference
                  .child("users")
                  .child(deger)
                  .once()
                  .then((event) {
                DataSnapshot snapshot = event.snapshot;
                if (snapshot.exists == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondPage()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Center(
                          child: Text(" Kullanıcı ID'niz onaylanmadı!"),
                        ),
                      ));
                }
              });
            },
            label: const Text('ONAYLA'),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Center(child: const Text("GERİ")),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
