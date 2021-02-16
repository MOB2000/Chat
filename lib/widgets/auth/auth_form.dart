import 'dart:io';

import 'package:flutter/material.dart';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    File image,
    bool isLogin,
    BuildContext context,
  ) _submit;
  final _isLoading;

  AuthForm(this._submit, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();
  String _email = '';
  String _username = '';
  String _password = '';
  File _userImageFile;
  bool _isLogin = true;

  void _pickImage(File image) {
    _userImageFile = image;
  }

  void _submitForm() {
    final isValid = formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin && _userImageFile == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Pick An image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (!isValid) return;
    formKey.currentState.save();
    widget._submit(
        _email, _username, _password, _userImageFile, _isLogin, context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicker(_pickImage),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'email not valid.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value.trim();
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enter username.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'password must be at least 7 characters.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value.trim();
                    },
                  ),
                  SizedBox(height: 20),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'SignUp'),
                      onPressed: _submitForm,
                    ),
                  if (!widget._isLoading)
                    FlatButton(
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
