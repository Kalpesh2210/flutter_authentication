import 'package:flutter/material.dart';
import 'package:flutter_application_1/forgotpass.dart';
import 'package:flutter_application_1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // ignore: non_constant_identifier_names
  final ValidatorKey = GlobalKey<FormState>();

  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController conpass = TextEditingController();

  String? password;

  @override
  void initState() {
    GetData();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void GetData() async {
    var pref = await SharedPreferences.getInstance();
    password = pref.getString('password') ?? password;
  }

  // ignore: non_constant_identifier_names
  void SetData() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('password', conpass.text);
  }

  String? oldPassValidate(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Old Password is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    if (value != password) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Incorrect Password'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    return null;
  }

  String? newPassValidate(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('New Password is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  String? ConfirmPassValidate(String? value) {
    if (value!.isEmpty) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Confirm Password is required'),
            alignment: Alignment.topCenter,
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    }
    if (value != newpass.text) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Confirm password should be match'),
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
          key: ValidatorKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: oldpass,
                  validator: oldPassValidate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 300),
                    label: Text(
                      'Enter Old Password',
                      style: TextStyle(color: Colors.indigo),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: newpass,
                  validator: newPassValidate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 300),
                    label: Text(
                      'Enter New Password',
                      style: TextStyle(color: Colors.indigo),
                    ),
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: conpass,
                  validator: ConfirmPassValidate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 300),
                    label: Text(
                      'Enter Confirm Password',
                      style: TextStyle(color: Colors.indigo),
                    ),
                    prefixIcon: Icon(
                      Icons.file_download_done,
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
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                    ),
                    onPressed: () {
                      GetData();
                      if (!ValidatorKey.currentState!.validate()) {
                        return;
                      } else {
                        SetData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyLogin()));
                        toastification
                            .show(
                              context:
                                  context, // optional if you use ToastificationWrapper
                              title: const Text('Password Change Successfully'),
                              type: ToastificationType.success,
                              autoCloseDuration: const Duration(seconds: 5),
                            )
                            .toString();
                      }
                    },
                    child: const Text('Continue')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPass()));
                    },
                    child: const Text('Forgot Password ?'))
              ],
            ),
          )),
    );
  }
}
