import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mixtaplay/api_service.dart';
import 'package:mixtaplay/music_screen.dart';
import 'package:http/http.dart' as http;
import 'package:mixtaplay/signin_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  static final emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswwordCont = TextEditingController();

  final signupCall = ApiCalls();
  SignupGetResponse? signUpData;

  requestSignUp() async {
     signUpData = await signupCall.signUp(
        emailController.text,
        _usernameController.text,
        _passwordController.text,
        _confirmPasswwordCont.text);
    if (signUpData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MusicScreen()));
      return signUpData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                  keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  validator: (value){
                    if (value!.isEmpty) {
                    return 'Email cannot be empty';
                   }
                    bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);

                    return !emailValid
                      ? 'Enter a Valid Email Address'
                      : null;
                   },
                    controller: emailController,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "Username",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username cannot be empty';
                      } else if (value.length < 3) {
                        return 'Username cannot be less than 3';
                      }
                    },
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length > 12) {
                        return "Password is minumum of 12 characters";
                      }
                    },
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          " Confirm Password",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    controller: _confirmPasswwordCont,
                    validator: (value) {
                      if (value == null) {
                        return "Confirm your password";
                      } else if (value.isEmpty) {
                        return 'Field cannot be empty';
                      } else if (value != _passwordController.text) {
                        return "Password doesn't match";
                      } else if (value.length > 12) {
                        return "Password is minumum of 12 characters";
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate() == "null"){
                        await requestSignUp();
                      }

                    },
                    child: Container(
                      width: 320,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(103, 0, 176, 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Create Account",
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white
                           ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Already have an account?  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white
                        ),
                      ),
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),

                    ],
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap:  (){
                      signUpWithGoogle(context);
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color.fromRGBO(102, 0, 153, 1)
                        )
                      ),
                        child: Row(
                           children: [
                             Image.asset("assets/images/gogle_icon.jpg",
                               height: 30,
                               width: 30,
                             ),
                             const SizedBox(width: 10,),
                             Text(
                               "Sign up with google",
                                  style: TextStyle(
                                   fontSize: 22,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.white
                               ),
                             ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      signInWithFacebook();
                    },
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color.fromRGBO(102, 0, 153, 1)
                          )
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/gogle_icon.jpg",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            "Sign up with google",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),



































    );
  }

  Future<void> signUpWithGoogle(BuildContext context) async {

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MusicScreen()));
      } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  void signInWithFacebook() async {

    try {
      final LoginResult result = await FacebookAuth.instance
          .login(permissions: (['email', 'public_profile']));
      final token = result.accessToken!.token;
      print(
          'Facebook token userID : ${result.accessToken!.grantedPermissions}');
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/'
              'v2.12/me?fields=name,first_name,last_name,email&access_token=${token}'));

      final profile = jsonDecode(graphResponse.body);
      print("Profile is equal to $profile");
      try {
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MusicScreen()),
        );
      } catch (e) {
        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: Color.fromRGBO(65, 164, 255, 0.75),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("error occurred");
      print(e.toString());
    }
  }
}


