import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;

import '/widgets/auth_form.dart';
import '/screens/logged_user_screen.dart';
import '/widgets/loading_widget.dart';
import '/providers/auth_provider.dart';

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
    UserCredential _;
    try {
      setState(() {
        _isLoading = true;
      });
      if (authMode == AuthMode.login) {
        _ = await _authInstance.signInWithEmailAndPassword(
            email: email, password: password);
        setLoadingToFalse();
      } else {
        _ = await _authInstance.createUserWithEmailAndPassword(
            email: email, password: password);
        setLoadingToFalse();
      }
    } on PlatformException catch (err) {
      var message = AppLocalizations.of(context)!.authError;
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return _isLoading
        ? const LoadingWidget()
        : Stack(children: [
            Container(
                height: deviceSize.height,
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
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: deviceSize.height * 0.8,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                          image: AssetImage(
                              'assets/images/newsshore_title_only.png'),
                          fit: BoxFit.fitWidth),
                      const SizedBox(height: 30),
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
                            return Center(
                              child: Column(
                                children: [
                                  AuthForm(
                                      executeAuth: _executeAuth,
                                      isLoading: _isLoading),
                                  const SizedBox(height: 20),
                                  Platform.isIOS
                                      ? Column(
                                          children: [
                                            SizedBox(
                                                width: deviceSize.width * 0.75,
                                                child: SignInWithAppleButton(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .appleSignIn,
                                                  style:
                                                      SignInWithAppleButtonStyle
                                                          .black,
                                                  iconAlignment:
                                                      IconAlignment.center,
                                                  onPressed: () {
                                                    context
                                                        .read<AuthProvider>()
                                                        .signInWithApple();
                                                  },
                                                )),
                                            const SizedBox(height: 20),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: deviceSize.width * 0.75,
                                    height: 40,
                                    child: FloatingActionButton.extended(
                                        onPressed: () {
                                          context
                                              .read<AuthProvider>()
                                              .googleSignUp(context);
                                        },
                                        icon: Image.asset(
                                            'assets/images/google_logo.png',
                                            height: 20,
                                            width: 20),
                                        label: Text(
                                          AppLocalizations.of(context)!
                                              .googleSignIn,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)))),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ]),
              ),
            )
          ]);
  }
}
