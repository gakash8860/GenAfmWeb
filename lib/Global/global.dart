// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:afm_genorion/Global/style.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/login.dart';
import '../Models/usereprofile.dart';
import '../main.dart';

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

Widget buildSignUpBtn(formKey, context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 25.0),
    width: MediaQuery.of(context).size.width / 1.2,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {},
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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    },
  )..show();
}

Future<String?> getToken() async {
  var storage = const FlutterSecureStorage();
  final token = await storage.read(key: "token");
  return token;
}
  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    print("TimeNOw $timeNow");
    if (timeNow < 12) {
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }
  Future<void> sendRoomName(flatResponse, String data,getUidVariable2,addDeviceController,context) async {
    String? token = await getToken();
    const url = api + 'addroom/';
    var postData = {
      "user": getUidVariable2,
      "r_name": data,
      "flt_id": flatResponse.toString(),
    };
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 201) {
      var roomResponse = jsonDecode(response.body);
      await sendDeviceId(roomResponse.toString(), addDeviceController,getUidVariable2,context);
      if (kDebugMode) {
        print("Room Response $roomResponse");
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      throw Exception('Failed to create Room.');
    }
  }
  Future<void> sendDeviceId(roomResponse, String data,getUidVariable2,context) async {
    String? token = await getToken();
    const url = api + 'addyourdevice/';
    var postData = {
      "user": getUidVariable2,
      "r_id": roomResponse.toString(),
      "d_id": data.toUpperCase()
    };
    if (kDebugMode) {
      print("data $data");
    }
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (kDebugMode) {
        print("Device Response ${response.body}");
      }
      const snackBar = SnackBar(
        content: Text('Device Added'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);


      return;
    } else {
      if (kDebugMode) {
        print("Device Response ${response.body}");
        print("Device Response ${response.statusCode}");
      }
      throw Exception('Failed to create Device.');
    }
  }
  Future<UserProfile?> getUserDetails(getUidVariable) async {
    UserProfile? userProfile;
    String? token = await getToken();

    String uri = api + "getthedataofuser/?id=" + getUidVariable;
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode == 200) {
      var userDataVariable = jsonDecode(response.body);
      print("ANns $userDataVariable");
      userProfile = UserProfile.fromJson(userDataVariable);
      return userProfile;
    }   return userProfile;
  }

  

Widget actionButton(String text){
  return Container(
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.blueAccent.shade700,
      borderRadius: const BorderRadius.all(
        Radius.circular(25),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.shade700.withOpacity(0.2),
          spreadRadius: 4,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );


}