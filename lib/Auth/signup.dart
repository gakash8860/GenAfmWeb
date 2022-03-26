// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Widgets/input_filed.dart';
import '../main.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isVisible = false;
  bool checkPlace = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static bool isHiddenPassword = true;
  SignupData data = SignupData();
  TextEditingController nameEditing = TextEditingController();
  bool onChangedHint = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return Scaffold(
          backgroundColor: Colors.blue[50],
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(size.height > 770
                  ? 64
                  : size.height > 670
                      ? 32
                      : 16),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                elevation: 5.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: size.width / 3.3,
                      height: size.height,
                      color: Colors.lightBlue[600],
                      child: Padding(
                        padding: EdgeInsets.all(size.height > 770
                            ? 64
                            : size.height > 670
                                ? 32
                                : 16),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 60.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: const Text(
                                  "Let's get you set up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: const Text(
                                  "It should only take a couple of minutes to create your account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              FlatButton(
                                color: Colors.lightBlue,
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Login();
                                  }));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 70.0, left: 70.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 35.0,
                                fontFamily: 'Merriweather'),
                          ),
                          const SizedBox(height: 21.0),

                          //InputField Widget from the widgets folder
                          InputField(
                              label: "Full Name",
                              content: "Full Name",
                              editingController: nameEditing),

                          const SizedBox(height: 20.0),

                          //Gender Widget from the widgets folder
                          InputField(
                              label: "Email",
                              content: "Email",
                              editingController: nameEditing),

                          const SizedBox(height: 20.0),

                          //InputField Widget from the widgets folder
                          const InputField(
                              label: "Phone", content: "03/04/2000"),

                          const SizedBox(height: 20.0),

                          //InputField Widget from the widgets folder
                          const InputField(
                              label: "Email", content: "anything@site.com"),

                          const SizedBox(height: 20.0),

                          const InputField(
                              label: "Password", content: "********"),

                          const SizedBox(height: 20.0),

                          //Membership Widget from the widgets folder
                          // Aggrenment(),

                          const SizedBox(
                            height: 40.0,
                          ),

                          Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 170.0,
                              ),
                              FlatButton(
                                color: Colors.grey[200],
                                onPressed: () {},
                                child: const Text("Cancel"),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              FlatButton(
                                color: Colors.lightBlue,
                                onPressed: () {},
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: const Color(0xff121421),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 18,
                      top: 36,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // IconButton(
                        //     onPressed: () {
                        //       // Navigator.pop(context);
                        //     },
                        //     icon: const Icon(
                        //       Icons.arrow_back_ios,
                        //       color: Colors.white,
                        //     )),
                        Row(
                          children: const [
                            Text("",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(360),
                          onTap: () {},
                          child: const SizedBox(
                            height: 35,
                            width: 35,
                            child: Center(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6CA8F1),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              // ignore: unused_local_variable
                              var fName = value!;
                              if (value.contains(" ")) {
                                int v = value.indexOf(" ");
                                var ans = value.substring(v);
                                var first = value.substring(0, v);
                                if (kDebugMode) {
                                  print("vale $ans");
                                }
                                setState(() {
                                  data.lName = ans;
                                  data.fName = first;
                                });
                              } else {
                                setState(() {
                                  data.fName = value;
                                  data.lName = " .";
                                });
                                if (kDebugMode) {
                                  print("else ${data.lName}");
                                }
                              }
                            },
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Full Name',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6CA8F1),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                data.email = value!;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintText: 'Email ',
                              // hintStyle: kHintTextStyle,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6CA8F1),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              setState(() {
                                data.pno = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              hintText: 'Phone Number ',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6CA8F1),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              } else {
                                setState(() {
                                  data.password = value;
                                });
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                data.password = value!;
                              });
                            },
                            enableSuggestions: false,
                            obscureText: isHiddenPassword,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  onChangedHint = true;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.security,
                                color: Colors.white,
                              ),
                              // suffixIcon: InkWell(

                              // ) ,
                              hintText: 'Enter password',
                            ),
                          ),
                        ),
                        onChangedHint
                            ? passwordHint()
                            : const SizedBox(
                                height: 10,
                              ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            // color: Color(0xFF6CA8F1),
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: 60.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value != data.password) {
                                if (kDebugMode) {
                                  print("object $value ->  ${data.password} ");
                                }
                                return "Password not match";
                              }
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              setState(() {
                                data.password2 = value;
                              });
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                data.password2 = value!;
                              });
                            },
                            obscureText: isHiddenPassword,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.security,
                                color: Colors.white,
                              ),
                              // suffixIcon: InkWell(

                              // ) ,
                              hintText: 'confirm password',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        _buildSignUpBtn(),
                        _buildLoginBtn()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  goToNextPage() {
    setState(() {
      isVisible = true;
    });
    formKey.currentState!.save();
    checkDetails(data);
  }

  checkDetails(SignupData data) async {
    const url = api + 'regflu';
    var map = <String, dynamic>{};
    map['username'] = data.email;
    map['password1'] = data.password;
    map['password2'] = data.password;
    map['first_name'] = data.fName;
    map['last_name'] = data.lName;
    map['email'] = data.email;
    map['phone_no'] = data.pno;
    final response = await http.post(
      Uri.parse(url),
      body: map,
      encoding: Encoding.getByName("utf-8"),
    );
    if (kDebugMode) {
      print(map);
    }
    if (response.statusCode == 200) {
      const snackBar = SnackBar(
        content: Text('Please Login'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      if (response.statusCode == 400) {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>WrongPassword()));
        throw ("Details Error");
      }
      if (response.statusCode == 500) {
        if (kDebugMode) {
          print(response.statusCode);
          // print(response.body);
        }
        setState(() {
          isVisible = false;
        });
        // print(response.body);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>WrongPassword()));
        throw ("Internal Server Error");
      }
    }
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            goToNextPage();
          } else {
            if (kDebugMode) {
              print("object");
            }
          }
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: const Text(
          'SignUp',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupData {
  String email = '';
  String password = '';
  String password2 = '';
  String fName = '';
  String lName = '';
  String pno = '';
  String username = '';

  checkPassword() {
    if (password.length != password2.length) {
      throw ("Password Doesn't match");
    } else {
      return null;
    }
  }
}
