import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Authentication',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  final ValidateKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController userpassword = TextEditingController();

  String? name;
  String? email;
  String? pass;

  String snack = '';
  @override
  void initState() {
    getData();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void SaveData() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('name', username.text);
    pref.setString('mail', useremail.text);
    pref.setString('password', userpassword.text);
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const MyLogin()));
  }

  void getData() async {
    var pref = await SharedPreferences.getInstance();
    name = pref.getString('name');
    email = pref.getString('mail');
    pass = pref.getString('password');
    if (name != null && email != null && pass != null) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const MyHome()));
    } else {}
  }

  // snackbarfun(var snackname) {
  //   var sn = SnackBar(
  //     content: Text(snackname),
  //     behavior: SnackBarBehavior.floating,
  //     shape: const ContinuousRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(10))),
  //     width: 350,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(sn);
  // }

  String? validName(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Name is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    return null;
  }

  String? validEmial(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Email ID is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Invalid Email'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    return null;
  }

  String? validPass(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Password is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    if (!RegExp(r'[A-Z0-9a-z]*').hasMatch(value)) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Invalid Password'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Logo'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Form(
              key: ValidateKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: username,
                        validator: validName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(maxWidth: 300),
                          label: Text(
                            'Enter Name',
                            style: TextStyle(color: Colors.indigo),
                          ),
                          prefixIcon: Icon(
                            Icons.face,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: useremail,
                        validator: validEmial,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(maxWidth: 300),
                          label: Text(
                            'Enter Email ID',
                            style: TextStyle(color: Colors.indigo),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: validPass,
                        controller: userpassword,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          constraints: BoxConstraints(maxWidth: 300),
                          label: Text(
                            'Enter Password',
                            style: TextStyle(color: Colors.indigo),
                          ),
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(300, 50),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                          onPressed: () {
                            if (!ValidateKey.currentState!.validate()) {
                              return;
                            }
                            SaveData();
                          },
                          child: const Text('Sign Up')),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyLogin()));
                          },
                          child: const Text('Already Registered ?'))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
