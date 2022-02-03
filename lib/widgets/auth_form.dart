import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, AuthMode authMode,
      BuildContext context) executeAuth;
  final bool isLoading;

  const AuthForm({
    Key? key,
    required this.executeAuth,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.signup;
  String _email = '';
  String _password = '';
  final _passwordController = TextEditingController();

  void _submitAuth() {
    final isAuthValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isAuthValid) {
      _formKey.currentState!.save();
      widget.executeAuth(_email.trim(), _password.trim(), _authMode, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          //margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Container(
              height: _authMode == AuthMode.signup ? 325 : 265,
              width: deviceSize.width * 0.75,
              constraints: BoxConstraints(
                  minHeight: _authMode == AuthMode.signup ? 325 : 265),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid e-mail address.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Password must be at least 4 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    _authMode == AuthMode.signup
                        ? TextFormField(
                            key: const ValueKey('confirmPassword'),
                            enabled: _authMode == AuthMode.signup,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: _authMode == AuthMode.signup
                                ? (value) {
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match.';
                                    }
                                    return null;
                                  }
                                : null,
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _submitAuth,
                        child: Text(_authMode == AuthMode.signup
                            ? 'Sign up'
                            : 'Login')),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.signup
                              ? AuthMode.login
                              : AuthMode.signup;
                        });
                      },
                      child: RichText(
                          text: TextSpan(
                        text: _authMode == AuthMode.signup
                            ? 'Already a user?  '
                            : 'Don\'t have an account?  ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onSurface),
                        children: [
                          TextSpan(
                              text: _authMode == AuthMode.signup
                                  ? 'Login'
                                  : 'Sign up',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
