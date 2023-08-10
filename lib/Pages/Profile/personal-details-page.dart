import 'dart:io';
import 'package:driver_app/Molecules/Profile/Personal-details.dart';
import 'package:driver_app/Molecules/Profile/camera-gallery.dart';
import 'package:driver_app/atom/Button.dart';
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
                            showIcon: true,
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
                    style: textSubHeadingStyle,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: CustomButton(
                          label: 'Submit',
                          onPressed: () {
                            profileState.submit(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 120,
                left: (MediaQuery.of(context).size.width - 130) / 2,
                child: GestureDetector(
                  onTap: () =>
                      selectProfileImage(context, profileState),
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
                            child: profileState.driverData["profile_photo"] !=
                                    null
                                ? profileImage == null
                                    ? Image.network(
                                        profileState.driverData["profile_photo"],
                                        fit: BoxFit.cover)
                                    : Image.file(
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
                          child: const Icon(
                            Icons.camera_alt,
                            color: Color(0xFF192B46),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
