// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/usermodel.dart';
import '../services.dart';
import 'basescreen.dart';
import 'donorlist.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel donors;
  ProfileScreen({required this.donors, required key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var donors = widget.donors;
    return Scaffold(
      body: Center(
        child: BaseScreen(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                              ),
                              onPressed: () => showConfirmationDialog(
                                  title: 'Are you sure?',
                                  body: 'You will no longer be a donor',
                                  onYes: () async {
                                    var response =
                                    await BloodSampleServices.deletePost(
                                        donors);
                                    print(response);
                                    var getList = await BloodSampleServices
                                        .getUserModel();
                                    if (response == "Blood Sample deleted successfully") {
                                      Fluttertoast.showToast(
                                          msg: response!,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Future.delayed(const Duration(seconds: 5),
                                              () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DonorsList(
                                                          donors: getList.item1!,
                                                        )));
                                          });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: response!,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  })),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfile(donors: donors)));
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('Welcome, \nYour Profile is ready!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      SizedBox(width: 0.0, height: 0.0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(14),
                          child: Text(
                            'Name: ${donors.userName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                // fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Phone: ${donors.phoneNumber}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                        ),
                        Container(
                          alignment: Alignment.center,
                          // color: Colors.green,
                          child: Icon(
                            Icons.water,
                            color: Colors.red.shade700,
                            size: 150,
                          ),
                        ),
                        Text(
                          '${donors.bloodGroup}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showConfirmationDialog({
    String? title,
    String? body,
    VoidCallback? onYes,
  }) {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
              title: Text(title!),
              content: Text(body!),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: onYes,
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ]);
        });
  }
}