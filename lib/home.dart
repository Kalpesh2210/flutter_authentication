import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  // ignore: non_constant_identifier_names
  final ValidateKey = GlobalKey<FormState>();

  String varname = '';
  String myname = '';

  String mytext = '';

  @override
  void initState() {
    GetData();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void GetData() async {
    var pref = await SharedPreferences.getInstance();
    varname = pref.getString('name') ?? varname;
    setState(() {
      myname = varname;
    });
  }

  void RemoveData() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('name');
    pref.remove('email');
    pref.remove('password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
          key: ValidateKey,
          child: Center(
            child: Column(
              children: [
                Text(
                  'Welcome $myname',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyLogin()));
                    },
                    child: const Text('Log Out')),
                ElevatedButton(
                    onPressed: () {
                      RemoveData();
                      setState(() {
                        mytext = 'Data Removed';
                      });
                    },
                    child: const Text('remove data')),
                Text(mytext),
              ],
            ),
          )),
    );
  }
}
