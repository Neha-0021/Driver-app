import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../atom/Profile/Profile-header.dart';

class CameraGallerySheet extends StatelessWidget {
  final Function(XFile)? onImageSelected;

  const CameraGallerySheet({Key? key, this.onImageSelected}) : super(key: key);

  Future<void> getImageFromGallery(BuildContext context) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      if (onImageSelected != null) {
        onImageSelected!(XFile(pickedImage.path));
      }
    }
    Navigator.pop(context, pickedImage);
  }

  Future<void> captureImageFromCamera(BuildContext context) async {
    final imagePicker = ImagePicker();
    final capturedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (capturedImage != null) {
      if (onImageSelected != null) {
        onImageSelected!(XFile(capturedImage.path));
      }
    }
    Navigator.pop(context, capturedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 200,
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF75879B),
                          width: 0.5,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Color(0xFF75879B),
                          size: 40,
                        ),
                        onPressed: () {
                          captureImageFromCamera(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Camera",
                      style: textSubHeadingStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF75879B),
                          width: 0.5,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.photo_library,
                          color: Color(0xFF75879B),
                          size: 40,
                        ),
                        onPressed: () {
                          getImageFromGallery(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gallery',
                      style: textSubHeadingStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
