// import 'package:femhealth/controller/user_provider.dart';
// import 'package:femhealth/routes/route_name.dart';
// import 'package:femhealth/widgets/reusable_widget.dart';
// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:female_health/controller/user_provider.dart';
import 'package:female_health/firebase_const.dart';
import 'package:female_health/model/user.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:female_health/utils/firebase_auth_service.dart';
// import 'package:female_health/widgets/reusable_widget.dart';
import 'package:female_health/widgets/round_button.dart';
import 'package:female_health/widgets/round_textfield.dart';
import 'package:female_health/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  bool isSigningUp = false;
  final FirebaseAuthService _authh = FirebaseAuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print("Error signing in with Google: $error");
      return null;
    }
  }

  // storeUserData({firstName, lastName, password, email}) async {
  //   DocumentReference store =
  //       firestore.collection('Users').doc(currentuser!.uid);

  //   store.set({
  //     'first_name': firstName,
  //     'last_name': lastName,
  //     'email': email,
  //     'password': password,
  //     'id': currentuser!.uid,

  //     // 'type': type,
  //     // 'image_url': '',
  //     // 'certificate': certificate,
  //   });
  // }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  bool isCheck = false;
  bool isPsVisible = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    ToastContext().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              children: <Widget>[
                // logoWidget('assets/logo/appLogo.png'),
                const Text(
                  "Hey There,",
                  style: TextStyle(color: AppColor.darkBlue, fontSize: 16),
                ),
                const Text(
                  "Create an Account",
                  style: TextStyle(
                      color: AppColor.darkBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                RoundTextField(
                  hitText: "First Name",
                  icon: ImagePath.userTxt,
                  color: AppColor.darkBlue.withOpacity(0.7),
                  controller: _firstNameTextController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Last Name",
                  color: AppColor.darkBlue.withOpacity(0.7),
                  icon: ImagePath.userTxt,
                  controller: _lastNameTextController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Email",
                  color: AppColor.darkBlue.withOpacity(0.7),
                  icon: ImagePath.email,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                    hitText: "Password",
                    color: AppColor.darkBlue.withOpacity(0.7),
                    icon: ImagePath.lock,
                    obscureText: !isPsVisible,
                    controller: _passwordTextController,
                    rigtIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            isPsVisible = !isPsVisible;
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: isPsVisible
                                ? Icon(Icons.visibility_off_outlined,
                                    color: AppColor.darkBlue.withOpacity(0.5))
                                : Icon(Icons.visibility_outlined,
                                    color:
                                        AppColor.darkBlue.withOpacity(0.5))))),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        isCheck
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColor.darkBlue,
                        size: 20,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        "By continuing you accept our Privacy Policy and\nTerm of Use",
                        style:
                            TextStyle(color: AppColor.darkBlue, fontSize: 11),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.25,
                ),
                RoundButton(
                    title: "Register",
                    isChecked: isCheck,
                    onPressed: isCheck
                        ? () {
                            // Provider.of<UserProvider>(context, listen: false)
                            //     .setUsername(_firstNameTextController.text);
                            _signUp();
                          }
                        : () {}),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.black.withOpacity(0.5),
                    )),
                    const Text(
                      "  Or  ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.black.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),

                googleSignInButton(),

                SizedBox(
                  height: media.width * 0.04,
                ),

                signUpOption(),
              ],
            ),
          ))),
    );
  }

  Widget googleSignInButton() {
    return GestureDetector(
      onTap: () async {
        UserCredential? userCredential = await _handleSignIn();
        if (userCredential != null) {
          // Google Sign-In successful, handle the user accordingly
          print("Google Sign-In Successful");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Google Sign-In Successful"),
          ));
        } else {
          // Google Sign-In failed
          print("Google Sign-In Failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Google Sign-In Failed"),
          ));
        }
      },
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          "assets/logo/google_logo.png",
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: AppColor.darkBlue)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(RouteName.signIn);
          },
          child: const Text(
            " Login",
            style:
                TextStyle(color: AppColor.orange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String firstName = _firstNameTextController.text;
    String lastName = _lastNameTextController.text;
    String email = _emailTextController.text;
    String password = _passwordTextController.text;

    User? firebaseuser =
        await _authh.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (firebaseuser != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      // await storeUserData(
      //   firstName: firstName,
      //   lastName: lastName,
      //   email: email,
      //   password: password,
      // );

      userProvider.setUser(UserModel(
          uid: firebaseuser.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password
          // Add more fields as needed
          ));
      Navigator.of(context).pushNamed(RouteName.completeprofile);
    } else {
      toast("Error occured - try again");
    }
  }
}
