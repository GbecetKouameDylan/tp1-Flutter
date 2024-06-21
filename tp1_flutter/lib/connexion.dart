import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/main.dart';
import 'package:tp1_flutter/transfert.dart';

import 'generated/l10n.dart';
import 'lib_http.dart';

/*void main() {
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
}*/

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nomController = TextEditingController();
  final _passwordController = TextEditingController();
bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Connexion),

      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nomController,
              decoration: InputDecoration(labelText:S.of(context).userName),
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
                  // Add your own password validation logic here
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: loading?null:Signin,
                child: this.loading?CircularProgressIndicator():
                Text(S.of(context).Connexion),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(
                    builder: (context) => SignUpPage(title: S.of(context).Signup),
                  )
                  );
                },
                child: Text(S.of(context).Signup),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Signin() async {
    setState(() {
      this.loading = true;
    });
    try{
      SigninRequest req = SigninRequest();
      req.username = _nomController.text;
      req.password = _passwordController.text;
      var reponse = await signin(req);
      setState(() {
        this.loading = false;
      });
      UserSession.getInstance().setUsername(reponse.username);
      print(reponse);
      Navigator.push(
          context,MaterialPageRoute(
        builder: (context) => HomePage(),
      )
      );
    }
    on DioException catch(e)
    {
      setState(() {
        this.loading = false;
      });
      print(e);
      String message = e.response!.data;
      if (message == "BadCredentialsException") {
        print('login deja utilise');
      } else {
        print('autre erreurs');
      }
    }


  }

}
