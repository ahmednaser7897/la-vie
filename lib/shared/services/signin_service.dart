import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SigninService {
  static GoogelAndFaceLogein googelLogein = GoogelAndFaceLogein();

  final GoogleSignIn googleSignin = GoogleSignIn();
  Future<GoogelAndFaceLogein?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignin.signIn();
      if (googleSignInAccount != null) {
        googelLogein = GoogelAndFaceLogein(
            email: googleSignInAccount.email,
            firstName: googleSignInAccount.displayName!.split(" ")[0],
            lastName: googleSignInAccount.displayName!.split(" ")[1],
            id: googleSignInAccount.id,
            picture: googleSignInAccount.photoUrl);
        /*   print('user emil = ${googleSignInAccount.email}');
        print('user firstName = ${googleSignInAccount.displayName!.split(" ")[0]}');
        print('user ln = ${googleSignInAccount.displayName!.split(" ")[1]}');
        print('user id = ${googleSignInAccount.id}');
        print('user image = ${googleSignInAccount.photoUrl}'); */
        googleSignInAccount.id;
        return googelLogein;
      } else {
        return null;
      }
    } catch (e) {
      print("erorr in signInWithGoogle is " + e.toString());
      return null;
    }
  }

  Future<void> googelSignOut() async {
    await googleSignin.signOut();
    print('googelSignOut');
  }

  final fb = FacebookLogin(debug: true);
  //final fb=FacebookAuth.instance;
  Future<GoogelAndFaceLogein?> facebookSignInMethod() async {
    try {
      print("start2");
      //final LoginResult result = await fb.login();
      final FacebookLoginResult result = await fb.logIn();
      print("start3");
      if (result.status == LoginStatus.success) {
        //var m=await fb.getUserData() ;
        FacebookUserProfile? m = await fb.getUserProfile();
        googelLogein = GoogelAndFaceLogein(
            email: await fb.getUserEmail(),
            firstName: m!.firstName!,
            lastName: m.lastName,
            id: m.userId,
            picture: await fb.getProfileImageUrl(width: 100));

        /*googelLogein = GoogelAndFaceLogein(
          email:m["email"],
          firstName: m["name"].toString().split(" ")[0],
          lastName:m["name"].toString().split(" ")[0],
          id: m["id"],
          picture: m["picture"]["data"]["url"]
        ); */
        return googelLogein;
      } else {
        return null;
      }
    } catch (e) {
      print("erorr in facebookSignInMethod is " + e.toString());
      return null;
    }
  }

  Future<void> facebooklSignOut() async {
    await fb.logOut();
    print('facebooklSignOut');
  }
}

class GoogelAndFaceLogein {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? picture;

  GoogelAndFaceLogein(
      {this.id, this.email, this.firstName, this.lastName, this.picture});

  GoogelAndFaceLogein.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['picture'] = picture;
    return data;
  }
}
