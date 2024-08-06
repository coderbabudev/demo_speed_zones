class Circle {
  final String? circleName;
  final String? circleInviteCode;
  final String? circleAdminUid;
  final String? createdAt;
  final String? updatedAt;
  final bool isDeleted;
  final bool isEnabled;
  final List<int>? circleMembers;

  Circle({
    this.circleName,
    this.circleInviteCode,
    this.circleAdminUid,
    this.createdAt,
    this.updatedAt,
    this.isEnabled = false,
    this.isDeleted = false,
    this.circleMembers,
  });

  factory Circle.fromJson(Map<String, dynamic> json) {
    return Circle(
      circleAdminUid: json['circle_admin_uid'] ?? '',
      circleName: json['circle_name'] ?? '',
      circleInviteCode: json['circle_invite_code'] ?? "",
      isDeleted: json['is_deleted'] ?? false,
      isEnabled: json['is_enabled'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      circleMembers: List<int>.from(json['circle_members']),
    );
  }

  Map<String, dynamic> toJson() => {
        'circle_admin_uid': circleAdminUid,
        'circle_name': circleName,
        'circle_invite_code': circleInviteCode,
        'is_deleted': isDeleted,
        'is_enabled': isEnabled,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'circle_members': circleMembers,
      };
}
