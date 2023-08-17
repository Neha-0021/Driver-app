class RatingModel {
  String? status;
  List<Driver>? driver;
  List<User>? user;

  RatingModel({this.status, this.driver, this.user});

  RatingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['driver'] != null) {
      driver = <Driver>[];
      json['driver'].forEach((v) {
        driver!.add(new Driver.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.driver != null) {
      data['driver'] = this.driver!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Driver {
  String? sId;
  String? driverId;
  int? rating;
  String? userId;
  String? createdOn;
  int? iV;

  Driver(
      {this.sId,
      this.driverId,
      this.rating,
      this.userId,
      this.createdOn,
      this.iV});

  Driver.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'];
    rating = json['rating'];
    userId = json['userId'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driverId'] = this.driverId;
    data['rating'] = this.rating;
    data['userId'] = this.userId;
    data['createdOn'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? mobile;
  String? password;
  String? isactive;
  String? isdelete;
  String? isblocked;
  String? isVerify;
  String? createdOn;
  String? updatedOn;
  String? referralCode;
  String? referredBy;
  String? officeTimeFrom;
  String? officeTimeTo;
  int? iV;
  String? profilePhoto;
  String? workplace;
  String? fcmToken;

  User(
      {this.sId,
      this.firstname,
      this.lastname,
      this.email,
      this.address,
      this.mobile,
      this.password,
      this.isactive,
      this.isdelete,
      this.isblocked,
      this.isVerify,
      this.createdOn,
      this.updatedOn,
      this.referralCode,
      this.referredBy,
      this.officeTimeFrom,
      this.officeTimeTo,
      this.iV,
      this.profilePhoto,
      this.workplace,
      this.fcmToken});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    iV = json['__v'];
    profilePhoto = json['profile_photo'];
    workplace = json['workplace'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['isactive'] = this.isactive;
    data['isdelete'] = this.isdelete;
    data['isblocked'] = this.isblocked;
    data['isVerify'] = this.isVerify;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['referral_code'] = this.referralCode;
    data['referred_by'] = this.referredBy;
    data['officeTimeFrom'] = this.officeTimeFrom;
    data['officeTimeTo'] = this.officeTimeTo;
    data['__v'] = this.iV;
    data['profile_photo'] = this.profilePhoto;
    data['workplace'] = this.workplace;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}