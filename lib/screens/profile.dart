// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mscoffeeapp/services/auth_service.dart';
import '../widgets/button.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = 'ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);
  static Route<ProfileScreen> route() {
    return MaterialPageRoute<ProfileScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                "assets/coffee_break.svg",
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                semanticsLabel: 'MS Coffee',
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: CommonButton(
            onPressed: () async {
              //CoffeeRouter.instance.pushReplacement(HomeScreen.route());

              /// -----------------------------------
              ///  perform logout and if success disconnect chat and redirect to home screen
              /// -----------------------------------
              await AuthService.instance.logout();
              context.goNamed('home');
            },
            text: 'Logout',
          ),
        ),
      ],
    );
  }
}
