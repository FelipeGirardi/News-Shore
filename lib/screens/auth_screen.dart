import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/widgets/auth_form.dart';
import '/screens/logged_user_screen.dart';
import '/widgets/loading_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authInstance = FirebaseAuth.instance;
  var _isLoading = false;

  void setLoadingToFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  void _executeAuth(String email, String password, AuthMode authMode,
      BuildContext context) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (authMode == AuthMode.login) {
        authResult = await _authInstance.signInWithEmailAndPassword(
            email: email, password: password);
        setLoadingToFalse();
      } else {
        authResult = await _authInstance.createUserWithEmailAndPassword(
            email: email, password: password);
        setLoadingToFalse();
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials.';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setLoadingToFalse();
    } catch (err) {
      setLoadingToFalse();
    }
  }

  Future<void> googleSignUp(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        UserCredential _ =
            await _authInstance.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing in. Please try again.'),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: _isLoading
            ? const LoadingWidget()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    const Image(
                        image: AssetImage('assets/images/newsshore_title.png'),
                        fit: BoxFit.fitWidth),
                    Expanded(
                      child: Stack(children: [
                        Container(
                            decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 182, 237, 232),
                              Color.fromARGB(255, 21, 45, 121),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 1],
                          ),
                        )),
                        StreamBuilder(
                            stream: _authInstance.authStateChanges(),
                            builder: (ctx, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingWidget();
                              }
                              if (userSnapshot.hasData) {
                                return const LoggedUserScreen();
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    AuthForm(
                                        executeAuth: _executeAuth,
                                        isLoading: _isLoading),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: deviceSize.width * 0.75,
                                      child: FloatingActionButton.extended(
                                        onPressed: () {
                                          googleSignUp(context);
                                        },
                                        icon: Image.asset(
                                            'assets/images/google_logo.png',
                                            height: 25,
                                            width: 25),
                                        label: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            'Sign in with Google',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Roboto',
                                            ),
                                          ),
                                        ),
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ]),
                    )
                  ]));
  }
}
