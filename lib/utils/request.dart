import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/donorlist.dart';
import '../services.dart';
import '../widgets/my_text.dart';
import 'app_colors.dart';

class Request extends StatelessWidget {
  const Request({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                // This is our main page
                  children: <Widget>[
                    Expanded(
                      child: Material(
                        color: MainColors.primary,
                        child: InkWell(
                          onTap: () async {
                            var getList = await BloodSampleServices
                                .getUserModel();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    DonorsList(donors: getList.item1!,)));
                          },
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 5.0)),
                              padding: const EdgeInsets.all(20.0),
                              child:  MyText('Request',
                                      color: Colors.white,
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                  ])

            ]));
  }
}