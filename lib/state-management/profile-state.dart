import 'package:driver_app/service/profile/profile.dart';
import 'package:flutter/material.dart';


class ProfileState extends ChangeNotifier {
  final ProfileService service = ProfileService();
   bool isDisableText = true;

  Map<String, dynamic> driverData = {};

  Future<void> getDriverProfile() async {
    try {
      final response = await service.getDriverProfile();
      driverData = response.data; 
      notifyListeners();
    } catch (error) {
      print('Error fetching driver profile: $error');
    }
  }
}
