import 'package:flutter/material.dart';
import 'package:get/get.dart';

chatTile({required AlignmentGeometry? alignment,required double width, required String message}) {
  return Container(
    alignment: alignment,
    width: width/1.6,
    color: Colors.orange[50],
    child: ListTile(title: Text(message)),
  ).paddingAll(5);
}