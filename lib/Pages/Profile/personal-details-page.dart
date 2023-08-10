import 'dart:io';
import 'package:driver_app/Molecules/Profile/Personal-details.dart';
import 'package:driver_app/Molecules/Profile/camera-gallery.dart';
import 'package:driver_app/atom/Pop-Up/NoteAlert.dart';
import 'package:driver_app/atom/Profile/header.dart';
import 'package:driver_app/state-management/home-state.dart';
import 'package:driver_app/state-management/profile-state.dart';
import 'package:driver_app/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonalDetailPageComponent();
  }
}

class PersonalDetailPageComponent extends State<PersonalDetailPage> {
  XFile? profileImage;

  AlertBundle alert = AlertBundle();

  bool isDisableText = false;

  Future<void> selectProfileImage(BuildContext context, profileState) async {
    final selectedImage = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CameraGallerySheet(
          onImageSelected: (XFile image) {
            profileState.updateProfileImage(image);
            setState(() {
              profileImage = image;
            });
          },
        );
      },
    );

    if (selectedImage != null) {
      setState(() {
        profileImage = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateCall = Provider.of<HomeState>(context, listen: false);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF192B46),
      ),
    );

    return Consumer<ProfileState>(
        builder: (context, profileState, child) => Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 182,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                            color: Color(0xFF192B46),
                          ),
                          child: const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: HeaderWithActionButton(
                                  headerText: 'Personal Details',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 75),
                          child: Text(
                            "${profileState.driverData['firstname']} ${profileState.driverData['lastname']}",
                            style: textHeadingstyle,
                          ),
                        ),
                        Text(
                            "Driver id : ${profileState.driverData['_id'].toString().substring(0, 3)}",
                            style: textSubHeadingStyle),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NoteAlert();
                              },
                            );
                          },
                          child: PersonalDetail(
                            firstName:
                                profileState.driverData["firstname"] ?? "",
                            lastName: profileState.driverData["lastname"] ?? "",
                            email: profileState.driverData["email"] ?? "",
                            phone: profileState.driverData["mobile"] ?? "",
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 120,
                      left: (MediaQuery.of(context).size.width - 130) / 2,
                      child: GestureDetector(
                        onTap: isDisableText
                            ? null
                            : () => selectProfileImage(context, profileState),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5.0,
                                ),
                              ),
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: profileImage != null
                                      ? Image.file(
                                          File(profileImage!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/view.png",
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, right: 5),
                              child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CameraGallerySheet();
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFF192B46),
                                        size: 18,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

const TextStyle textHeadingstyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 24,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.0,
  color: Color(0xFF000000),
);

const TextStyle textSubHeadingStyle = TextStyle(
  fontFamily: 'PublicaSans',
  fontSize: 16,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
  color: Color(0xFF75879B),
);
