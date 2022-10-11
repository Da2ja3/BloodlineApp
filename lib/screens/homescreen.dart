// this is the homepage of bloodline app

import 'package:bloodline/widgets/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/fonts.dart';
import '../utils/request.dart';
import '../widgets/add_blood_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        backgroundColor: MainColors.primary,
        centerTitle: true,
        title: MyText('BloodLine',
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: Fonts.text),
      ),
      drawer: Drawer(
          backgroundColor: MainColors.primary,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            children: <Widget>[
              Icon(Icons.account_circle, size: 150, color: MainColors.bg),
              const SizedBox(height: 30),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Request()));
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.bloodtype, color: MainColors.bg),
                title: MyText(
                  'Request',
                  color: MainColors.bg,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 3),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(
                  Icons.bloodtype,
                  color: Colors.white,
                ),
                title: Text(
                  'Donate',
                  style: TextStyle(
                    color: MainColors.bg,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 340,
              height: 360,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/blood bag.png',
                  ),
                  fit: BoxFit.cover,
                  // opacity: 0.4,
                ),
              ),
            ),
          ),
          SizedBox(height: 170),
          MyText(
            'Donate Blood,\nSave Lives.',
            color: MainColors.primary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
