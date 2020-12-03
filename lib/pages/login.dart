import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopapp/commons/loading.dart';
import 'package:shopapp/pages/home.dart';
import 'package:shopapp/pages/signup.dart';
import 'package:shopapp/provider/user_provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  SharedPreferences preferences;
  bool hidePass = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Center(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Image.asset(
                                        'images/cart.png',
                                        width: 120.0,
                                        // height: 240.0,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.withOpacity(0.2),
                                    elevation: 0.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: ListTile(
                                        title: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            icon: Icon(Icons.alternate_email),
                                          ),
                                          validator: (value) => EmailValidator
                                                  .validate(value)
                                              ? null
                                              : "Please make sure your email address is valid",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.grey.withOpacity(0.2),
                                    elevation: 0.0,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: ListTile(
                                        title: TextFormField(
                                          controller: _password,
                                          obscureText: hidePass,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            icon: Icon(Icons.lock_outline),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The password field cannot be empty";
                                            } else if (value.length < 6) {
                                              return "the password has to be at least 6 characters long";
                                            }
                                            return null;
                                          },
                                        ),
                                        trailing: IconButton(
                                            icon: Icon(
                                              Icons.remove_red_eye,
                                              size: 12.0,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (hidePass == true) {
                                                  hidePass = false;
                                                } else {
                                                  hidePass = true;
                                                }
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.deepOrange,
                                      elevation: 0.0,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            if (!await user.signIn(
                                                _email.text, _password.text))
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Sign in failed")));
                                          }
                                        },
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Login",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Forgot password",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUp()));
                                        },
                                        child: Text(
                                          "Create an account",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Or sign in with",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MaterialButton(
                                          onPressed: () {},
                                          child: Image.asset("images/gl.png",
                                              width: 60),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   children: <Widget>[
                                //     Padding(
                                //       padding: const EdgeInsets.fromLTRB(
                                //           14.0, 8.0, 14.0, 8.0),
                                //       child: Material(
                                //         child: MaterialButton(
                                //           onPressed: () {},
                                //           child:
                                //               Image.asset("images/fb.png", width: 60),
                                //         ),
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.fromLTRB(
                                //           14.0, 8.0, 14.0, 8.0),
                                //       child: Material(
                                //         child: MaterialButton(
                                //           onPressed: () {},
                                //           child:
                                //               Image.asset("images/gl.png", width: 60),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: loading ?? true,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.9),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ))
              ],
            ),
    );
  }
}
