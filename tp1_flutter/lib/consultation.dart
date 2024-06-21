import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/home.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/transfert.dart';

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


  final int taskId;

  const ConsultationPage(
      {Key? key,
        required this.taskId,
      })
      : super(key: key);

  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  String imageURL = "";
  String imagepath = "";
  var _imageFile;

  void getimage() async {
    ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("l'image a ete choisie ${pickedFile.path}");
      _imageFile = File(pickedFile.path);
    }
    setState(() {});
  }

  TaskDetailPhotoResponse ?tachecourante ;

  @override
  void initState() {
    getTask();
    super.initState();

  }


  Future <TaskDetailPhotoResponse> getTask() async {
    //lib http gettask()
TaskDetailPhotoResponse taskDetailResponse = await Detail(widget.taskId);
    setState(() {
      tachecourante = taskDetailResponse;
    });
    return taskDetailResponse;
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
              _imageFile != null ? Image.file(_imageFile) : Spacer(),
              Text(S.of(context).Deadline),
              SizedBox(height: 10.0),
              Text("${tachecourante?.deadline}"),
              SizedBox(height: 10.0),
              Text(S.of(context).Percentage),
              SizedBox(height: 10.0),
              Text("${tachecourante?.percentageDone}"),
              SizedBox(height: 10.0),
              Text(S.of(context).PercentageDeadline),
              SizedBox(height: 10.0),
              Text("${tachecourante?.percentageTimeSpent}"),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text(S.of(context).Change),
              ),
              ElevatedButton(
                onPressed: () {
                  getimage();
                },
                child: Text(S.of(context).Image),
              ),
              ElevatedButton(
                onPressed: () {
                  sendPicture(widget.taskId, _imageFile);
                },
                child: Text(S.of(context).Simage),
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
              print(reponse);
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
