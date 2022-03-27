// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'customcolor.dart';

class Item extends StatefulWidget {
    final  id;
  final  title;
  final  selected;
  final IconData ?icon;

   const Item({ Key? key, this.id, this.title,  this.selected,  this.icon }) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
   Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.selected == widget.id
            ? Border.all(width: 2.0, color: CustomColors.blue_gray)
            : null,
        borderRadius: const BorderRadius.all( Radius.circular(5.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 20.0),
        child: Row(
          children: [
            Icon(widget.icon, size: 24, color: CustomColors.neon_green),
            const SizedBox(width: 16.0),
            Text(widget.title, style: const TextStyle(color: CustomColors.neon_green)),
          ],
        ),
      ),
    );
  }

}