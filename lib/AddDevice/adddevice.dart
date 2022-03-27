// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Homepage/homepage.dart';
import '../main.dart';

class AddDevice extends StatefulWidget {
  final String? flatResponse;
  final getUidVariable2;
  final token;
  const AddDevice(
      {Key? key,
      required this.flatResponse,
      required this.getUidVariable2,
      required this.token})
      : super(key: key);
  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  TextEditingController addDeviceController = TextEditingController();
  TextEditingController addRoomController = TextEditingController();
  var roomResponse;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return Container();
        } else {
          return Scaffold(
            backgroundColor: const Color(0xff121421),
            body: SafeArea(
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
                        InkWell(
                          child: const Text(" "),
                          onTap: () {},
                        ),
                        Row(
                          children: const [
                            Text("Add Place",
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 14.2,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          autofocus: true,
                          controller: addRoomController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.place),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Field Name',
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
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        child: TextFormField(
                          autofocus: true,
                          controller: addDeviceController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black54),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.place),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Device Id',
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
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          elevation: 5.0,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await sendRoomName(widget.flatResponse.toString(),
                                addRoomController.text.toString());

                            const snackBar = SnackBar(
                              content: Text('Device Added'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> sendRoomName(flatResponse, String data) async {
    String? token = widget.token.toString();
    var url = api + 'addroom/';
    var postData = {
      "user": widget.getUidVariable2,
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
      roomResponse = jsonDecode(response.body);
      await sendDeviceId(
          roomResponse.toString(), addDeviceController.text.toString());
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

  Future<void> sendDeviceId(roomResponse, String data) async {
    String? token = widget.token.toString();
    var url = api + 'addyourdevice/';
    var postData = {
      "user": widget.getUidVariable2,
      "r_id": roomResponse.toString(),
      "d_id": data.toUpperCase()
    };

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
      await getDevice(roomResponse.toString());
      return;
    } else {
      if (kDebugMode) {
        print("Device Response ${response.statusCode}");
        print("Device Response ${response.body}");
      }
      throw Exception('Failed to create Device.');
    }
  }

  Future getDevice(roomId) async {
    String? token = widget.token.toString();
    var url = api + 'addyourdevice/?r_id=' + roomId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);

      if (kDebugMode) {
        print("ANSWER $ans");
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    deviceId: ans[0]['d_id'].toString(),
                    roomId: roomResponse,
                    flatResponse: widget.flatResponse.toString(),
                  )));
    }
  }
}
