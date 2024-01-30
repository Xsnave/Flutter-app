// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_store_web/views/side_views/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  static const String screenRoute = "CategoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  dynamic _image;
  String? _fileName;
  late String _categoryName;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
        _fileName = result.files.first.name;
      });
    }
  }

  _uploadCategoryToFirebaseStorage(dynamic image) async {
    var ref = _firebaseStorage.ref().child('CategoryImages').child(_fileName!);

    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  _uploadCategoryToFirestore() async {
    EasyLoading.show();
    if (_formKey.currentState!.validate()) {
      var imageURL = await _uploadCategoryToFirebaseStorage(_image);
      await _firebaseFirestore
          .collection("Categories")
          .doc(FirebaseFirestore.instance.collection('Categories').doc().id)
          .set({'image': imageURL, 'Categories': _categoryName}).whenComplete(
              () {
        EasyLoading.dismiss();
        setState(() {
          _image = null;
        });
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Categories Managment',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child:  _image != null ? Image.memory(_image) : Text('Upload Image'),),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        onChanged: (value) {
                          _categoryName = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please, the Category Name can't be empty";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Enter Category Name",
                            hintText: "Enter Category Name"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _uploadCategoryToFirestore();
                      },
                      child: Text('Save Category'))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text('Select Category Image'),
              ),
              SizedBox(height: 30),
              CategoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
