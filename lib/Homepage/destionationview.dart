import 'package:afm_genorion/SubUser/listofsubaccess.dart';
import 'package:afm_genorion/SubUser/viewsubuser.dart';
import 'package:flutter/material.dart';

import '../Widgets/destinantio.dart';
import 'desktophome.dart';

class DestinationView extends StatefulWidget {
  final String? deviceId;
  final String? roomId;
  final String? flatResponse;
  final Destination? destination;
  const DestinationView({Key? key,this.destination,this.deviceId,this.flatResponse,this.roomId}) : super(key: key);

  @override
  State<DestinationView> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.destination!.id ==0?DesktopHome(flatResponse: widget.flatResponse,roomId: widget.roomId,deviceId: widget.deviceId,)
      :widget.destination!.id == 1?const ViewShowSubuser()
      :widget.destination!.id == 2?const ListOfSubAccess():Container()

    );
  }
}
