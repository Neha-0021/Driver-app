class Validation {
  bool validatePhoneNumber(String phoneNumber) {
    // Define the regex pattern for a phone number.
    RegExp regex = RegExp(r'^[6789]\d{9}$');

    // Use the hasMatch method to check if the phoneNumber matches the pattern.
    return regex.hasMatch(phoneNumber);
  }
}
