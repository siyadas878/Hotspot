import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotspot/presentation/screens/nav_bar.dart';
import 'package:hotspot/presentation/screens/signup_screen/adding_google_ac.dart';
import 'package:hotspot/presentation/widgets/snackbar_warning.dart';

Future<void> signinWithGoogle({required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    try {
          await auth.signInWithCredential(credential);

      
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();
        if (snapshot.exists) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NavScreen()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GoogleUser()));
        
      }

      // FirebaseFirestore.instance.collection('user').doc().id.contains(FirebaseAuth.instance.currentUser!.uid)?

      //   Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => GoogleUser()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        //handle error
        // ignore: use_build_context_synchronously
        warning(context, 'account exist with different credential');
      } else if (e.code == 'invalid-credential') {
        //handle error
        // ignore: use_build_context_synchronously
        warning(context, 'invalid credential');
      }
    } catch (e) {
      //handle error
      // ignore: use_build_context_synchronously
      warning(context, 'something else');
    }
  }
}
