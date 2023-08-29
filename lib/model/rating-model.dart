class RatingModel {
  String? status;
  List<DriverRatings>? driverRatings;
  List<Users>? users;
  int? totalUsers;
  double? averageDriverRating;

  RatingModel(
      {this.status,
      this.driverRatings,
      this.users,
      this.totalUsers,
      this.averageDriverRating});

  RatingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['driverRatings'] != null) {
      driverRatings = <DriverRatings>[];
      json['driverRatings'].forEach((v) {
        driverRatings!.add(new DriverRatings.fromJson(v));
      });
    }
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    totalUsers = json['totalUsers'];
    averageDriverRating = json['averageDriverRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.driverRatings != null) {
      data['driverRatings'] =
          this.driverRatings!.map((v) => v.toJson()).toList();
    }
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['totalUsers'] = this.totalUsers;
    data['averageDriverRating'] = this.averageDriverRating;
    return data;
  }
}

class DriverRatings {
  String? sId;
  String? driverId;
  int? rating;
  String? userId;
  String? createdOn;
  int? iV;

  DriverRatings(
      {this.sId,
      this.driverId,
      this.rating,
      this.userId,
      this.createdOn,
      this.iV});

  DriverRatings.fromJson(Map<String, dynamic> json) {
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

class Users {
  String? sId;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? workplace;
  String? mobile;
  String? password;
  String? isactive;
  String? isdelete;
  String? isblocked;
  String? isVerify;
  String? referralCode;
  String? referredBy;
  String? officeTimeFrom;
  String? officeTimeTo;
  String? profilePhoto;
  String? createdOn;
  String? updatedOn;
  int? iV;

  Users(
      {this.sId,
      this.firstname,
      this.lastname,
      this.email,
      this.address,
      this.workplace,
      this.mobile,
      this.password,
      this.isactive,
      this.isdelete,
      this.isblocked,
      this.isVerify,
      this.referralCode,
      this.referredBy,
      this.officeTimeFrom,
      this.officeTimeTo,
      this.profilePhoto,
      this.createdOn,
      this.updatedOn,
      this.iV});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    address = json['address'];
    workplace = json['workplace'];
    mobile = json['mobile'];
    password = json['password'];
    isactive = json['isactive'];
    isdelete = json['isdelete'];
    isblocked = json['isblocked'];
    isVerify = json['isVerify'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    officeTimeFrom = json['officeTimeFrom'];
    officeTimeTo = json['officeTimeTo'];
    profilePhoto = json['profile_photo'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['address'] = this.address;
    data['workplace'] = this.workplace;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['isactive'] = this.isactive;
    data['isdelete'] = this.isdelete;
    data['isblocked'] = this.isblocked;
    data['isVerify'] = this.isVerify;
    data['referral_code'] = this.referralCode;
    data['referred_by'] = this.referredBy;
    data['officeTimeFrom'] = this.officeTimeFrom;
    data['officeTimeTo'] = this.officeTimeTo;
    data['profile_photo'] = this.profilePhoto;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    data['__v'] = this.iV;
    return data;
  }
}
