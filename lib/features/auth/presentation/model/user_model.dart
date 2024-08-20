class UserDetails {
  final String? userId;
  final String? name;
  final String? email;
  final String? phone;
  final String? countryFlag;
  final String? countryCode;
  final String? photoUrl;
  final String? location;
  final String? createdAt;
  final String? updatedAt;
  final bool isPhoneVerified;
  final bool isEnable;
  final bool isDeleted;

  const UserDetails({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.countryFlag,
    this.countryCode,
    this.photoUrl,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.isPhoneVerified = false,
    this.isEnable = false,
    this.isDeleted = false,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userId: json['user_id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      countryFlag: json['country_flag'] ?? '',
      countryCode: json['country_code'] ?? '',
      photoUrl: json['image_url'] ?? "",
      location: json['location'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isPhoneVerified: json['is_phone_verified'] ?? false,
      isEnable: json['is_enable'] ?? false,
      isDeleted: json['is_deleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'country_flag': countryFlag,
        'country_code': countryCode,
        'image_url': photoUrl,
        'location': location,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_phone_verified': isPhoneVerified,
        'is_enable': isEnable,
        'is_deleted': isDeleted,
      };
}
