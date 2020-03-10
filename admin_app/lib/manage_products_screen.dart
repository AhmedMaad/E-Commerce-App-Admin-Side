import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ManageProductScreen extends StatefulWidget {
  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  showDeleteDialog(String documentId) {
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure that you want to delete this item?"),
      actions: [
        FlatButton(onPressed: () => deleteItem(documentId), child: Text("YES")),
        FlatButton(onPressed: () => Navigator.pop(context), child: Text("NO")),
      ],
      elevation: 24,
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteItem(String documentId) async{
    Navigator.of(context).pop();
    await Firestore.instance
        .collection("products")
        .document(documentId)
        .delete();
    Toast.show("Product Deleted Successfully", context, duration: 2);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("products").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          Toast.show("Check your Internet connection", context, duration: 2);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading...');
          default:
            return ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(document["image"]),
                  ),
                  title: Text(
                    document["title"],
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    document["description"],
                    style: TextStyle(fontSize: 16),
                  ),
                  contentPadding: EdgeInsets.all(8),
                  onLongPress: () => showDeleteDialog(document.documentID),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
