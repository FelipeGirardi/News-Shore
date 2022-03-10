import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/widgets/loading_widget.dart';

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

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.signup;
  String _email = '';
  String _password = '';
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
  }

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
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool isMobile = shortestSide < 600;
    final deviceSize = MediaQuery.of(context).size;

    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: _authMode == AuthMode.signup
                  ? deviceSize.height * 0.435
                  : deviceSize.height * 0.385,
              width: deviceSize.width * 0.8,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return AppLocalizations.of(context)!.invalidEmail;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return AppLocalizations.of(context)!.invalidPassword;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.password),
                      obscureText: true,
                      style: TextStyle(fontSize: 14),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                          opacity: _opacityAnimation,
                          child: _authMode == AuthMode.signup
                              ? TextFormField(
                                  controller: _confirmPasswordController,
                                  key: const ValueKey('confirmPassword'),
                                  enabled: _authMode == AuthMode.signup,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .confirmPassword),
                                  obscureText: true,
                                  style: TextStyle(fontSize: 14),
                                  validator: _authMode == AuthMode.signup
                                      ? (value) {
                                          if (value !=
                                              _passwordController.text) {
                                            return AppLocalizations.of(context)!
                                                .invalidConfirmPassword;
                                          }
                                          return null;
                                        }
                                      : null)
                              : Container()),
                    ),
                    SizedBox(height: isMobile ? 30 : 50),
                    widget.isLoading
                        ? const LoadingWidget()
                        : SizedBox(
                            width: deviceSize.width * 0.5,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: _submitAuth,
                                child: AutoSizeText(
                                  _authMode == AuthMode.signup
                                      ? AppLocalizations.of(context)!.signup
                                      : AppLocalizations.of(context)!.login,
                                  presetFontSizes: const [16],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                    const SizedBox(height: 15),
                    Center(
                      child: RichText(
                          text: TextSpan(
                        text: _authMode == AuthMode.signup
                            ? AppLocalizations.of(context)!.alreadyUser
                            : AppLocalizations.of(context)!.noAccount,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Objectivity',
                            color: Theme.of(context).colorScheme.onSurface),
                        children: [
                          TextSpan(
                              text: _authMode == AuthMode.signup
                                  ? AppLocalizations.of(context)!.login
                                  : AppLocalizations.of(context)!.signup,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Objectivity',
                                  color: Theme.of(context).colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    if (_authMode == AuthMode.signup) {
                                      _confirmPasswordController.clear();
                                    }
                                    _authMode = _authMode == AuthMode.signup
                                        ? AuthMode.login
                                        : AuthMode.signup;
                                  });
                                }),
                        ],
                      )),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
