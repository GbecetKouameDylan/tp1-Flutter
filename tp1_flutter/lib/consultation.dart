import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/lib_http.dart';

import 'generated/l10n.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class ConsultationPage extends StatefulWidget {
  @override
  final DateTime leParametre1;
  final int leParametre2;
  final double leParametre3;

  const ConsultationPage({Key? key, required this.leParametre1,required this.leParametre2,required this.leParametre3}): super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ConsultationPage> {



  @override
  void initState() {
    super.initState();
  }
  final _pourcentageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Consultation),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Text(S.of(context).Deadline),SizedBox(height: 10.0),
              Text("${widget.leParametre1.toString()}"),SizedBox(height: 10.0),
              Text(S.of(context).Percentage),SizedBox(height: 10.0),
              Text("${widget.leParametre2.toString()}"),SizedBox(height: 10.0),
              Text(S.of(context).PercentageDeadline),SizedBox(height: 10.0),
              Text("${widget.leParametre3.toString()}"),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _pourcentageController,
                decoration: InputDecoration(labelText: S.of(context).Number),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).QNumber;
                  }

                  return null;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                 Detail(1,int.parse(_pourcentageController.text));
                  Navigator.push(
                      context,MaterialPageRoute(
                    builder: (context) => HomePage(),
                  )
                  );
                },
                child: Text(S.of(context).Change),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Ajout du tiroir de navigation
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              ' ${UserSession.getInstance().username}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(S.of(context).Home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(S.of(context).AddATask),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(S.of(context).LogOut),
            onTap: () async {
              var reponse = await signout();
              print (reponse);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}



