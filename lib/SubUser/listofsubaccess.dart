import 'dart:convert';

import 'package:afm_genorion/SubUser/subaccesspage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Global/global.dart';
import '../Models/subaccess.dart';
import '../Models/usereprofile.dart';
import '../main.dart';

class ListOfSubAccess extends StatefulWidget {
  const ListOfSubAccess({Key? key}) : super(key: key);

  @override
  State<ListOfSubAccess> createState() => _ListOfSubAccessState();
}

class _ListOfSubAccessState extends State<ListOfSubAccess> {
  UserProfile? userProfile;
  var email;
  int getUidVariable2 = 0;
  List<SubAccessModel> subAccessModel = [];

  Future<List<SubAccessModel>>? subAcessFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUidShared();
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
                    top: 16,
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
                          Text("Sub Access",
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
                const SizedBox(
                  height: 35,
                ),
                showSUb()
              ],
            )),
          );
        }
      },
    );
  }

  Widget showSUb() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<SubAccessModel>>(
        future: subAcessFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                  child: Text(
                "Empty",
                style: TextStyle(color: Colors.white),
              ));
            } else {
              return ListView.builder(
                  itemCount: subAccessModel.length,
                  itemBuilder: (context, index) {
                    return Card(
                      semanticContainer: true,
                      shadowColor: Colors.grey,
                      child: ListTile(
                        title: Text(subAccessModel[index].name),
                        subtitle: Text(subAccessModel[index].email),
                        trailing: Column(
                          children: [
                            const Text("Owner Name"),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(subAccessModel[index].ownerName),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SubAccessPage(
                                        pId: subAccessModel[index].pId,
                                        ownerName:
                                            subAccessModel[index].ownerName,
                                      ))));
                        },
                      ),
                    );
                  });
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            ));
          }
        },
      ),
    );
  }

  Future<List<SubAccessModel>> getSubUsers(email) async {
    String? token = await getToken();
    var url = api + 'subfindsubdata/?email=' + email;
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);
      print("SSASSSDASA $ans");
      setState(() {
        subAccessModel = ans.map((e) => SubAccessModel.fromJson(e)).toList();
      });
      return subAccessModel;
    }
    return subAccessModel;
  }

  Future<void> getUidShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final a = prefs.getInt("uid");
    setState(() {
      getUidVariable2 = int.parse(a.toString());
    });
    userProfile = await getUserDetails(getUidVariable2.toString());
    if (kDebugMode) {
      print("aas $a");
    }
    setState(() {
      email = userProfile!.email.toString();
    });
    subAcessFuture = getSubUsers(email);
    return;
  }
}
