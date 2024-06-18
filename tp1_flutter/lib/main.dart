import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:dio/dio.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/home.dart';
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
      home:  LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: S.of(context).userName),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).QName;
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: S.of(context).Password),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).QPassword;
              }

              return null;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              SignupRequest req = SignupRequest();
              req.username = _usernameController.text;
              req.password = _passwordController.text;
              var reponse = await signup(req);
              UserSession.getInstance().setUsername(reponse.username);
              print(reponse);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Text(S.of(context).Signup),
          ),
        ],
      ),
    );
  }
}

