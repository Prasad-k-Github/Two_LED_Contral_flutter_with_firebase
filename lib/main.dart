import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA0EgMMF4g8L0QREtj6o1S1MXLoPyuOEVE",
      appId: "1:788024373476:android:e7dc4236049ab8a11dbcf1",
      messagingSenderId: "788024373476",
      projectId: "bulb-dealy-new",
      databaseURL: "https://bulb-dealy-new-default-rtdb.firebaseio.com/",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool a = false;
  bool b = false;
  final dbr = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    loadInitialValues();
  }

  Future<void> loadInitialValues() async {
    DataSnapshot snapshotA = await dbr.child('bulb_01').get();
    DataSnapshot snapshotB = await dbr.child('bulb_02').get();

    setState(() {
      a = snapshotA.value as bool? ?? false;
      b = snapshotB.value as bool? ?? false;
    });
  }

  Future<void> toggleLightA() async {
    setState(() {
      a = !a;
    });
    await dbr.child('bulb_01').set(a);
  }

  Future<void> toggleLightB() async {
    setState(() {
      b = !b;
    });
    await dbr.child('bulb_02').set(b);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My app 07"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              a
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 248, 19, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: toggleLightA,
                  child: a ? const Text("OFF") : const Text("ON")),
              b
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 60, 248, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: toggleLightB,
                  child: b ? const Text("OFF") : const Text("ON")),
            ],
          ),
        ),
      ),
    );
  }
}
