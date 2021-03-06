// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class UserAuthProvider {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   bool isAlreadyLogged() {
//     var user = FirebaseAuth.instance.currentUser;
//     return user != null;
//   }

//   signOutGoogle() async {
//     await _googleSignIn.signOut();
//   }

//   signOutFirebase() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   Future<void> signInGoogle() async {
//     //Google auth
//     final googleUser = await _googleSignIn.signIn();
//     final googleAuth = await googleUser.authentication;
//     print("googkeAuth: $googleAuth");
//     print("googkeAuth: ${googleUser.email}");
//     print("googkeAuth: ${googleUser.photoUrl}");
//     print("googkeAuth: ${googleUser.displayName}");

//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     //Firebase auth
//     final authResult = await _auth.signInWithCredential(credential);
//     final User user = authResult.user;
//     final String firebaseAuthToken = await user.getIdToken();
//     assert(!user.isAnonymous);
//     assert(firebaseAuthToken != null);
//     final User currentUser = _auth.currentUser;
//     assert(user.uid == currentUser.uid);

//     print("Google auth token: ${googleAuth.accessToken}");
//     print("Firebase auth token: $firebaseAuthToken");
//   }
// }
