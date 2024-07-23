import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future createUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .set(userInfoMap);
  }
}
