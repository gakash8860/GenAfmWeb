// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Models/roommodel.dart';
import '../Models/usereprofile.dart';
import '../main.dart';

class AddSubUser extends StatefulWidget {
  const AddSubUser({Key? key}) : super(key: key);

  @override
  State<AddSubUser> createState() => _AddSubUserState();
}

class _AddSubUserState extends State<AddSubUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool changeWidget = false;
  List<RoomType> roomType = [];
  Future<List<RoomType>>? roomVal;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int getUidVariable2 = 0;
  var assignRoom;
  var placeResponse;
  bool indicator = false;
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    getUidShared();
    fetchPlace();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold();
        } else {
          return Scaffold(
            backgroundColor: const Color(0xff121421),
            body: SafeArea(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 18,
                    top: 26,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white)),
                      Row(
                        children: const [
                          Text("Add SubUser",
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
                              //   Icons.add,
                              //   color: Colors.white,
                              // ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                // changeWidget ?
                //  assignPlace():
                emailSend()
              ],
            )),
          );
        }
      },
    );
  }

  Widget emailSend() {
    return Column(
      children: [
        const SizedBox(
          height: 135,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 18,
            top: 56,
          ),
          child: TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,

            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: nameValid,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter Email for SubUser',
              contentPadding: const EdgeInsets.all(15),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 28,
            right: 18,
            top: 26,
          ),
          child: TextFormField(
            autofocus: true,
            textInputAction: TextInputAction.next,

            autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: nameValid,
            keyboardType: TextInputType.text,
            controller: nameController,

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter Name for SubUser',
              contentPadding: const EdgeInsets.all(15),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        // ignore: deprecated_member_use
        FlatButton(
            child: indicator
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
            shape: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(90),
            ),
            padding: const EdgeInsets.all(15),
            textColor: Colors.white,
            onPressed: () async {
              await addSubUser(emailController.text);

              // Navigator.of(context).pop();

              // await floorVal;
              // goToNextPage();
            }),
      ],
    );
  }

  Future addSubUser(String data) async {
    setState(() {
      indicator = !indicator;
    });
    String? token = await getToken();
    const url = api + 'subuseraccess/';
    var postData = {"emailtest": data, "email": data};
    final response =
        await http.post(Uri.parse(url), body: jsonEncode(postData), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode == 201) {
      setState(() {
        changeWidget = true;
      });

      await _assignPlace();
    } else {
      var res = jsonDecode(response.body);
      if (res
          .toString()
          .contains("subuseraccess with this email already exists.")) {
        _showDialog(context);
      }
      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }
    }
  }

  Future _assignPlace() async {
    String? token = await getToken();
    const url = api + 'subuserpalceaccess/';
    var postData = {
      "user": getUidVariable2,
      "email": emailController.text,
      "p_id": placeResponse,
      "name": nameController.text,
      "owner_name": userProfile!.firstName + " " + userProfile!.lastName
    };
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $token',
        },
        body: jsonEncode(postData));
    if (response.statusCode == 201) {
      setState(() {
        indicator = !indicator;
      });
      const snackBar = SnackBar(
        content: Text('All Set ✔'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("REREEREESA ${response.statusCode}");
      print("REREEREESA ${response.body}");
    }
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Alert"),
        content: const Text("subuseraccess with this email already exists."),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
              child: const Text("No"),
              onPressed: () {
                setState(() {
                  changeWidget = true;
                });
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
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
      setState(() {
        placeResponse = ans[0]['p_id'].toString();
      });
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
      var flatResponse = ans[0]['flt_id'].toString();

      setState(() {
        roomVal = getRoom(ans[0]['flt_id'].toString());
      });
    }
  }

  Future<List<RoomType>> getRoom(flatId) async {
    String? token = await getToken();
    var url = api + "addroom/?flt_id=" + flatId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      setState(() {
        roomType = ans.map((e) => RoomType.fromJson(e)).toList();
      });
      return roomType;
    }
    return roomType;
  }

  Future<void> getUidShared() async {
    final SharedPreferences prefs = await _prefs;
    final a = prefs.getInt("uid");
    setState(() {
      getUidVariable2 = int.parse(a.toString());
    });
    userProfile = await getUserDetails(getUidVariable2.toString());
    if (kDebugMode) {
      print("aas $a");
    }
    return;
  }
}
