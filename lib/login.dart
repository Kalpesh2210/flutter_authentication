import 'package:flutter/material.dart';
import 'package:flutter_application_1/changepass.dart';
import 'package:flutter_application_1/forgotpass.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  // ignore: non_constant_identifier_names
  final ValidateKey = GlobalKey<FormState>();
  TextEditingController useremail = TextEditingController();
  TextEditingController userpass = TextEditingController();

  String varemail = '';
  String varpass = '';

  @override
  void initState() {
    GetData();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void GetData() async {
    var pref = await SharedPreferences.getInstance();
    varemail = pref.getString('mail') ?? varemail;
    varpass = pref.getString('password') ?? varpass;
  }

  snackbarfun(var snackname) {
    var sn = SnackBar(
      content: Text(snackname),
      behavior: SnackBarBehavior.floating,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 350,
    );
    ScaffoldMessenger.of(context).showSnackBar(sn);
  }

  String? validEmial(String? value) {
    if (value!.isEmpty) {
      return snackbarfun('Email id is required');
    }
    if (value != varemail) {
      return snackbarfun('Email id should be match');
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
    if (value != varpass) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Incorrect password'),
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
      body: Form(
          key: ValidateKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: validEmial,
                  controller: useremail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 300),
                    label: Text(
                      'Enter Email',
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
                  controller: userpass,
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
                // ignore: avoid_unnecessary_containers
                Container(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePassword()));
                          },
                          child: const Text('Change Password ?')),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotPass()));
                          },
                          child: const Text('Forgot Password ?')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(300, 50),
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                    onPressed: () {
                      if (!ValidateKey.currentState!.validate()) {
                        return;
                      }
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHome()));
                    },
                    child: const Text('Sign in')),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()));
                    },
                    child: const Text("Don't have account"))
              ],
            ),
          )),
    );
  }
}
