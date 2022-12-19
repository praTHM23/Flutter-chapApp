import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);
  AuthForm(this.submitFn, this.isloading);

  final bool isloading;
  final void Function(String email, String pasword, String username,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = "";
  var _userName = "";
  var _userPassword = "";

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return "Please Enter a valid email address";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                        ),
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 3) {
                              return "Please Enter a valid email Username ";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 8) {
                            return "Password should be greater than 8 char";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onSaved: (value) {
                          _userPassword = value;
                        },
                      ),
                      SizedBox(height: 20),
                      if (widget.isloading) CircularProgressIndicator(),
                      if (!widget.isloading)
                        RaisedButton(
                          child: Text(_isLogin ? 'login' : "Signup"),
                          onPressed: () {
                            _trySubmit();
                          },
                        ),
                      if (!widget.isloading)
                        FlatButton(
                            child: Text(_isLogin
                                ? 'create new account'
                                : "I already have account"),
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            })
                    ],
                  ),
                )),
          )),
    );
  }
}
