import 'package:afm_genorion/Homepage/homepage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Widgets/destinantio.dart';
import '../Widgets/menuwidget.dart';
import 'destionationview.dart';

class ChangeIndex extends StatefulWidget {
  final String? deviceId;
  final String? roomId;
  final String? flatResponse;
  final Function(int selectedIndex)? onTapped;
  final int? currentIndex;
  const ChangeIndex(
      {Key? key,
      this.deviceId,
      this.flatResponse,
      this.roomId,
      this.currentIndex,
      this.onTapped})
      : super(key: key);

  @override
  State<ChangeIndex> createState() => _ChangeIndexState();
}

class _ChangeIndexState extends State<ChangeIndex> {
  int _index = 0;

  @override
  void initState() {
    super.initState();

    _index = widget.currentIndex!;
    if (kDebugMode) {
      print("INDEX======>>>>>>>>>>>>>>>>>>>>>>  $_index");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 600) {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: MenuWidget(
                  selectedIndex: _index,
                  onTapped: (selectedIndex) {
                    setState(() {
                      _index = selectedIndex;
                      ("Selected Index =====>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $_index");
                    });
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: IndexedStack(
                  index: _index,
                  children:
                      allDestinations.map<Widget>((Destination destination) {
                    return DestinationView(
                      destination: destination,
                      flatResponse: widget.flatResponse,
                      roomId: widget.roomId,
                      deviceId: widget.deviceId,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      } else {
        return HomePage(
            flatResponse: widget.flatResponse,
            roomId: widget.roomId,
            deviceId: widget.deviceId);
      }
    });
  }
}
