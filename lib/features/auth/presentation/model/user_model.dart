class UserDetails {
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? dob;
  final String? address;
  final bool? isBlock;
  final String? createdAt;

  const UserDetails({
    this.name,
    this.email,
    this.phone,
    this.photoUrl,
    this.dob,
    this.address,
    this.isBlock,
    this.createdAt,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      photoUrl: json['imageUrl'] ?? "",
      dob: json['date_of_birth'] ?? '',
      address: json['address'] ?? '',
      isBlock: json['isBlock'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'imageUrl': photoUrl,
        'date_of_birth': dob,
        'address': address,
        'isBlock': isBlock,
        'createdAt': createdAt,
      };
}
