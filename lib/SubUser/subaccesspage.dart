import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Models/devicemodel.dart';
import '../Models/roommodel.dart';
import '../Models/sensor.dart';
import '../main.dart';

class SubAccessPage extends StatefulWidget {
  final String? pId;
  final String? ownerName;
  final String? roomId;
  final String? flatId;
  final String? dId;
  const SubAccessPage(
      {Key? key, this.ownerName, this.pId, this.dId, this.roomId, this.flatId})
      : super(key: key);
  @override
  State<SubAccessPage> createState() => _SubAccessPageState();
}

class _SubAccessPageState extends State<SubAccessPage> {
    Future? switchFuture;
  bool changeDeviceBool = true;
  SensorData? sensorData;
  var deviceId;
  String? flatResponse;
  Future? sensorVal;
  static const IconData agriculture =
  IconData(0xe063, fontFamily: 'MaterialIcons');
  ScrollController scrollController = ScrollController();
  String? greets;
  List<RoomType> rm = [];
  bool statusOfDevice = true;
  Future? nameFuture;
  var deviceIdForScroll;
  List responseGetData = [];
  List namesDataList = [];
  int? newIndex;
  List<bool> loading = List.filled(12, false);
  var icon1 = Icons.ac_unit;
  var icon2 = FontAwesomeIcons.iceCream;
  var icon3 = FontAwesomeIcons.lightbulb;
  var icon4 = FontAwesomeIcons.fan;
  var icon5 = Icons.wash_sharp;
  var icon6 = FontAwesomeIcons.fire;
  var icon7 = FontAwesomeIcons.lightbulb;
  var icon8 = FontAwesomeIcons.lightbulb;
  var icon9 = FontAwesomeIcons.lightbulb;
  var icon10 = FontAwesomeIcons.lightbulb;
  var icon11 = FontAwesomeIcons.lightbulb;
  var icon12 = FontAwesomeIcons.lightbulb;
  List changeIcon = List.filled(12, null);
  Future<List<RoomType>>? roomVal;
  Future<List<DeviceType>>? deviceVal;
  bool pleaseSelect = false;
  List<DeviceType> dv = [];
  List<String> iconCode = [
    '001',
    '002',
    '003',
    '004',
    '005',
    '006',
    '007',
    '008',
    '009',
    '010',
    '011'
  ];
  String? selectedDevice;
  var roomResponse;


 @override
  void initState() {
    super.initState();
    if (widget.roomId != null && widget.dId != null && widget.flatId != null) {
      print("Go to ====>>>>>>  IF");
      checkNavigation();
    } else {
      print("Go to ====>>>> else");
      greets = greetingMessage();
      getFloor(widget.pId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
        return Scaffold(
        backgroundColor: const Color(0xff121421),
        body: SafeArea(
          child: changeDeviceBool ? customScrollUiWeb() : changeDevice(),
        ));
        } else {
    return Scaffold(
        backgroundColor: const Color(0xff121421),
        body: SafeArea(
          child: changeDeviceBool ? customScrollUi() : changeDevice(),
        ));
        }
      },
    );
  }
  
    Widget customScrollUi() {
    return FutureBuilder(
        future: sensorVal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.greenAccent,
                            Color.fromARGB(255, 242, 243, 245)
                          ]),
                      color: Color.fromARGB(255, 233, 216, 67),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        // bottomLeft: Radius.circular(30),
                        // bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            CircularProfileAvatar(
                              '',
                              child: Image.asset(
                                'assets/images/genLogo.png',
                                fit: BoxFit.cover,
                              ),
                              radius: 30,
                              elevation: 5,
                              onTap: () {},
                              cacheImage: true,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  greets.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(179, 85, 84, 84)),
                                ),
                                // Container(
                                //     margin: const EdgeInsets.only(right: 35),
                                //     child: Text(
                                //       "Assigned By ${widget.ownerName.toString()}",
                                //       style: const TextStyle(
                                //           color:
                                //               Color.fromARGB(179, 85, 84, 84)),
                                //     ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          height: 105,
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 194, 204, 221),
                                  Color.fromARGB(255, 213, 221, 238)
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                    "Assigned By ${widget.ownerName.toString()}"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    deviceVal = null;

                                    roomVal = getRoomForChange(widget.flatId ??
                                        flatResponse.toString());
                                    changeDeviceBool = !changeDeviceBool;
                                  });
                                },
                                child: Text(
                                    rm[0].rName.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  title: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.update,
                            color: Colors.blueGrey,
                          ),
                          onTap: () async {
                            await getSensorData(deviceId);
                          },
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 14,
                          height: 14,

                          decoration: BoxDecoration(
                              color:
                                  statusOfDevice ? Colors.green : Colors.grey,
                              shape: BoxShape.circle),
                          // child: ...
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const LocalSensorData()));
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.fire,
                                color: Colors.yellow,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor1.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              FontAwesomeIcons.cloud,
                              color: Colors.orange,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor2.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              FontAwesomeIcons.water,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor3.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              FontAwesomeIcons.temperatureLow,
                              color: Colors.amberAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor4.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              FontAwesomeIcons.cloudRain,
                              color: Colors.brown,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor5.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              Icons.electrical_services,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor6.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              agriculture,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor7.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            const Icon(
                              MdiIcons.cow,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sensorData!.sensor8.toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        InkWell(
                          onTap: () async {
                            String googleUrl =
                                'https://www.google.co.in/maps/search/?api=1&query=${sensorData!.sensor9.toString()},${sensorData!.sensor10.toString()}';
                            if (await canLaunch(googleUrl)) {
                              await launch(googleUrl);
                            } else {
                              throw 'Could not open the map.';
                            }
                            print('vv');
                          },
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < 1) {
                    if (dv.isEmpty) {
                      return Container(
                        color: Colors.blue,
                        height: 45,
                      );
                    }

                    return deviceContainer(widget.dId ?? deviceId.toString());
                  }
                  return null;
                  // return Container();
                }))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

    Widget customScrollUiWeb() {
    return FutureBuilder(
        future: sensorVal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.greenAccent,
                            Color.fromARGB(255, 242, 243, 245)
                          ]),
                      color: Color.fromARGB(255, 233, 216, 67),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        // bottomLeft: Radius.circular(30),
                        // bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            CircularProfileAvatar(
                              '',
                              child: Image.asset(
                                'assets/images/genLogo.png',
                                fit: BoxFit.cover,
                              ),
                              radius: 30,
                              elevation: 5,
                              onTap: () {},
                              cacheImage: true,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  greets.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(179, 85, 84, 84)),
                                ),
                                // Container(
                                //     margin: const EdgeInsets.only(right: 35),
                                //     child: Text(
                                //       "Assigned By ${widget.ownerName.toString()}",
                                //       style: const TextStyle(
                                //           color:
                                //               Color.fromARGB(179, 85, 84, 84)),
                                //     ))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          height: 105,
                          width: MediaQuery.of(context).size.width / 4.5,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 194, 204, 221),
                                  Color.fromARGB(255, 213, 221, 238)
                                ]),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                                                const SizedBox(height: 25,),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                    "Assigned By ${widget.ownerName.toString()}"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    deviceVal = null;

                                    roomVal = getRoomForChange(widget.flatId ??
                                        flatResponse.toString());
                                    changeDeviceBool = !changeDeviceBool;
                                  });
                                },
                                child: Text(
                                    rm[0].rName.toString()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  title: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: const Icon(
                              Icons.update,
                              color: Colors.blueGrey,
                            ),
                            onTap: () async {
                              await getSensorData(deviceId);
                            },
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                            width: 14,
                            height: 14,

                            decoration: BoxDecoration(
                                color:
                                    statusOfDevice ? Colors.green : Colors.grey,
                                shape: BoxShape.circle),
                            // child: ...
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LocalSensorData()));
                            },
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Icon(
                                  FontAwesomeIcons.fire,
                                  color: Colors.yellow,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  sensorData!.sensor1.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.cloud,
                                color: Colors.orange,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor2.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.water,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor3.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.temperatureLow,
                                color: Colors.amberAccent,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor4.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                FontAwesomeIcons.cloudRain,
                                color: Colors.brown,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor5.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                Icons.electrical_services,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor6.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                agriculture,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor7.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              const Icon(
                                MdiIcons.cow,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sensorData!.sensor8.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          InkWell(
                            onTap: () async {
                              String googleUrl =
                                  'https://www.google.co.in/maps/search/?api=1&query=${sensorData!.sensor9.toString()},${sensorData!.sensor10.toString()}';
                              if (await canLaunch(googleUrl)) {
                                await launch(googleUrl);
                              } else {
                                throw 'Could not open the map.';
                              }
                              print('vv');
                            },
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Location",
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < 1) {
                    if (dv.isEmpty) {
                      return Container(
                        color: Colors.blue,
                        height: 45,
                      );
                    }

                    return deviceContainer(widget.dId ?? deviceId.toString());
                  }
                  return null;
                  // return Container();
                }))
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }



    Widget deviceContainer(dId) {
    deviceIdForScroll = dId;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 1.65,
      child: SingleChildScrollView(
        // controller: scrollController,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 180,
                ),
                const Text("Device Id ->",
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  dId.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
            Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 1.55,
              child: GridView.count(
                    crossAxisSpacing: 8,
              childAspectRatio: 2 / 1.8,
              mainAxisSpacing: 4,
              crossAxisCount: 4,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(12, (index) {
                  newIndex = index;
                  return SizedBox(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            alignment: const FractionalOffset(1.0, 0.0),
                            // alignment: Alignment.bottomRight,
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 10),
                            margin: index % 2 == 0
                                ? const EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5)
                                : const EdgeInsets.fromLTRB(7.5, 7.5, 15, 7.5),
                            // margin: EdgeInsets.fromLTRB(15, 7.5, 7.5, 7.5),
                            decoration: BoxDecoration(
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      blurRadius: 14.2,
                                      offset: Offset(2, 5),
                                      color: Color.fromARGB(255, 182, 181, 181))
                                ],
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.none,
                                    color: const Color(0xffa3a3a3)),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: FutureBuilder(
                                        future: nameFuture,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return TextButton(
                                              child: Text(
                                                namesDataList[index].toString(),
                                                // index.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                              onPressed: () async {
                                                // _createAlertDialogForNameDeviceBox(
                                                //     context,
                                                //     index,
                                                //     dId.toString());
                                              },
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.5,
                                        ),
                                        child: FutureBuilder(
                                            future: switchFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return loading[index]
                                                    ? loadingContainer()
                                                    : Switch(
                                                        // activeText: "On",
                                                        // inactiveText: "Off",
                                                        value: responseGetData[
                                                                    index] ==
                                                                0
                                                            ? false
                                                            : true,
                                                        onChanged:
                                                            (value) async {
                                                          setState(() {
                                                            loading[index] =
                                                                true;
                                                          });
                                                         if (responseGetData[
                                                                  index] ==
                                                              0) {
                                                            setState(() {
                                                              responseGetData[
                                                                  index] = 1;
                                                            });
                                                            await dataUpdate(
                                                                dId.toString());

                                                            await getPinStatusData(
                                                                dId.toString());

                                                            setState(() {
                                                              loading[index] =
                                                                  false;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              responseGetData[
                                                                  index] = 0;
                                                            });
                                                            await dataUpdate(
                                                                dId.toString());

                                                            await getPinStatusData(
                                                                dId.toString());

                                                            setState(() {
                                                              loading[index] =
                                                                  false;
                                                            });
                                                          }
                                                          
                                                        }
                                                        );
                                              } else {
                                                return Container();
                                              }
                                            })),
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {},
                                    child: Icon(changeIcon[index]))
                              ],
                            )),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
  String? selectedRoom;

  Widget changeDevice() {
    return Container(
      margin: const EdgeInsets.only(bottom: 45),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onTap: () {
                    setState(() {
                      changeDeviceBool = !changeDeviceBool;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            FutureBuilder<List<RoomType>>(
                future: roomVal,
                builder: (c, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        "No Devices on this place",
                        style: TextStyle(color: Colors.white),
                      ));
                    }
                    return Container(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: Container(
                          margin: const EdgeInsets.only(right: 35, left: 35),
                          width: MediaQuery.of(context).size.width * 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 30,
                                    offset: Offset(20, 20))
                              ],
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )),
                          child: DropdownButtonFormField<RoomType>(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            dropdownColor: Colors.white70,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            hint: const Text('Select Field'),
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            items: snapshot.data!.map((selectedRoom) {
                              return DropdownMenuItem<RoomType>(
                                value: selectedRoom,
                                child: Text(selectedRoom.rName),
                              );
                            }).toList(),
                            onChanged: (selectedRoom) {
                              setState(() {
                                deviceVal = getDeviceForDropDown(
                                    selectedRoom!.rId.toString());
                                this.selectedRoom = selectedRoom.rId.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            pleaseSelect
                ? const Center(
                    child: Text(
                      "Please Select First Field and Then Device",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container(),
            FutureBuilder<List<DeviceType>>(
                future: deviceVal,
                builder: (c, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text("No Devices on this place"));
                    }
                    return Container(
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 2,
                          margin: const EdgeInsets.only(right: 35, left: 35),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 30,
                                    offset: Offset(20, 20))
                              ],
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )),
                          child: DropdownButtonFormField<DeviceType>(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            dropdownColor: Colors.white70,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 28,
                            hint: const Text('Select Device'),
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            items: snapshot.data!.map((selectDevice) {
                              return DropdownMenuItem<DeviceType>(
                                value: selectDevice,
                                child: Text(selectDevice.dId),
                              );
                            }).toList(),
                            onChanged: (selectDevice) {
                              // if (deviceVal != null) {
                              setState(() {
                                selectedDevice = selectDevice!.dId.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(
              height: 9,
            ),
            Container(
                margin: const EdgeInsets.only(left: 175),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color.fromARGB(255, 54, 223, 186)),
                child: MaterialButton(
                  onPressed: () {
                    if (selectedDevice != null && selectedRoom != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubAccessPage(
                                    ownerName: widget.ownerName,
                                    pId: widget.pId,
                                    flatId: flatResponse,
                                    roomId: selectedRoom,
                                    dId: selectedDevice,
                                  )));
                    } else {
                      setState(() {
                        pleaseSelect = !pleaseSelect;
                      });
                      return;
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
 
  loadingContainer() {
    return const CircularProgressIndicator(
        // color:Colors.,
        );
  }
 
  Future<void> dataUpdate(dId) async {
    String? token = await getToken();
    var url = api + 'getpostdevicePinStatus/?d_id=' + dId;
    Map data = {
      'put': 'yes',
      "d_id": dId,
      'pin1Status': responseGetData[0],
      'pin2Status': responseGetData[1],
      'pin3Status': responseGetData[2],
      'pin4Status': responseGetData[3],
      'pin5Status': responseGetData[4],
      'pin6Status': responseGetData[5],
      'pin7Status': responseGetData[6],
      'pin8Status': responseGetData[7],
      'pin9Status': responseGetData[8],
      'pin10Status': responseGetData[9],
      'pin11Status': responseGetData[10],
      'pin12Status': responseGetData[11],
    };

    final response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return;
    } else {}
  }

  Future<bool> getPinStatusData(dId) async {
    String? token = await getToken();
    var url = api + 'getpostdevicePinStatus/?d_id=' + dId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print("Token ${response.body}");
      }
      setState(() {
        responseGetData = [
          data['pin1Status'],
          data['pin2Status'],
          data['pin3Status'],
          data['pin4Status'],
          data['pin5Status'],
          data['pin6Status'],
          data['pin7Status'],
          data['pin8Status'],
          data['pin9Status'],
          data['pin10Status'],
          data['pin11Status'],
          data['pin12Status'],
        ];
      });
      setState(() {
        String a = data['pin20Status'].toString();
        if (kDebugMode) {
          print('ForLoop123 $a');
        }
        int aa = int.parse(a);
        if (kDebugMode) {
          print('double $aa');
        }

        int ms =
            // ((DateTime.now().millisecondsSinceEpoch) / 1000).round() + 19700;
            ((DateTime.now().millisecondsSinceEpoch) / 1000).round() -
                100; // -100 for checking a difference for 100 seconds in current time
        if (kDebugMode) {
          print('CheckMs $ms');
        }
        // print('Checkaa ${aa}');
        if (aa >= ms) {
          if (kDebugMode) {
            print('ifelse');
          }
          setState(() {
            statusOfDevice = true;
          });
        } else {
          if (kDebugMode) {
            print('ifelse2');
          }
          setState(() {
            statusOfDevice = false;
          });
        }
        return;
      });
      nameFuture = getPinName(deviceId.toString(), 0);
      return true;
    }

    return false;
  }
 
  Future<bool> getPinName(dId, index) async {
    String? token = await getToken();
    var url = api + "editpinnames/?d_id=" + dId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      var pinName = jsonDecode(response.body);

      String pin1 = pinName['pin1Name'];

      var indexOfPin1Name = pin1.indexOf(',');
      var pin1FinalName = pin1.substring(0, indexOfPin1Name);

      if (kDebugMode) {
        print('indexofpppp $namesDataList');
      }

      String pin2 = pinName['pin2Name'];
      var indexOfPin2Name = pin2.indexOf(',');
      var pin2FinalName = pin2.substring(0, indexOfPin2Name);
      if (kDebugMode) {
        print('indexofpppppin2 $pin2');
      }

      String pin3 = pinName['pin3Name'];
      var indexOfPin3Name = pin3.indexOf(',');
      var pin3FinalName = pin3.substring(0, indexOfPin3Name);
      if (kDebugMode) {
        print('indexofpppppin2 $pin3');
      }

      String pin4 = pinName['pin4Name'];
      var indexOfPin4Name = pin4.indexOf(',');
      var pin4FinalName = pin4.substring(0, indexOfPin4Name);

      String pin5 = pinName['pin5Name'];
      var indexOfPin5Name = pin5.indexOf(',');
      var pin5FinalName = pin5.substring(0, indexOfPin5Name);

      String pin6 = pinName['pin6Name'];
      var indexOfPin6Name = pin6.indexOf(',');
      var pin6FinalName = pin6.substring(0, indexOfPin6Name);

      String pin7 = pinName['pin7Name'];
      var indexOfPin7Name = pin7.indexOf(',');
      var pin7FinalName = pin7.substring(0, indexOfPin7Name);

      String pin8 = pinName['pin8Name'];
      var indexOfPin8Name = pin8.indexOf(',');
      var pin8FinalName = pin8.substring(0, indexOfPin8Name);

      String pin9 = pinName['pin9Name'];
      var indexOfPin9Name = pin9.indexOf(',');
      var pin9FinalName = pin9.substring(0, indexOfPin9Name);

      String pin10 = pinName['pin10Name'];
      var indexOfPin10Name = pin10.indexOf(',');
      var pin10FinalName = pin9.substring(0, indexOfPin10Name);

      String pin11 = pinName['pin11Name'];
      var indexOfPin11Name = pin11.indexOf(',');
      var pin11FinalName = pin11.substring(0, indexOfPin11Name);

      String pin12 = pinName['pin12Name'];

      var indexOfPin12Name = pin12.indexOf(',');
      var pin12FinalName = pin12.substring(0, indexOfPin12Name);
      setState(() {
        namesDataList = [
          pin1FinalName,
          pin2FinalName,
          pin3FinalName,
          pin4FinalName,
          pin5FinalName,
          pin6FinalName,
          pin7FinalName,
          pin8FinalName,
          pin9FinalName,
          pin10FinalName,
          pin11FinalName,
          pin12FinalName,
        ];
      });
      for (int i = 0; i < namesDataList.length; i++) {
        if (pin1.contains('001') ||
            pin1.contains('002') ||
            pin1.contains('003') ||
            pin1.contains('004') ||
            pin1.contains('005') ||
            pin1.contains('006') ||
            pin1.contains('007') ||
            pin1.contains('008') ||
            pin1.contains('009') ||
            pin1.contains('0010') ||
            pin1.contains('0011')) {
          // icon1=Icons.ac_unit;
          if (pin1.contains('001')) {
            setState(() {
              changeIcon[index] = icon1;
            });
          }
          if (pin1.contains('002')) {
            changeIcon[index] = icon2;
          }
          if (pin1.contains('003')) {
            // changeIcon[index]=icon3;
            setState(() {
              changeIcon[index] = icon3;
            });
          }
          if (pin1.contains('004')) {
            changeIcon[index] = icon4;
          }
          if (pin1.contains('005')) {
            changeIcon[index] = icon5;
          }
          if (pin1.contains('007')) {
            changeIcon[index] = icon6;
          }
          if (pin1.contains('008')) {
            changeIcon[index] = icon7;
          }
          if (pin1.contains('009')) {
            changeIcon[index] = icon8;
          }
          if (pin1.contains('0010')) {
            changeIcon[index] = icon9;
          }
          if (pin1.contains('0011')) {
            changeIcon[index] = icon10;
          }
          if (pin1.contains('0012')) {
            changeIcon[index] = icon12;
          }
        }

        if (pin2.contains('001') ||
            pin2.contains('002') ||
            pin2.contains('003') ||
            pin2.contains('004') ||
            pin2.contains('005') ||
            pin2.contains('006') ||
            pin2.contains('007') ||
            pin2.contains('008') ||
            pin2.contains('009') ||
            pin2.contains('0010') ||
            pin2.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin2.contains('001')) {
            changeIcon[index + 1] = icon1;
          }
          if (pin2.contains('002')) {
            changeIcon[index + 1] = icon2;
          }
          if (pin2.contains('003')) {
            changeIcon[index + 1] = icon3;
          }
          if (pin2.contains('004')) {
            changeIcon[index + 1] = icon5;
          }
          if (pin2.contains('005')) {
            changeIcon[index + 1] = icon6;
          }
          if (pin2.contains('007')) {
            changeIcon[index + 1] = icon6;
          }
          if (pin2.contains('008')) {
            changeIcon[index + 1] = icon7;
          }
          if (pin2.contains('009')) {
            changeIcon[index] = icon8;
          }
          if (pin2.contains('0010')) {
            changeIcon[index + 1] = icon9;
          }
          if (pin2.contains('0011')) {
            changeIcon[index + 1] = icon10;
          }
          if (pin2.contains('0012')) {
            changeIcon[index + 1] = icon12;
          }
        }

        if (pin3.contains('001') ||
            pin3.contains('002') ||
            pin3.contains('003') ||
            pin3.contains('004') ||
            pin3.contains('005') ||
            pin3.contains('006') ||
            pin3.contains('007') ||
            pin3.contains('008') ||
            pin3.contains('009') ||
            pin3.contains('0010') ||
            pin3.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin3.contains('001')) {
            changeIcon[index + 2] = icon1;
          }
          if (pin3.contains('002')) {
            changeIcon[index + 2] = icon2;
          }
          if (pin3.contains('003')) {
            changeIcon[index + 2] = icon3;
          }
          if (pin3.contains('004')) {
            changeIcon[index + 2] = icon5;
          }
          if (pin3.contains('005')) {
            changeIcon[index + 2] = icon6;
          }
          if (pin3.contains('007')) {
            changeIcon[index + 2] = icon6;
          }
          if (pin3.contains('008')) {
            changeIcon[index + 2] = icon7;
          }
          if (pin3.contains('009')) {
            changeIcon[index + 2] = icon8;
          }
          if (pin3.contains('0010')) {
            changeIcon[index + 2] = icon9;
          }
          if (pin3.contains('0011')) {
            changeIcon[index + 2] = icon10;
          }
          if (pin3.contains('0012')) {
            changeIcon[index + 2] = icon12;
          }
        }

        if (pin4.contains('001') ||
            pin4.contains('002') ||
            pin4.contains('003') ||
            pin4.contains('004') ||
            pin4.contains('005') ||
            pin4.contains('006') ||
            pin4.contains('007') ||
            pin4.contains('008') ||
            pin4.contains('009') ||
            pin4.contains('0010') ||
            pin4.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin4.contains('001')) {
            changeIcon[index + 3] = icon1;
          }
          if (pin4.contains('002')) {
            changeIcon[index + 3] = icon2;
          }
          if (pin4.contains('003')) {
            changeIcon[index + 3] = icon3;
          }
          if (pin4.contains('004')) {
            changeIcon[index + 3] = icon5;
          }
          if (pin4.contains('005')) {
            changeIcon[index + 3] = icon6;
          }
          if (pin4.contains('007')) {
            changeIcon[index + 3] = icon6;
          }
          if (pin4.contains('008')) {
            changeIcon[index + 3] = icon7;
          }
          if (pin4.contains('009')) {
            changeIcon[index + 3] = icon8;
          }
          if (pin4.contains('0010')) {
            changeIcon[index + 3] = icon9;
          }
          if (pin4.contains('0011')) {
            changeIcon[index + 3] = icon10;
          }
          if (pin4.contains('0012')) {
            changeIcon[index + 3] = icon12;
          }
        }
        if (pin5.contains('001') ||
            pin5.contains('002') ||
            pin5.contains('003') ||
            pin5.contains('004') ||
            pin5.contains('005') ||
            pin5.contains('006') ||
            pin5.contains('007') ||
            pin5.contains('008') ||
            pin5.contains('009') ||
            pin5.contains('0010') ||
            pin5.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin5.contains('001')) {
            changeIcon[index + 4] = icon1;
          }
          if (pin5.contains('002')) {
            changeIcon[index + 4] = icon2;
          }
          if (pin5.contains('003')) {
            changeIcon[index + 4] = icon3;
          }
          if (pin5.contains('004')) {
            changeIcon[index + 4] = icon5;
          }
          if (pin5.contains('005')) {
            changeIcon[index + 4] = icon6;
          }
          if (pin5.contains('007')) {
            changeIcon[index + 4] = icon6;
          }
          if (pin5.contains('008')) {
            changeIcon[index + 4] = icon7;
          }
          if (pin5.contains('009')) {
            changeIcon[index + 4] = icon8;
          }
          if (pin5.contains('0010')) {
            changeIcon[index + 4] = icon9;
          }
          if (pin5.contains('0011')) {
            changeIcon[index + 4] = icon10;
          }
          if (pin5.contains('0012')) {
            changeIcon[index + 4] = icon12;
          }
        }
        if (pin6.contains('001') ||
            pin6.contains('002') ||
            pin6.contains('003') ||
            pin6.contains('004') ||
            pin6.contains('005') ||
            pin6.contains('006') ||
            pin6.contains('007') ||
            pin6.contains('008') ||
            pin6.contains('009') ||
            pin6.contains('0010') ||
            pin6.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin6.contains('001')) {
            changeIcon[index + 5] = icon1;
          }
          if (pin6.contains('002')) {
            changeIcon[index + 5] = icon2;
          }
          if (pin6.contains('003')) {
            changeIcon[index + 5] = icon3;
          }
          if (pin6.contains('004')) {
            changeIcon[index + 5] = icon5;
          }
          if (pin6.contains('005')) {
            changeIcon[index + 5] = icon6;
          }
          if (pin6.contains('007')) {
            changeIcon[index + 5] = icon6;
          }
          if (pin6.contains('008')) {
            changeIcon[index + 5] = icon7;
          }
          if (pin6.contains('009')) {
            changeIcon[index + 5] = icon8;
          }
          if (pin6.contains('0010')) {
            changeIcon[index + 5] = icon9;
          }
          if (pin6.contains('0011')) {
            changeIcon[index + 5] = icon10;
          }
          if (pin6.contains('0012')) {
            changeIcon[index + 5] = icon12;
          }
        }
        if (pin7.contains('001') ||
            pin7.contains('002') ||
            pin7.contains('003') ||
            pin7.contains('004') ||
            pin7.contains('005') ||
            pin7.contains('006') ||
            pin7.contains('007') ||
            pin7.contains('008') ||
            pin7.contains('009') ||
            pin7.contains('0010') ||
            pin7.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin7.contains('001')) {
            changeIcon[index + 6] = icon1;
          }
          if (pin7.contains('002')) {
            changeIcon[index + 6] = icon2;
          }
          if (pin7.contains('003')) {
            changeIcon[index + 6] = icon3;
          }
          if (pin7.contains('004')) {
            changeIcon[index + 6] = icon5;
          }
          if (pin7.contains('005')) {
            changeIcon[index + 6] = icon6;
          }
          if (pin7.contains('007')) {
            changeIcon[index + 6] = icon6;
          }
          if (pin7.contains('008')) {
            changeIcon[index + 6] = icon7;
          }
          if (pin7.contains('009')) {
            changeIcon[index + 6] = icon8;
          }
          if (pin7.contains('0010')) {
            changeIcon[index + 6] = icon9;
          }
          if (pin7.contains('0011')) {
            changeIcon[index + 6] = icon10;
          }
          if (pin7.contains('0012')) {
            changeIcon[index + 6] = icon12;
          }
        }
        if (pin8.contains('001') ||
            pin8.contains('002') ||
            pin8.contains('003') ||
            pin8.contains('004') ||
            pin8.contains('005') ||
            pin8.contains('006') ||
            pin8.contains('007') ||
            pin8.contains('008') ||
            pin8.contains('009') ||
            pin8.contains('0010') ||
            pin8.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin8.contains('001')) {
            changeIcon[index + 7] = icon1;
          }
          if (pin8.contains('002')) {
            changeIcon[index + 7] = icon2;
          }
          if (pin8.contains('003')) {
            changeIcon[index + 7] = icon3;
          }
          if (pin8.contains('004')) {
            changeIcon[index + 7] = icon5;
          }
          if (pin8.contains('005')) {
            changeIcon[index + 7] = icon6;
          }
          if (pin8.contains('007')) {
            changeIcon[index + 7] = icon6;
          }
          if (pin8.contains('008')) {
            changeIcon[index + 7] = icon7;
          }
          if (pin8.contains('009')) {
            changeIcon[index + 7] = icon8;
          }
          if (pin8.contains('0010')) {
            changeIcon[index + 7] = icon9;
          }
          if (pin8.contains('0011')) {
            changeIcon[index + 7] = icon10;
          }
          if (pin8.contains('0012')) {
            changeIcon[index + 7] = icon12;
          }
        }
        if (pin9.contains('001') ||
            pin9.contains('002') ||
            pin9.contains('003') ||
            pin9.contains('004') ||
            pin9.contains('005') ||
            pin9.contains('006') ||
            pin9.contains('007') ||
            pin9.contains('008') ||
            pin9.contains('009') ||
            pin9.contains('0010') ||
            pin9.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin9.contains('001')) {
            changeIcon[index + 8] = icon1;
          }
          if (pin9.contains('002')) {
            changeIcon[index + 8] = icon2;
          }
          if (pin9.contains('003')) {
            changeIcon[index + 8] = icon3;
          }
          if (pin9.contains('004')) {
            changeIcon[index + 8] = icon5;
          }
          if (pin9.contains('005')) {
            changeIcon[index + 8] = icon6;
          }
          if (pin9.contains('007')) {
            changeIcon[index + 8] = icon6;
          }
          if (pin9.contains('008')) {
            changeIcon[index + 8] = icon7;
          }
          if (pin9.contains('009')) {
            changeIcon[index + 8] = icon8;
          }
          if (pin9.contains('0010')) {
            changeIcon[index + 8] = icon9;
          }
          if (pin9.contains('0011')) {
            changeIcon[index + 8] = icon10;
          }
          if (pin9.contains('0012')) {
            changeIcon[index + 8] = icon12;
          }
        }
        if (pin10.contains('001') ||
            pin10.contains('002') ||
            pin10.contains('003') ||
            pin10.contains('004') ||
            pin10.contains('005') ||
            pin10.contains('006') ||
            pin10.contains('007') ||
            pin10.contains('008') ||
            pin10.contains('009') ||
            pin10.contains('0010') ||
            pin10.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin10.contains('001')) {
            changeIcon[index + 9] = icon1;
          }
          if (pin10.contains('002')) {
            changeIcon[index + 9] = icon2;
          }
          if (pin10.contains('003')) {
            changeIcon[index + 9] = icon3;
          }
          if (pin10.contains('004')) {
            changeIcon[index + 9] = icon5;
          }
          if (pin10.contains('005')) {
            changeIcon[index + 9] = icon6;
          }
          if (pin10.contains('007')) {
            changeIcon[index + 9] = icon6;
          }
          if (pin10.contains('008')) {
            changeIcon[index + 9] = icon7;
          }
          if (pin10.contains('009')) {
            changeIcon[index + 9] = icon8;
          }
          if (pin10.contains('0010')) {
            changeIcon[index + 9] = icon9;
          }
          if (pin10.contains('0011')) {
            changeIcon[index + 9] = icon10;
          }
          if (pin10.contains('0012')) {
            changeIcon[index + 9] = icon12;
          }
        }
        if (pin11.contains('001') ||
            pin11.contains('002') ||
            pin11.contains('003') ||
            pin11.contains('004') ||
            pin11.contains('005') ||
            pin11.contains('006') ||
            pin11.contains('007') ||
            pin11.contains('008') ||
            pin11.contains('009') ||
            pin11.contains('0010') ||
            pin11.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin11.contains('001')) {
            changeIcon[index + 10] = icon1;
          }
          if (pin11.contains('002')) {
            changeIcon[index + 10] = icon2;
          }
          if (pin11.contains('003')) {
            changeIcon[index + 10] = icon3;
          }
          if (pin11.contains('004')) {
            changeIcon[index + 10] = icon5;
          }
          if (pin11.contains('005')) {
            changeIcon[index + 10] = icon6;
          }
          if (pin11.contains('007')) {
            changeIcon[index + 10] = icon6;
          }
          if (pin11.contains('008')) {
            changeIcon[index + 10] = icon7;
          }
          if (pin11.contains('009')) {
            changeIcon[index + 10] = icon8;
          }
          if (pin11.contains('0010')) {
            changeIcon[index + 10] = icon9;
          }
          if (pin11.contains('0011')) {
            changeIcon[index + 10] = icon10;
          }
          if (pin11.contains('0012')) {
            changeIcon[index + 10] = icon12;
          }
        }

        if (pin12.contains('001') ||
            pin12.contains('002') ||
            pin12.contains('003') ||
            pin12.contains('004') ||
            pin12.contains('005') ||
            pin12.contains('006') ||
            pin12.contains('007') ||
            pin12.contains('008') ||
            pin12.contains('009') ||
            pin12.contains('0010') ||
            pin12.contains('0011')) {
          // icon2=Icons.ac_unit;
          // changeIcon[index+1]=icon2;
          if (pin12.contains('001')) {
            changeIcon[index + 11] = icon1;
          }
          if (pin12.contains('002')) {
            changeIcon[index + 11] = icon2;
          }
          if (pin12.contains('003')) {
            changeIcon[index + 11] = icon3;
          }
          if (pin12.contains('004')) {
            changeIcon[index + 11] = icon5;
          }
          if (pin12.contains('005')) {
            changeIcon[index + 11] = icon6;
          }
          if (pin12.contains('007')) {
            changeIcon[index + 11] = icon6;
          }
          if (pin12.contains('008')) {
            changeIcon[index + 11] = icon7;
          }
          if (pin12.contains('009')) {
            changeIcon[index + 11] = icon8;
          }
          if (pin12.contains('0010')) {
            changeIcon[index + 11] = icon9;
          }
          if (pin12.contains('0011')) {
            changeIcon[index + 11] = icon10;
          }
          if (pin12.contains('0012')) {
            changeIcon[index + 11] = icon12;
          }
        }

        // if(namesDataList[index+2].contains('003')){
        //   // icon2=Icons.ac_unit;
        //   changeIcon[index+2]=icon3;
        // }
        // if(namesDataList[index+3].contains('004')){
        //   print('qwertyhgf $index');
        //   // icon2=Icons.ac_unit;
        //   changeIcon[index+3]=icon4;
        // }
      }
      if (kDebugMode) {
        print(namesDataList);
      }
      return true;
    }
    return false;
  }


  Future<List<DeviceType>> getDeviceForDropDown(roomId) async {
    List<DeviceType> empty = [];
    String? token = await getToken();
    var url = api + 'addyourdevice/?r_id=' + roomId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);
      List<DeviceType> dv = ans.map((e) => DeviceType.fromJson(e)).toList();
      return dv;
    }
    return empty;
  }
 
  Future getSensorData(dId) async {
    String? token = await getToken();
    var url = api + 'tensensorsdata/?d_id=' + dId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      var ans = jsonDecode(response.body);
      sensorData = SensorData.fromJson(ans);

      switchFuture = getPinStatusData(deviceId.toString());

      // sensorDataForBackGround(dId);
      return true;
    }
    return false;
  }
 
  Future<List<RoomType>> getRoomForChange(flatId) async {
    List<RoomType> rm1 = [];
    String? token = await getToken();
    var url = api + "getallroomsbyonlyflooridf_id/?flt_id=" + flatId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);

      setState(() {
        rm1 = ans.map((e) => RoomType.fromJson(e)).toList();
      });
      return rm1;
    }
    print(response.statusCode);

    return rm1;
  }

  Future checkNavigation() async {
    if (widget.roomId != null && widget.dId != null && widget.flatId != null) {
      greets = greetingMessage();
      await getRoom(widget.flatId);
      await getDevice(widget.roomId);
    }
  }
    Future<void> getRoom(flatId) async {
    String? token = await getToken();
    var url = api + "getallroomsbyonlyflooridf_id/?flt_id=" + flatId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      if (widget.roomId != null) {
        for (int i = 0; i < ans.length; i++) {
          if (widget.roomId == ans[i]['r_id']) {
            setState(() {
              rm = [RoomType.fromJson(ans[i])];
            });
          }
        }
                await getDevice(rm[0].rId.toString());
      } else {
        print("ANS ===>>>>>>>>>>>> $ans");
        setState(() {
          rm = ans.map((e) => RoomType.fromJson(e)).toList();
        });
        await getDevice(ans[0]['r_id'].toString());
      }
    }
  }
  Future getDevice(roomId) async {
    String? token = await getToken();
    var url = api + 'getalldevicesbyonlyroomidr_id/?r_id=' + roomId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);

      setState(() {
        dv = ans.map((e) => DeviceType.fromJson(e)).toList();
        deviceId = ans[0]['d_id'].toString();
        sensorVal = getSensorData(ans[0]['d_id']);
      });
      print(ans);
    }
  }
  Future<void> getFloor(placeId) async {
    String? token = await getToken();
    var url = api + "getallfloorsbyonlyplaceidp_id/?p_id=" + placeId.toString();
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
    var url = api + "getallflatbyonlyflooridf_id/?f_id=" + floorId.toString();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List ans = jsonDecode(response.body);
      flatResponse = ans[0]['flt_id'].toString();
      print("FLATRESPONSE ===>>>>>>>> $flatResponse");
      await getRoom(ans[0]['flt_id'].toString());
    }
  }


}
