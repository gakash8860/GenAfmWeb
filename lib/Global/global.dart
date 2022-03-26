
// ignore_for_file: deprecated_member_use

import 'package:afm_genorion/Global/style.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/login.dart';

passwordHint() {
    return Row(
      children: const [
        Text(
          "Please use",
          style: TextStyle(color: Colors.red, fontSize: 10),
        ),
        Text(
          " special character , one capital alphabet,and numbers",
          style: TextStyle(color: Colors.red, fontSize: 10),
        )
      ],
    );
  }
  Widget buildSignUpBtn(formKey,context) {
    return Container(
 padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: MediaQuery.of(context).size.width / 1.2,
    
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
      
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

  Widget buildLoginBtn(BuildContext context) {
    return RichText(
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
    );
  }
  Widget buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          _launchURL();
        },
        padding: const EdgeInsets.only(right: 0.0),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://genorionofficial.herokuapp.com/reset_password/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
 
   wrongPassword(context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Oops !!',
      desc: 'Wrong Credentials',
      // btnCancelOnPress: () {
      //   return null;
      // },
      btnOkOnPress: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login()));
      },
    )..show();
  }
