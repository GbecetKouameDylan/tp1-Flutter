import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:dio/dio.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/transfert.dart';
import 'generated/l10n.dart';
import 'lib_http.dart';
import 'package:flutter/services.dart';

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
      home:  LoginPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
          return isLandscape
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildFormChildren(context, isLandscape),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildFormChildren(context, isLandscape),
          );
        },
      ),
    );
  }

  List<Widget> buildFormChildren(BuildContext context, bool isLandscape) {
    return <Widget>[
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _usernameController,
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
          onPressed: loading ? null : Signup,
          child: loading ? CircularProgressIndicator() : Text(S.of(context).Connexion),
        ),
      ),
    ];
  }

  Future<void> Signup() async {
    setState(() {
      loading = true;
    });
    try {
      SignupRequest req = SignupRequest();
      req.username = _usernameController.text;
      req.password = _passwordController.text;
      var reponse = await signup(req);
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
