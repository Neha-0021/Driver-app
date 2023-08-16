import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../atom/CustomTextInput.dart';
import '../../state-management/profile-state.dart';

class PersonalDetail extends StatelessWidget {
  const PersonalDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileState>(builder: (context, profileState, child) {
      final firstName = profileState.driverData['name']?.toString() ?? '';

      final lastName = profileState.driverData['lastName']?.toString() ?? '';
      final mobile = profileState.driverData['mobile']?.toString() ?? '';
      final email = profileState.driverData['email']?.toString() ?? '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextInput(
                hintText: "First Name",
                imagePath: "assets/images/svg/profile.svg",
                onChangeText: (String value) {},
                isDisabled: true,
                value: firstName,
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextInput(
                hintText: "Last Name",
                imagePath: "assets/images/svg/profile-line.svg",
                isDisabled: true,
                onChangeText: (String value) {},
                value: lastName,
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
              hintText: "Mobile",
              imagePath: 'assets/images/disable.png',
              isDisabled: true,
              additionalImagePath: 'assets/images/Password.png',
              onChangeText: (String value) {},
              value: mobile,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextInput(
                hintText: "Email",
                imagePath: "assets/images/svg/email.svg",
                onChangeText: (String value) {},
                isDisabled: true,
                value: email,
              )),
        ],
      );
    });
  }
}
