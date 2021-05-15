// Flutter imports
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports
import '../util/colors.dart' as appColors;

// ignore: must_be_immutable
class ProfileData extends StatefulWidget {
  String name, id;

  ProfileData({this.name, this.id});
  
  @override
  _ProfileDataState createState() => _ProfileDataState(name: this.name, id: this.id);
}

class _ProfileDataState extends State<ProfileData> {
  String name, id, _iconName;

  _ProfileDataState({this.name, this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 1),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: appColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8)
                )
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 2, 30, 1),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: appColors.lightGrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        id,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 18, 30, 30),
            child: Container(
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: appColors.orange,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(
                      onPressed: onLogoutButtonPressed,
                      child: Text(
                        'Log Out',
                        style: TextStyle(color: appColors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        //TODO: Create a view for this and push it here
                      },
                      child: Text(
                        'Need Help?',
                        style: TextStyle(color: appColors.textColor, fontSize: 15),
                      ),
                    ),
                  ),                  
                  SizedBox(height: 10),
                  SvgPicture.asset(
                    _iconName, width: 140, color: appColors.white
                  ),
                  // SizedBox(height: 50)
                ]
              )
            )
          )
        ]
      ) 
    );
  }

  void onLogoutButtonPressed() async {
    Navigator.pushReplacementNamed(context, '/login');
  }  
}
