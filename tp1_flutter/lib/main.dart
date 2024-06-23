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
      home: LoginPage(),
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
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = MediaQuery
              .of(context)
              .orientation == Orientation.landscape;
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
            decoration: InputDecoration(labelText: S
                .of(context)
                .userName),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S
                    .of(context)
                    .QName;
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
            decoration: InputDecoration(labelText: S
                .of(context)
                .Password),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S
                    .of(context)
                    .QPassword;
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
            controller: _confirmPasswordController,
            decoration: InputDecoration(labelText: S
                .of(context)
                .ConfirmPassword),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S
                    .of(context)
                    .QConfirmPassword;
              }
              if (value != _passwordController.text) {
                return S
                    .of(context)
                    .PasswordsDoNotMatch;
              }
              return null;
            },
          ),
        ),
      ),
      SizedBox(width: isLandscape ? 20.0 : 0, height: isLandscape ? 0 : 20.0),
      if (errorMessage.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: loading ? null : Signup,
          child: loading ? CircularProgressIndicator() : Text(S
              .of(context)
              .Connexion),
        ),
      ),
    ];
  }

  Future<void> Signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
      errorMessage = '';
    });

    try {
      SignupRequest req = SignupRequest();
      req.username = _usernameController.text;
      req.password = _passwordController.text;
      var response = await signup(req);

      setState(() {
        loading = false;
      });

      UserSession.getInstance().setUsername(response.username);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on DioException catch (e) {
      setState(() {
        loading = false;
      });

      String message = e.response!.data;
      if (message == "UsernameAlreadyTaken") {
        setState(() {
          errorMessage = S
              .of(context)
              .UsernameTaken;
        });
      } else if (message == "NetworkError") {
        setState(() {
          errorMessage = S
              .of(context)
              .NetworkError;
        });
      } else if (message == "UsernameTooShort") {
        setState(() {
          errorMessage = S
              .of(context)
              .UsernameTooShort;
        });
      }
      else if (message == "PasswordTooShort") {
        setState(() {
          errorMessage = S
              .of(context)
              .PasswordTooShort;
        });
      }
    }
  }
}
