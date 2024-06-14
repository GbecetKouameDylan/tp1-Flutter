import 'package:flutter/material.dart';
import 'package:tp1_flutter/connexion.dart';
import 'package:tp1_flutter/creation.dart';
import 'package:tp1_flutter/lib_http.dart';
import 'package:tp1_flutter/main.dart';
import 'package:tp1_flutter/transfert.dart';

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
        title: Text('Home'),
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
                    // Gérer le tap sur le titre
                    
                  },
                  child: Text(homeItems[index].name),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Gérer le tap sur le sous-titre
                        print('Deadline cliquée: ${homeItems[index].deadline.toString()}');
                      },
                      child: Text('Deadline: ${homeItems[index].deadline.toString()}'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Gérer le tap sur le sous-titre
                        print('Pourcentage terminé cliqué: ${homeItems[index].percentageDone}%');
                      },
                      child: Text('Percentage Done: ${homeItems[index].percentageDone}%'),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Gérer le tap sur le sous-titre
                        print('Pourcentage de temps écoulé cliqué: ${homeItems[index].percentageTimeSpent}%');
                      },
                      child: Text('Percentage Time Spent: ${homeItems[index].percentageTimeSpent}%'),
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
              'Bonjour ${UserSession.getInstance().username}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Ajout de tache'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Deconnexion'),
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

// Écrans de navigation supplémentaires
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}


