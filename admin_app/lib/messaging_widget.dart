/*
import 'package:flutter/material.dart';
import 'package:firebase_cloud_messaging/firebase_cloud_messaging.dart';

import 'message.dart';
import 'messaging.dart';
class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final TextEditingController titleController =
  TextEditingController(text: 'Notification');
  final TextEditingController bodyController =
  TextEditingController(text: '123');
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.onTokenRefresh.listen(sendTokenToServer);
    _firebaseMessaging.getToken();
    _firebaseMessaging.subscribeToTopic('all');

    _firebaseMessaging.configure(
      //If the app is already opened
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      //If the app is not activated
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      //If the app is running in the background
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  @override
  Widget build(BuildContext context) => ListView(
    children: [
     // TextFormField(
       // controller: titleController,
        //decoration: InputDecoration(labelText: 'Title'),
      //),
      //TextFormField(
       // controller: bodyController,
        //decoration: InputDecoration(labelText: 'Body'),
      //),
      RaisedButton(
        onPressed: sendNotification,
        child: Text('Send notification'),
      ),
    ]//..addAll(messages.map(buildMessage).toList()),
  );



Widget buildMessage(Message message) =>
      ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );



  Future sendNotification() async {
    final response = await Messaging.sendTo(
     // title: titleController.text,
      //body: bodyController.text,
        fcmToken:'ehPOJnFvHic:APA91bGmvaZCKm6qp0j_uHbDWv3yI2iURBaZ9NGWfi80sq2NgJFM8QY5XbcjWQ20yU7T_jUu0Edlrk953iI3C1f_zOsJi23Du7iALpC14QK1yaxcUm3_s5TtHLrwLCwMsOFmlFn9Mqgm'
      // fcmToken: fcmToken,
    );

    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
        Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
  }
  void sendTokenToServer(String fcmToken) {
    print('Token: $fcmToken');
    // send key to your server to allow server to use
    // this token to send push notifications
  }
}
*/
