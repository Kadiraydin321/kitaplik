import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kitaplik/Services/global_veriable.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn() async {
  FirebaseUser user;
  bool isSignedIn = await _googleSignIn.isSignedIn();
  if (isSignedIn) {
    user = await _auth.currentUser();
  } else {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    user = (await _auth.signInWithCredential(credential)).user;
    Firestore.instance.collection("users").document(user.uid).setData({
      "user_id": user.uid,
      "user_name": user.displayName,
      "user_photo": user.photoUrl,
      "user_email": user.email,
    });
  }
  my_googleSignIn = _googleSignIn;
  return user;
}
