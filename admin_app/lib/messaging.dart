/*
import 'dart:convert';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class Messaging {
  static final Client client = Client();

  // from 'https://console.firebase.google.com'
  // --> project settings --> cloud messaging --> "Server key"
  static const String serverKey =
      'AAAACZ2qzOk:APA91bHEZ-ag-2vlC30uW8w1sBGfIM_-3j8GuXpZbE39MV8j4kSfvDwwAzlreQWO7By7Kf3s51wYHN92MJSii05b4IP-e_fGc-gFrRmzjakopSfOHLKgwx_OWWjNq_i2px6RY2AqvIrR';

  static Future<Response> sendToAll({
    @required String title,
    @required String body,
  }) =>
      sendToTopic( topic: 'all');

  static Future<Response> sendToTopic(
      {@required String title,
        @required String body,
        @required String topic}) =>
      sendTo( fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
   // @required String title,
    //@required String body,
    @required String fcmToken,
  }) =>
      client.post(
        'https://fcm.googleapis.com/fcm/send',
        body: json.encode({
          'notification': {},
          'priority': 'high',
          'data': {
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          'to': '$fcmToken',
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );
}
*/
