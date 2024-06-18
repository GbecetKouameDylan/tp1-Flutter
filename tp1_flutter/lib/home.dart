import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/consultation.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/main.dart';
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<HomeItemResponse> homeItems = [];

  @override
  void initState() {
    super.initState();
    Liste();
  }

  Future<void> Liste() async {
    try {
      List<HomeItemResponse> items = await home();
      setState(() {
        homeItems = items;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Home),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: homeItems.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConsultationPage(
                          leParametre1: homeItems[index].deadline ,
                          leParametre2: homeItems[index].percentageDone,
                          leParametre3: homeItems[index].percentageTimeSpent
                      ),
                      ),
                    );

                  },
                  child: Text(homeItems[index].name),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => ConsultationPage(
                            leParametre1: homeItems[index].deadline ,
                            leParametre2: homeItems[index].percentageDone,
                            leParametre3: homeItems[index].percentageTimeSpent
                        ),
                        ),
                        );
                      },
                      child: Text(' ${homeItems[index].deadline.toString()}'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConsultationPage(
                              leParametre1: homeItems[index].deadline ,
                              leParametre2: homeItems[index].percentageDone,
                              leParametre3: homeItems[index].percentageTimeSpent
                          ),
                          ),
                        );
                      },
                      child: Text(' ${homeItems[index].percentageDone}%'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConsultationPage(
                              leParametre1: homeItems[index].deadline ,
                              leParametre2: homeItems[index].percentageDone,
                              leParametre3: homeItems[index].percentageTimeSpent
                          ),
                          ),
                        );
                      },
                      child: Text(' ${homeItems[index].percentageTimeSpent}%'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreationPage()),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
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




