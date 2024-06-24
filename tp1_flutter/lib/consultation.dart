import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image/image.dart' as img;
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
      home: ConsultationPage(taskId: 1), // Assuming you have a taskId to provide
    );
  }
}

class ConsultationPage extends StatefulWidget {
  final int taskId;

  const ConsultationPage({Key? key, required this.taskId}) : super(key: key);

  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  String imageURL = "";
  String imagepath = "";
  File? _imageFile;

  void getImage() async {
    ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("L'image a été choisie ${pickedFile.path}");
      _imageFile = await resizeImage(File(pickedFile.path));
    }
    setState(() {});
  }

  Future<File> resizeImage(File file) async {
    // Read the image from file
    img.Image? image = img.decodeImage(file.readAsBytesSync());

    // Resize the image to a maximum width of 600 pixels
    img.Image resized = img.copyResize(image!, width: 600);

    // Get the new file path
    final tempDir = Directory.systemTemp;
    final resizedImagePath = '${tempDir.path}/resized_image.jpg';

    // Write the resized image to file
    File resizedImageFile = File(resizedImagePath)
      ..writeAsBytesSync(img.encodeJpg(resized));

    return resizedImageFile;
  }

  TaskDetailPhotoResponse? tachecourante;

  @override
  void initState() {
    getTask();
    super.initState();
  }

  Future<TaskDetailPhotoResponse> getTask() async {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageFile != null
                  ? Image.file(
                _imageFile!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              )
                  : Text(S.of(context).Deadline),
              Text("${tachecourante?.deadline}"),
              Text(S.of(context).Percentage),
              Text("${tachecourante?.percentageDone}"),
              Text(S.of(context).PercentageDeadline),
              Text("${tachecourante?.percentageTimeSpent}"),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: Text(S.of(context).Change),
              ),
              ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: Text(S.of(context).Image),
              ),
              ElevatedButton(
                onPressed: () {
                  sendPicture(widget.taskId, _imageFile!);
                },
                child: Text(S.of(context).Simage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
