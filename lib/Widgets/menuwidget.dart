// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'customcolor.dart';
import 'item.dart';

class MenuWidget extends StatefulWidget {
  int? selectedIndex;
  final Function(int selecIndex)? onTapped;

  MenuWidget({Key? key, required this.onTapped, this.selectedIndex})
      : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int _selectedItem = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedIndex!;
    if (kDebugMode) {
      print("Widget $_selectedItem");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
            Container(
            width: double.maxFinite,
            height: 150,
            color: CustomColors.blue_gray_dark,
            child: const Center(
              child: Text(
                'GenOrion',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SansitaSwashed',
                  fontSize: 32,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Container(
            height: 5,
            width: double.maxFinite,
            color: Colors.white60,
          ),
             InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 0;

                  widget.onTapped!(_selectedItem);
                });
              },
              child: Item(
                  id: 0,
                  title: 'Home',
                  selected: _selectedItem,
                  icon: Icons.home)),
        InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 1;
                  if (kDebugMode) {
                    print("SElected $_selectedItem");
                  }
                  widget.onTapped!(_selectedItem);
                });
              },
              child: Item(
                  id: 1,
                  title: 'SubUser Access',
                  selected: _selectedItem,
                  icon: Icons.add)),
               InkWell(
              onTap: () {
                setState(() {
                  _selectedItem = 2;
                  widget.onTapped!(_selectedItem);
                });
              },
              child: Item(
                  id: 2,
                  title: 'Sub Access Page',
                  selected: _selectedItem,
                  icon: FontAwesomeIcons.userFriends)),
        ],
    );
  }
}
