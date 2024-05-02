// import 'package:femhealth/controller/user_provider.dart';
// import 'package:femhealth/routes/route_name.dart';
// import 'package:femhealth/widgets/reusable_widget.dart';
// ignore_for_file: dead_code

// import 'package:female_health/controller/user_provider.dart';
import 'package:female_health/firebase_const.dart';
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
import 'package:toast/toast.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  bool isPsVisible = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    var media = MediaQuery.of(context).size;

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
                  "Welcome Back",
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
                // RoundTextField(
                //   hitText: "First Name",
                //   icon: ImagePath.userTxt,
                //   color: AppColor.darkBlue.withOpacity(0.7),
                //   controller: _firstNameTextController,
                // ),
                // SizedBox(
                //   height: media.width * 0.04,
                // ),
                // RoundTextField(
                //   hitText: "Last Name",
                //   color: AppColor.darkBlue.withOpacity(0.7),
                //   icon: ImagePath.userTxt,
                //   controller: _lastNameTextController,
                // ),
                // SizedBox(
                //   height: media.width * 0.04,
                // ),
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
                forgetPassword(context),

                SizedBox(
                  height: media.width * 0.7,
                ),

                RoundButton(
                    title: "Login",
                    onPressed: () {
                      _signIn();
                    }),

                // SizedBox(
                //   height: media.width * 0.04,
                // ),

                SizedBox(
                  height: media.width * 0.1,
                ),

                signUpOption(),
              ],
            ),
          ))),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account yet?",
            style: TextStyle(color: AppColor.darkBlue)),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(RouteName.signUp);
          },
          child: const Text(
            " Register",
            style:
                TextStyle(color: AppColor.orange, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Forgot Password?",
            style: TextStyle(color: AppColor.darkBlue),
            textAlign: TextAlign.right,
          ),
          onPressed: () {
            _sendPasswordResetEmail(context);
          }),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailTextController.text;
    String password = _passwordTextController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      toast("User is successfully signed in");
      Navigator.of(context).pushNamed(RouteName.navBar);
    } else {
      toast("Some error occured");
    }
  }

  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    String email = _emailTextController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
