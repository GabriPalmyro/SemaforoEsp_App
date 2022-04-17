import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationManager extends ChangeNotifier {
  PushNotificationManager() {
    _initialise();
  }

  final FirebaseMessaging _fcm = FirebaseMessaging();
  String _tokenId;

  set tokenId(String value) {
    _tokenId = value;
    notifyListeners();
  }

  String get tokenId => _tokenId;

  Future _initialise() async {
    if (Platform.isIOS)
      _fcm.requestNotificationPermissions(IosNotificationSettings());

    try {
      tokenId = await _fcm.getToken();
      log(tokenId);
    } catch (e) {
      log(e.toString());
    }

    // _fcm.configure(
    //   // Called when its in the foreground
    //   onMessage: (Map<String, dynamic> message) async {
    //     log('onMessage $message');
    //   },
    //   // Called when the app its open from the norification
    //   onLaunch: (Map<String, dynamic> message) async {
    //     log('onLaunch $message');
    //   },
    //   // Called when its in the background and open
    //   onResume: (Map<String, dynamic> message) async {
    //     log('onResume $message');
    //   },
    // );
  }
}
