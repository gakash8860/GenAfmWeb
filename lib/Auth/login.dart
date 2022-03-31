// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:afm_genorion/Auth/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../AddDevice/adddevice.dart';
import '../Global/global.dart';
import '../Homepage/changeindex.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addDeviceController = TextEditingController();
  TextEditingController addRoomController = TextEditingController();

  int? getUidVariable2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            backgroundColor: Colors.blue[50],
            body: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  elevation: 5.0,
                  child: Form(
                    key: formKey,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.lightBlue[600],
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 85.0, right: 50.0, left: 50.0),
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
                                      "Go ahead and Login",
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
                                      "It should only take a couple of seconds to login to your account",
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
                                        return const SignUpScreen();
                                      }));
                                    },
                                    child: const Text(
                                      "Create Account",
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
                              top: 140.0, right: 70.0, left: 70.0, bottom: 5.0),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35.0,
                                    fontFamily: 'Merriweather'),
                              ),
                              const SizedBox(height: 21.0),

                              //InputField Widget from the widgets folder
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: const Text(
                                      "Username",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.lightBlue),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    color: Colors.blue[50],
                                    child: TextFormField(
                                      controller: emailController,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "username",
                                        fillColor: Colors.blue[50],
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Required";
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20.0),

                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: const Text(
                                      "Password",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.lightBlue),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 40.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.7,
                                    color: Colors.blue[50],
                                    child: TextFormField(
                                      controller: passwordController,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        hintText: "Password",
                                        fillColor: Colors.blue[50],
                                            suffixIcon: InkWell(
                                    onTap: togglePassword,
                                    child: Icon(isHiddenPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                      
                                      ),
                                      obscureText: isHiddenPassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Required";
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20.0),

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
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          isVisible = true;
                                        });
                                        await goToNextPage();
                                      } else {
                                        throw Exception("Error");
                                      }
                                    },
                                    child: isVisible? const Center(child:  CircularProgressIndicator(color: Colors.lightGreenAccent)) : const Text(
                                      "Login",
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
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: const Color(0xff121421),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: ListView(
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
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
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
                              child: Center(
                                  // child: Icon(
                                  //   Icons.notifications,
                                  //   color: Colors.white,
                                  // ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 56,
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
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 55,
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
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
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
                              controller: passwordController,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              obscureText: isHiddenPassword,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.only(top: 14.0),
                                prefixIcon: const Icon(
                                  Icons.security,
                                  color: Colors.white,
                                ),

                                suffixIcon: InkWell(
                                    onTap: togglePassword,
                                    child: Icon(isHiddenPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                // ) ,
                                hintText: 'Enter password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          buildForgotPasswordBtn(),
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
      },
    );
  }

  void togglePassword() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              isVisible = true;
            });
            await goToNextPage();
          } else {
            throw Exception("Error");
          }
        },
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: isVisible
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : const Text(
                'LOGIN',
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

  goToNextPage() async {
    formKey.currentState!.save();
    if (kDebugMode) {
      print('clear');
    }

    await checkDetails();
  }

 Future checkDetails() async {
    const url = api + 'api-token-auth/';

    var map = <String, dynamic>{};
    map['username'] = emailController.text;
    map['password'] = passwordController.text;

    final response = await http.post(Uri.parse(url), body: map);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      const storage = FlutterSecureStorage();
      await storage.write(key: "token", value: map["token"]);
      final all = await storage.readAll();

      if (kDebugMode) {
        print(all);
      }
      await getUid();
      await checkUserPlace();
    }

    if (response.statusCode == 400) {
      wrongPassword(context);

      throw ("Wrong Credentials");
    }
    if (response.statusCode == 500) {
      throw ("Internal Server Error");
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  Future getUid() async {
    const uri = api + 'getuid/';
    String? token = await getToken();
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('UiD ${response.body}');
      }
      var getUidVariable = jsonDecode(response.body);
      int getUidVariable2 = int.parse(getUidVariable.toString());
      await storeUidSharedPref(getUidVariable2);
      await getUidShared();
      await getUserDetails(getUidVariable.toString());
      if (kDebugMode) {
        print(getUidVariable2);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  storeUidSharedPref(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("uid", value);
  }

  Future getUidShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final a = prefs.getInt("uid");
    setState(() {
      getUidVariable2 = int.parse(a.toString());
    });
    if (kDebugMode) {
      print("aas $a");
    }
  }

  Future<void> getUserDetails(getUidVariable) async {
    String? token = await getToken();

    String uri = api + "getthedataofuser/?id=" + getUidVariable;
    final response = await http.get(Uri.parse(uri), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode == 200) {
      var userDataVariable = jsonDecode(response.body);
    }
  }

  Future checkUserPlace() async {
    String? token = await getToken();
    const url = api + 'addyourplace/';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      if (ans.isEmpty) {
        print("Empty");
        await placeName();
      }
      await fetchPlace();
    }
  }

  Future<void> placeName() async {
    String? token = await getToken();
    const url = api + 'addyourplace/';
    var postData = {"user": getUidVariable2, "p_type": "Farmer Place"};
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      var placeResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print("Place Response $placeResponse");
      }
      await sendFloorName(placeResponse.toString());
    } else {
      print("Place Response ${response.statusCode}");
      print("Place Response ${response.body}");
    }
  }

  Future<void> sendFloorName(placeResponse) async {
    String? token = await getToken();
    const url = api + 'addyourfloor/';
    var postData = {
      "user": getUidVariable2,
      "p_id": placeResponse.toString(),
      "f_name": "Farmer Floor"
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
      var floorResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print("floorResponse  $floorResponse");
      }
      await sendFlatName(floorResponse.toString());
    } else {
      throw Exception('Failed to create Floor.');
    }
  }

  var flatResponse;
  Future<void> sendFlatName(floorResponse) async {
    String? token = await getToken();
    const url = api + 'addyourflat/';
    var postData = {
      "user": getUidVariable2,
      "f_id": floorResponse.toString(),
      "flt_name": "Flat Name"
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
      flatResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print("Flat Response $flatResponse");
      }
      setState(() {
        isVisible = false;
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddDevice(
                  flatResponse: flatResponse,
                  getUidVariable2: getUidVariable2,
                  token: token)));
    } else {
      throw Exception('Failed to create Floor.');
    }
  }

  Future<void> fetchPlace() async {
    String? token = await getToken();
    const url = api + 'addyourplace/';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      await getFloor(ans[0]['p_id'].toString());
    }
  }

  Future<void> getFloor(placeId) async {
    String? token = await getToken();
    var url = api + "addyourfloor/?p_id=" + placeId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      await getFlat(ans[0]['f_id'].toString());
    }
  }

  Future<void> getFlat(floorId) async {
    String? token = await getToken();
    var url = api + "addyourflat/?f_id=" + floorId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      flatResponse = ans[0]['flt_id'].toString();

      await getRoom(ans[0]['flt_id'].toString());
    }
  }

  var roomResponse;
  Future<void> getRoom(flatId) async {
    String? token = await getToken();
    var url = api + "addroom/?flt_id=" + flatId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      if (ans.isEmpty) {
        setState(() {
          isVisible = false;
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddDevice(
                    flatResponse: flatResponse,
                    getUidVariable2: getUidVariable2,
                    token: token)));
      }
      setState(() {
        roomResponse = ans[0]['r_id'].toString();
      });
      await getDevice(ans[0]['r_id'].toString());
    }
  }

  Future getDevice(roomId) async {
    String? token = await getToken();
    var url = api + 'addyourdevice/?r_id=' + roomId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);

      print(ans);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeIndex(
                    deviceId: ans[0]['d_id'].toString(),
                    roomId: roomResponse,
                    flatResponse: flatResponse,
                    currentIndex: 0,
                  )));
    }
  }
}
