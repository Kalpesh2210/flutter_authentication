import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  // ignore: non_constant_identifier_names
  final ValidateKeyForm = GlobalKey<FormState>();

  TextEditingController findemail = TextEditingController();

  String? mailid;
  String? pass;

  String mailprint = '';
  String passprint = '';

  @override
  void initState() {
    GetData();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void GetData() async {
    var pref = await SharedPreferences.getInstance();
    mailid = pref.getString('mail');
    pass = pref.getString('password');
  }

  void show() {
    setState(() {
      toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: Text('Your Password :$pass'),
            type: ToastificationType.info,
            alignment: Alignment.center,
            autoCloseDuration: const Duration(seconds: 5),
          )
          .toString();
    });
  }

  String? validateEmail(String? value) {
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
    if (value != mailid) {
      return toastification
          .show(
            context: context, // optional if you use ToastificationWrapper
            title: const Text('Error'),
            description: const Text('Incorrect Email'),
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
          key: ValidateKeyForm,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: validateEmail,
                  controller: findemail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxWidth: 300),
                    label: Text(
                      'Enter Valid Email ID',
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
                      if (mailid == findemail.text) {
                        setState(() {
                          show();
                        });
                      }
                      if (!ValidateKeyForm.currentState!.validate()) {
                        return;
                      }
                    },
                    child: const Text('Continue')),
                Text(pass.toString()),
              ],
            ),
          )),
    );
  }
}
