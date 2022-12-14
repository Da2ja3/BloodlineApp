// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_polygon_clipper/flutter_polygon_clipper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/usermodel.dart';
import '../services.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_textfield.dart';
import 'basescreen.dart';
import 'donorlist.dart';

class EditProfile extends StatefulWidget {
  final UserModel donors;
  EditProfile({required this.donors});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProfile> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _phoneNumber = TextEditingController();
  String? selectedBloodgroup;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  String text = "Edit profile";
  bool index = true;
  bool isLoading = false;
  bool hiddenText = true;

  static const blood = <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-'];
  final List<DropdownMenuItem<String>> _bloodgroups = blood
      .map(
        (String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(value,
          style: const TextStyle(
            color: MainColors.primary,
          )),
    ),
  )
      .toList();

  void _update() async {
    if (_formkey.currentState?.validate() ?? false) {
      _formkey.currentState?.save();
      UserModel user = UserModel(
        userName: _userName.text,
        bloodGroup: selectedBloodgroup!,
        phoneNumber: _phoneNumber.text,
      );
      setState(() {
        // setState is a way to dynamically change the UI

        isLoading = true;
      });
      // these are variables coming from the api(get and post)
      var getList = await BloodSampleServices.getUserModel();
      var response = await BloodSampleServices.patchPost(user);
      print(response);

      if (response == "Blood Sample updated successfully") {
        Fluttertoast.showToast(
            msg: response!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: MainColors.bg,
            fontSize: 16.0);
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DonorsList(
                    donors: getList.item1!,
                  )));
        });
      } else {
        Fluttertoast.showToast(
            // fluttertoast is a very small message which mainly popup at the bottom of the device screen.
            msg: response!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MainColors.primary,
            textColor: MainColors.bg,
            fontSize: 16.0);
      }
    } else {
      return;
    }

    try {
      setState(() {
        index = true;
        isLoading = false;
      });
      Navigator.of(context).pop(context);
    } catch (err) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff44130f),
      key: _scaffoldkey,
      body: BaseScreen(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        text,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                buildSignupForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSignupForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            textCapitalization: TextCapitalization.words,
            controller: _userName,
            onSaved: (value) {},
            label: "Username",
            hint: "Ex: Blood Test",
            onValidate: (value) {
              if (value.isEmpty) return 'This field can\'t be empty';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _phoneNumber,
            onSaved: (value) {},
            onValidate: (value) {
              if (value.length != 10) {
                return 'Phone Number must be of 10 digits';
              } else if (value.isEmpty) {
                return 'This field can\'t be empty';
              }
            },
            label: 'Contact',
            hint: 'Ex:5880124587',
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                border:
                Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: DropdownButtonFormField(
              value: selectedBloodgroup,
              hint: const Text(
                'Blood Group',
                style: TextStyle(color: Colors.white),
              ),
              items: _bloodgroups,
              onChanged: ((String? newvalue) {
                setState(() {
                  selectedBloodgroup = newvalue;
                  print(selectedBloodgroup);
                });
              }),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 90,
                child: FlutterClipPolygon(
                  // a package used to clip a child widget
                  sides: 6,
                  rotate: 120,
                  borderRadius: 9.0,
                  child: Container(
                    color: MainColors.primary,
                    child: isLoading
                        ? const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.yellow)))
                        : IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: _update,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  showErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content:
              const Text('Enter the fields', style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                  child: const Text('ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: const Text('Error'));
        });
  }
}