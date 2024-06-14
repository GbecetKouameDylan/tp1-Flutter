import 'package:flutter/material.dart';
import 'package:tp1_flutter/main.dart';

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

class CreationPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<CreationPage> {
  final _nomController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom de tache';
                  }
                  // Add your own email validation logic here
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _dateController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date';
                  }
                  // Add your own password validation logic here
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(
                    builder: (context) => SignUpForm(),
                  )
                  );
                },
                child: Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}