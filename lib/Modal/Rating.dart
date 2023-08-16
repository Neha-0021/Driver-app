class RatingModal {
  RatingModal({
    required this.status,
    required this.driver,
    required this.user,
  });
  late final String status;
  late final List<Driver> driver;
  late final List<User> user;
  
  RatingModal.fromJson(Map<String, dynamic> json){
    status = json['status'];
    driver = List.from(json['driver']).map((e)=>Driver.fromJson(e)).toList();
    user = List.from(json['user']).map((e)=>User.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['driver'] = driver.map((e)=>e.toJson()).toList();
    _data['user'] = user.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Driver {
  Driver({
    required this.id,
    required this.driverId,
    required this.rating,
    required this.userId,
    required this.createdOn,
    required this.V,
  });
  late final String id;
  late final String driverId;
  late final int rating;
  late final String userId;
  late final String createdOn;
  late final int V;
  
  Driver.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    driverId = json['driverId'];
    rating = json['rating'];
    userId = json['userId'];
    createdOn = json['createdOn'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['driverId'] = driverId;
    _data['rating'] = rating;
    _data['userId'] = userId;
    _data['createdOn'] = createdOn;
    _data['__v'] = V;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.mobile,
    required this.password,
    required this.isactive,
    required this.isdelete,
    required this.isblocked,
    required this.isVerify,
    required this.createdOn,
    required this.updatedOn,
    required this.referralCode,
    required this.referredBy,
    required this.officeTimeFrom,
    required this.officeTimeTo,
    required this.V,
    required this.profilePhoto,
    required this.workplace,
    required this.fcmToken,
  });
  late final String id;
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String address;
  late final String mobile;
  late final String password;
  late final String isactive;
  late final String isdelete;
  late final String isblocked;
  late final String isVerify;
  late final String createdOn;
  late final String updatedOn;
  late final String referralCode;
  late final String referredBy;
  late final String officeTimeFrom;
  late final String officeTimeTo;
  late final int V;
  late final String profilePhoto;
  late final String workplace;
  late final String fcmToken;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    address = json['address'];
    mobile = json['mobile'];
    password = json['password'];
    isactive = json['isactive'];
    isdelete = json['isdelete'];
    isblocked = json['isblocked'];
    isVerify = json['isVerify'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    officeTimeFrom = json['officeTimeFrom'];
    officeTimeTo = json['officeTimeTo'];
    V = json['__v'];
    profilePhoto = json['profile_photo'];
    workplace = json['workplace'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['email'] = email;
    _data['address'] = address;
    _data['mobile'] = mobile;
    _data['password'] = password;
    _data['isactive'] = isactive;
    _data['isdelete'] = isdelete;
    _data['isblocked'] = isblocked;
    _data['isVerify'] = isVerify;
    _data['createdOn'] = createdOn;
    _data['updatedOn'] = updatedOn;
    _data['referral_code'] = referralCode;
    _data['referred_by'] = referredBy;
    _data['officeTimeFrom'] = officeTimeFrom;
    _data['officeTimeTo'] = officeTimeTo;
    _data['__v'] = V;
    _data['profile_photo'] = profilePhoto;
    _data['workplace'] = workplace;
    _data['fcmToken'] = fcmToken;
    return _data;
  }
}
