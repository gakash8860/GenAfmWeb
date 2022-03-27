import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Models/subuser.dart';
import '../main.dart';
import 'addsub.dart';

class ViewShowSubuser extends StatefulWidget {
  const ViewShowSubuser({Key? key}) : super(key: key);

  @override
  State<ViewShowSubuser> createState() => _ViewShowSubuserState();
}

class _ViewShowSubuserState extends State<ViewShowSubuser> {
  List<SubUserDetails> subuser = [];
  Future<List<SubUserDetails>>? subFuture;



  @override
  void initState() {

    super.initState();
    subFuture = getSubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
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
                InkWell(
                  onTap: (){},
                  child: Container(),
                ),
                Row(
                  children: const [
                    Text("SubUsers",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(360),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddSubUser()));
                  },
                  child: const SizedBox(
                    height: 35,
                    width: 35,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
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
                    Text("SubUsers",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(360),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddSubUser()));
                  },
                  child: const SizedBox(
                    height: 35,
                    width: 35,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
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

      },
    );
  }
    Widget showSUb() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<SubUserDetails>>(
        future: subFuture,
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
                  itemCount: subuser.length,
                  itemBuilder: (context, index) {
                    return Card(
                      semanticContainer: true,
                      shadowColor: Colors.grey,
                      child: ListTile(
                        title: Text(subuser[index].name),
                        subtitle: Text(subuser[index].email),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.black,
                            semanticLabel: 'Delete',
                          ),
                          onPressed: () {
                            _showDialogForDeleteSubUser(index);
                          },
                        ),
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
  _showDialogForDeleteSubUser(int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure to delete this user"),
        actions: <Widget>[
          FlatButton(
              child: const Text("Yes"),
              onPressed: () async {
                await deleteSubUser(subuser[index].email, subuser[index].pId);
                Navigator.of(context).pop();
              }),
          FlatButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
  Future deleteSubUser(String email, String pId) async {
    String? token = await getToken();
    final url = api + 'subuseraccess/?email=$email&p_id=' + pId;
    final response = await http.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      print("REREEEREREREE ${response.body}");
      subFuture = getSubUsers();
    }
  }
    Future<List<SubUserDetails>> getSubUsers() async {
    String? token = await getToken();
    const url = api + 'subuserfindall/';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ans = jsonDecode(response.body);
      print("porororo $ans");
      setState(() {
        subuser = ans.map((e) => SubUserDetails.fromJson(e)).toList();
      });
      return subuser;
    }
    return subuser;
  }


}
