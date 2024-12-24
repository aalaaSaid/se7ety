import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget view) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
}

navigateWithReplacement(BuildContext context, Widget view) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => view));
}

navigateWithRemoveUntil(BuildContext context, Widget view) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => view), (route) => false);
}