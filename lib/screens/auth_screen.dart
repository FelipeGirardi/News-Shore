import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authInstance = FirebaseAuth.instance;
  var _isLoading = false;

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
      } else {
        authResult = await _authInstance.createUserWithEmailAndPassword(
            email: email, password: password);
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
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _authInstance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (userSnapshot.hasData) {
              return const Center(
                child: Text('You are logged in.'),
              );
            }
            return MainAuthScreen(
              executeAuth: _executeAuth,
              isLoading: _isLoading,
            );
          }),
    );
  }
}

class MainAuthScreen extends StatefulWidget {
  final void Function(String email, String password, AuthMode authMode,
      BuildContext context) executeAuth;
  final bool isLoading;

  const MainAuthScreen({
    Key? key,
    required this.executeAuth,
    required this.isLoading,
  }) : super(key: key);

  @override
  _MainAuthScreenState createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Image(
              image: AssetImage('assets/images/newsshore_title.jpg'),
              fit: BoxFit.cover,
              height: 150),
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    AuthForm(
                        executeAuth: widget.executeAuth,
                        isLoading: widget.isLoading),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ]),
          )
        ]);
  }
}
