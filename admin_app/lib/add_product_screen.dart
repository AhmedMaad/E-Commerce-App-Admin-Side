import 'dart:io';
import 'dart:math';

import 'package:admin_app/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spinner_input/spinner_input.dart';
import 'package:toast/toast.dart';

//Reference: https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27
class AddProductScreen extends StatefulWidget {
  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  Product product = new Product();
  double spinnerCounter = 1;
  var categories = <String>["Clothes", "Electronics", "Furniture"];
  String categoryItem = "Select category";
  final _addProductKey = GlobalKey<FormState>();
  File imagePath;
  bool isLoading = false;
  double progressbarValue = 0.0;

  Future checkForm() async {
    print("Checking Form...");
    final formState = _addProductKey.currentState;
    if (formState.validate()) {
      setState(() {
        isLoading = true;
        progressbarValue = 0.3;
      });
      print("Form is valid...");
      formState.save(); //this method mn8eerha el data httl3 null :)
      addProduct();
    } else {
      print("Form is not valid...");
    }
  }

  void addProduct() async {
    print("Adding Product...");
    setState(() {
      progressbarValue = 0.6;
    });
    await getLocation();
    setState(() {
      progressbarValue = 1.0;
    });
    await Firestore.instance.collection("products").document().setData({
      "title": product.getTitle(),
      "description": product.getDescription(),
      "price": product.getPrice(),
      "category": product.getCategory(),
      "quantity": product.getQuantity(),
      "image": product.getImageURL(),
      "lat": product.getLatitude(),
      "lon": product.getLongitude(),
    }).then((data) {
      setState(() {
        isLoading = false;
      });
      print("Added succesfully");
      Toast.show("Product Added Successfully", context, duration: 2);
    }).catchError((onError) {
      print("Error occured while adding a product...");
    });
  }

  Future getLocation() async {
    setState(() {
      progressbarValue = 0.8;
    });
    print("Getting location...");
    Location location = new Location();
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
      product.setLatitude(currentLocation.latitude);
      print(product.getLatitude());
      product.setLongitude(currentLocation.longitude);
      print(product.getLongitude());
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print("permission denied");
      }
      currentLocation = null;
    }
  }

  void getImageFromCamera() async {
    print("Getting image from camera...");
    Navigator.of(context).pop();
    uploadImage(ImageSource.camera);
  }

  void getImageFromGallery() async {
    print("Getting image from gallery...");
    Navigator.of(context).pop();
    uploadImage(ImageSource.gallery);
  }

  Future uploadImage(var imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    print("Uploading image...");
    final String fileName =
        "image" + Random().nextInt(10000).toString() + '.jpg';
    print("Image name is: $fileName");
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(File(image.path));
    setState(() {
      imagePath = File(image.path);
    });
    print("Picture uploaded successfully...");

    final StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
    product.setImageURL(await downloadUrl.ref.getDownloadURL());
    print("Image URL: " + product.getImageURL());
  }

  void showAlertDialog(BuildContext context) {
    print("Showing Alert Dialog...");
    AlertDialog alert = AlertDialog(
      title: Text("Complete action with..."),
      actions: [
        FlatButton(
            onPressed: getImageFromGallery,
            child: Image.asset(
              "images/gallery.png",
              width: 80,
              height: 80,
            )),
        FlatButton(
          onPressed: getImageFromCamera,
          child: Image.asset(
            "images/camera.png",
            width: 80,
            height: 80,
          ),
        ),
      ],
      elevation: 24,
    );
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Form(
                key: _addProductKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Enter Title"),
                      validator: (value) =>
                          value.isEmpty ? "Title is required" : null,
                      onSaved: (value) => product.setTitle(value),
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Enter Description"),
                      validator: (value) =>
                          value.isEmpty ? "Description is required" : null,
                      onSaved: (value) => product.setDescription(value),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Enter Price"),
                      validator: (value) =>
                          value.isEmpty ? "Price is required" : null,
                      onSaved: (value) => product.setPrice(double.parse(value)),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  Text("Quantity: "),
                  Expanded(
                    child: SpinnerInput(
                      spinnerValue: spinnerCounter,
                      minValue: 1,
                      maxValue: 99,
                      disabledLongPress: true,
                      disabledPopup: true,
                      onChange: (value) {
                        setState(() {
                          spinnerCounter = value;
                          product.setQuantity(spinnerCounter.toInt());
                        });
                      },
                    ),
                  ),
                  DropdownButton<String>(
                    hint: Text(categoryItem),
                    items: categories.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryItem = value;
                        product.setCategory(categories.indexOf(value));
                      });
                    },
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: imagePath != null
                  ? Image.file(
                      imagePath,
                      width: 160,
                      height: 160,
                    )
                  : Image.asset(
                      "images/upload.png",
                      width: 160,
                      height: 160,
                    ),
            ),
            Text(
              "Note:When you add a product your location will be provided",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            RaisedButton(
              onPressed: checkForm,
              child: Text("ADD PRODUCT"),
            ),
             Visibility(
              visible: isLoading,
              child: CircularProgressIndicator(
                value: progressbarValue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
