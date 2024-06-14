import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/lib_http.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        title: Text('Consultation'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              Text("Date d'échéance de la tâche :"),SizedBox(height: 10.0),
              Text("${widget.leParametre1.toString()}"),SizedBox(height: 10.0),
              Text("Pourcentage d'avancement de la tache :"),SizedBox(height: 10.0),
              Text("${widget.leParametre2.toString()}"),SizedBox(height: 10.0),
              Text("Pourcentage de temps écoulé depuis la création de la tâche :"),SizedBox(height: 10.0),
              Text("${widget.leParametre3.toString()}"),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _pourcentageController,
                decoration: InputDecoration(labelText: 'Entrer un nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  // Add your own password validation logic here
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
                child: Text('Changer le pourcentage d avancement'),
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
              'Bonjour ${UserSession.getInstance().username}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Ajout de tache'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Deconnexion'),
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

// Écrans de navigation supplémentaires
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

