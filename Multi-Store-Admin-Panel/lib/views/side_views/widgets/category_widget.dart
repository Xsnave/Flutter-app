// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final Stream<QuerySnapshot> _categoryStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categoryStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: snapshot.data!.size,
          itemBuilder: (context, index) {
            final categoriesData = snapshot.data!.docs[index];
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 123,
                    height: 123,
                    child: Image.network(categoriesData['image'],fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(width: 2), // Ajusta el espacio entre la imagen y el nombre
                Text(
                  categoriesData['Categories'],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
