import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/commons/common.dart';
import 'package:shopapp/commons/loading.dart';
import 'package:shopapp/db/auth.dart';
import 'package:shopapp/db/users.dart';
import 'package:shopapp/pages/home.dart';
import 'package:shopapp/provider/user_provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  //TextEditingController _confirmPasswordController = TextEditingController();
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  bool loading = false;
  Auth auth = Auth();

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
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Image.asset(
                                        'images/cart.png',
                                        width: 120.0,
                                        //height: 240.0,
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
                                          controller: _name,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Full name",
                                            icon: Icon(Icons.person_outline),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The name field cannot be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
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
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                //   child: new Container(
                                //     child: Row(
                                //       children: <Widget>[
                                //         Expanded(
                                //             child: ListTile(
                                //           title: Text("male",
                                //               textAlign: TextAlign.end,
                                //               style: TextStyle(color: Colors.black)),
                                //           trailing: Radio(
                                //               value: "male",
                                //               groupValue: groupValue,
                                //               onChanged: (e) => valueChanged(e)),
                                //         )),
                                //         Expanded(
                                //             child: ListTile(
                                //           title: Text("female",
                                //               textAlign: TextAlign.end,
                                //               style: TextStyle(color: Colors.black)),
                                //           trailing: Radio(
                                //               value: "female",
                                //               groupValue: groupValue,
                                //               onChanged: (e) => valueChanged(e)),
                                //         )),
                                //       ],
                                //     ),
                                //   ),
                                // ),
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
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                //   child: Material(
                                //     borderRadius: BorderRadius.circular(20.0),
                                //     color: Colors.white.withOpacity(0.8),
                                //     elevation: 0.0,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(left: 12.0),
                                //       child: ListTile(
                                //         title: TextFormField(
                                //           controller: _confirmasswordController,
                                //           obscureText: hidePass,
                                //           decoration: InputDecoration(
                                //               hintText: "Confirm Password",
                                //               icon: Icon(Icons.lock_outline),
                                //               border: OutlineInputBorder()),
                                //           validator: (value) {
                                //             if (value.isEmpty) {
                                //               return "The password field cannot be empty";
                                //             } else if (value.length < 6) {
                                //               return "the password has to be at least 6 characters long";
                                //             } else if (_passwordTextController.text !=
                                //                 value) {
                                //               return "the password do not match";
                                //             }
                                //             return null;
                                //           },
                                //         ),
                                //         trailing: IconButton(
                                //             icon: Icon(
                                //               Icons.remove_red_eye,
                                //               size: 12.0,
                                //             ),
                                //             onPressed: () {
                                //               setState(() {
                                //                 hidePass = false;
                                //               });
                                //             }),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: deepOrange,
                                      elevation: 0.0,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            if (!await user.signUp(_name.text,
                                                _email.text, _password.text))
                                              _key.currentState.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          "Sign up failed")));
                                          }
                                        },
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          "Sign Up",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "I already have an account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: deepOrange, fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Or sign Up with",
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
                                //           onPressed: () async {
                                //             FirebaseUser user =
                                //                 await auth.googleSignIn();
                                //             if (user == null) {
                                //               _userServices.createUser({
                                //                 "name": user.displayName,
                                //                 "photo": user.photoUrl,
                                //                 "email": user.email,
                                //                 "userId": user.uid
                                //               });
                                //               changeScreenReplacement(
                                //                   context, HomePage());
                                //             }
                                //           },
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

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

  Future validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .then((user) => {
                  _userServices.createUser({
                    "username": user.user.displayName,
                    "email": user.user.email,
                    "userId": user.user.uid,
                    "gender": gender,
                  })
                })
            .catchError((err) => {err.toString()});

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
