class RatingModel {
  RatingModel({
    required this.status,
    required this.driverRatings,
    required this.users,
    required this.totalUsers,
    required this.averageDriverRating,
  });
  late final String status;
  late final List<DriverRatings> driverRatings;
  late final List<Users> users;
  late final int totalUsers;
  late final int averageDriverRating;
  
  RatingModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    driverRatings = List.from(json['driverRatings']).map((e)=>DriverRatings.fromJson(e)).toList();
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
    totalUsers = json['totalUsers'];
    averageDriverRating = json['averageDriverRating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['driverRatings'] = driverRatings.map((e)=>e.toJson()).toList();
    _data['users'] = users.map((e)=>e.toJson()).toList();
    _data['totalUsers'] = totalUsers;
    _data['averageDriverRating'] = averageDriverRating;
    return _data;
  }
}

class DriverRatings {
  DriverRatings({
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
  
  DriverRatings.fromJson(Map<String, dynamic> json){
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

class Users {
  Users({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.workplace,
    required this.mobile,
    required this.password,
    required this.isactive,
    required this.isdelete,
    required this.isblocked,
    required this.isVerify,
    required this.referralCode,
    required this.referredBy,
    required this.officeTimeFrom,
    required this.officeTimeTo,
    required this.profilePhoto,
    required this.createdOn,
    required this.updatedOn,
    required this.V,
  });
  late final String id;
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String address;
  late final String workplace;
  late final String mobile;
  late final String password;
  late final String isactive;
  late final String isdelete;
  late final String isblocked;
  late final String isVerify;
  late final String referralCode;
  late final String referredBy;
  late final String officeTimeFrom;
  late final String officeTimeTo;
  late final String profilePhoto;
  late final String createdOn;
  late final String updatedOn;
  late final int V;
  
  Users.fromJson(Map<String, dynamic> json){
    id = json['_id'];
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
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['email'] = email;
    _data['address'] = address;
    _data['workplace'] = workplace;
    _data['mobile'] = mobile;
    _data['password'] = password;
    _data['isactive'] = isactive;
    _data['isdelete'] = isdelete;
    _data['isblocked'] = isblocked;
    _data['isVerify'] = isVerify;
    _data['referral_code'] = referralCode;
    _data['referred_by'] = referredBy;
    _data['officeTimeFrom'] = officeTimeFrom;
    _data['officeTimeTo'] = officeTimeTo;
    _data['profile_photo'] = profilePhoto;
    _data['createdOn'] = createdOn;
    _data['updatedOn'] = updatedOn;
    _data['__v'] = V;
    return _data;
  }
}