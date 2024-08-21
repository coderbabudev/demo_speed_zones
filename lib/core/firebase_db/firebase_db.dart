import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/features/auth/presentation/model/user_model.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/model/circle_manage_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserDetails userInfo) async {
    User? user = _auth.currentUser;
    if (user != null) {
      UserDetails userWithId = UserDetails(
        userId: user.uid,
        name: userInfo.name,
        email: userInfo.email,
        phone: userInfo.phone,
        photoUrl: userInfo.photoUrl,
        location: userInfo.location,
        createdAt: userInfo.createdAt,
        updatedAt: userInfo.updatedAt,
        countryFlag: userInfo.countryFlag,
        countryCode: userInfo.countryCode,
        isPhoneVerified: userInfo.isPhoneVerified,
        isEnable: userInfo.isEnable,
        isDeleted: userInfo.isDeleted,
      );

      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(userWithId.toJson());
    } else {
      throw Exception("User not logged in");
    }
  }

  Future<void> createCircle(Circle circleData) async {
    User? user = _auth.currentUser;

    if (user != null) {
      Circle circle = Circle(
        circleAdminUid: user.uid,
        circleName: circleData.circleName,
        circleInviteCode: circleData.circleInviteCode,
        circleMembers: [user.uid],
        isEnabled: circleData.isEnabled,
        isDeleted: circleData.isDeleted,
        createdAt: circleData.createdAt,
        updatedAt: circleData.updatedAt,
      );
      await _firestore
          .collection('circles')
          .doc(circleData.circleInviteCode)
          .set(circle.toJson());
    } else {
      throw Exception("Circle Not created.");
    }
  }

  Future<void> updatePassword(newPassword) async {
    User? user = _auth.currentUser;
    await user?.updatePassword(newPassword);
  }

  Future<void> fetchUserdata(String userName) async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await _firestore.collection('users').doc(user.uid).get().then((value) {
      userName = value.data()?['name'].toString() ?? '';
    });
  }

  Future<dynamic> fetchUserProfileData() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return {};
    }
    DocumentSnapshot userData =
        await _firestore.collection('users').doc(user.uid).get();
    return userData.data();
  }
}
