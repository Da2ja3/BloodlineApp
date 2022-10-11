import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services.dart';
import '../widgets/add_blood_request.dart';
import '../widgets/my_text.dart';

class Donate extends StatefulWidget {

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  bool isLoggedIn = false;

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  showErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: const Text('Add blood sample to continue!',
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                TextButton(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const SignUp()));
                    }),
              ],
              title:  MyText(
                'Oops',
               fontWeight: FontWeight.bold),
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Expanded(
        child: Material(
          color: Colors.redAccent.shade400,
          child: InkWell(
            onTap: () async {
              var getList = await BloodSampleServices.getUserModel();
              //  print(getList);
              // ignore: unnecessary_null_comparison
              if (getList != null) {
                showErrorDialog();
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  const SignUp()));
              }
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white, width: 5.0)),
                padding: const EdgeInsets.all(20.0),
                child: const Text('Donate',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
