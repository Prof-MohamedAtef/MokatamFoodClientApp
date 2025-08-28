import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CommonMethods {
  Future<bool> checkConnectivity(BuildContext context) async {
    var connectionResult = await Connectivity().checkConnectivity();

    if (connectionResult == ConnectivityResult.none) {
      if (context.mounted) {
        displaySnackBar(
          'No network connection detected. Please check your Wi-Fi or Mobile Data.',
          context,
        );
      }
      return false;
    }

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      } else {
        if (context.mounted) {
          displaySnackBar(
            'Connected to network but no Internet access.',
            context,
          );
        }
        return false;
      }
    } on SocketException catch (_) {
      if (context.mounted) {
        displaySnackBar(
          'Connected to network but no Internet access.',
          context,
        );
      }
      return false;
    }
  }

  void displaySnackBar(String messageText, BuildContext context) {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
