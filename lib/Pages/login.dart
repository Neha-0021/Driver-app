import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/utils/storage.dart';
import 'package:driver_app/atom/Button.dart';
import 'package:driver_app/atom/CustomTextInput.dart';
import 'package:driver_app/atom/custom-header.dart';
import 'package:driver_app/atom/password-input.dart';
import 'package:driver_app/atom/privacy-policy.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginComponent();
  }
}

class LoginComponent extends State<Login> {
  bool showPassword = true;
  AlertBundle alert = AlertBundle();
  PhoneStorage storage = PhoneStorage();
  

  driverLogin(context, homeState) async {
    if (homeState.driverMobile.isNotEmpty &&
        homeState.driverPassword.isNotEmpty) {
      homeState.driverLogin().then((value) => {
            alert.SnackBarNotify(context, value['message']),
            if (value["code"] == 200)
              {Navigator.pushNamed(context, "bottom-tabbar")}
          });
    } else {
      alert.SnackBarNotify(context, 'Please Provide Login details to continue');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (context) => HomeState(),
      child: Consumer<HomeState>(
        builder: (context, homeState, child) => Scaffold(
          backgroundColor: const Color(0xffffffff),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  height: deviceHeight / 2.8,
                  width: deviceWidth,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/images/login.png",
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        left: 10,
                        child: CustomHeader(),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Great to have you back!',
                    style: screenTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Start your journey with existing new features!',
                    style: screenSubtitleStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomTextInput(
                    hintText: "Enter Username",
                    imagePath: "assets/images/svg/profile.svg",
                    onChangeText: (String e) => homeState.updateDriverMobile(e),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: PasswordInput(
                    hintText: "Enter Password",
                    imagePath: "assets/images/svg/lock.svg",
                    onChangeText: (String e) =>
                        homeState.updateDriverPassword(e),
                    keyboardType: TextInputType.text,
                    showHidePassword: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    showPassword: showPassword,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomButton(
                      label: 'Login',
                      onPressed: () {
                        driverLogin(context, homeState);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Center(child: PrivacyPolicy()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const TextStyle screenTitleStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: Color(0xFF000000),
);

const TextStyle screenSubtitleStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Color(0xFF75879B),
);
