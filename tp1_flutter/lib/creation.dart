import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/main.dart';
import 'package:tp1_flutter/transfert.dart';

import 'generated/l10n.dart';
import 'lib_http.dart';

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

class CreationPage extends StatefulWidget {
  @override
  _CreationPageState createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  final _nomController = TextEditingController();
  DateTime? _selectedDate; // Variable pour stocker la date sélectionnée

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Creationoftask),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomController,
              decoration: InputDecoration(labelText: S.of(context).Task),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).QTask;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: S.of(context).Deadline,
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : S.of(context).Choose,
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  AddTaskRequest req = AddTaskRequest();
                  req.name = _nomController.text;
                  TrucAvecUneDate aller = TrucAvecUneDate();
                  aller.date = _selectedDate!;
                  req.deadline = aller.date;
                  var reponse = await Tache(req);
                  print(reponse);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpForm()),
                  );
                },
                child: Text(S.of(context).AddATask),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour afficher le sélecteur de date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
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



