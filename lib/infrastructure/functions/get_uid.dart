import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserUtils {
  Future<String?> getUID() async {
    String? email = FirebaseAuth.instance.currentUser?.email;

    if (email != null) {
      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: email)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          String uid = querySnapshot.docs[0].id;
          return uid;
        } else {
          return null;
        }
      } catch (error) {
        return null;
      }
    } else {
      return null;
    }
  }
}
