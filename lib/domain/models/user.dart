class UserModel {
  final String? id;
  final String? countryCode;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? role;
  final String? photo;
  final String? ipAddress;
  final String? isProfileComplete;
  final String? isMobileVerified;
  final String? isDeleted;

  UserModel({
    this.id,
    this.countryCode,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.photo,
    this.ipAddress,
    this.isProfileComplete,
    this.isMobileVerified,
    this.isDeleted,
  });
}
