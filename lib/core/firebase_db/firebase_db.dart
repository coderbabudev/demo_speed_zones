import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/features/auth/presentation/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethod {
  User? user;

  Future createUser(UserDetails userInfo) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(user?.uid)
        .set(userInfo.toJson());
  }
}
