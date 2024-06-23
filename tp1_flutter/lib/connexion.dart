import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/transfert.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
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
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
              return isLandscape
                  ? Row(
                children: buildFormChildren(context, isLandscape),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildFormChildren(context, isLandscape),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> buildFormChildren(BuildContext context, bool isLandscape) {
    return [
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nomController,
            decoration: InputDecoration(labelText: S.of(context).userName),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).QName;
              }
              return null;
            },
          ),
        ),
      ),
      SizedBox(width: isLandscape ? 20.0 : 0, height: isLandscape ? 0 : 20.0),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
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
        ),
      ),
      SizedBox(width: isLandscape ? 20.0 : 0, height: isLandscape ? 0 : 20.0),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: loading ? null : Signin,
          child: loading ? CircularProgressIndicator() : Text(S.of(context).Connexion),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(title: S.of(context).Signup),
              ),
            );
          },
          child: Text(S.of(context).Signup),
        ),
      ),
    ];
  }

  Future<void> Signin() async {
    setState(() {
      loading = true;
    });
    try {
      SigninRequest req = SigninRequest();
      req.username = _nomController.text;
      req.password = _passwordController.text;
      var reponse = await signin(req);
      setState(() {
        loading = false;
      });
      UserSession.getInstance().setUsername(reponse.username);
      print(reponse);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on DioException catch (e) {
      setState(() {
        loading = false;
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

class SignUpPage extends StatelessWidget {
  final String title;

  const SignUpPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text("Sign Up Page"),
      ),
    );
  }
}
