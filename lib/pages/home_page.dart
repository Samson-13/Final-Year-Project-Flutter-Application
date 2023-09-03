import 'package:cctv/models/name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final hotelRef = FirebaseFirestore.instance
      .collection("hotel")
      .limit(30)
      .withConverter<HotelModel>(
        fromFirestore: (data, _) => HotelModel.fromMap(data.data()!),
        toFirestore: (data, _) => data.toMap(),
      );

  List<HotelModel> hotel = []; // Initialize an empty list to hold the data

  void listenData() {
    hotelRef.snapshots().listen((event) {
      final hotels = event.docs.map((doc) => doc.data()).toList();
      setState(() {
        hotel = hotels;
      });
    });
  }

  Future<void> readData() async {
    try {
      final firestoreResult = await hotelRef.get();
      final hotels = firestoreResult.docs.map((doc) => doc.data()).toList();
      setState(() {
        hotel = hotels;
      });
      print("firestoreResult: ${firestoreResult.docs.length}");
    } catch (e) {
      print("Error reading data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Samson Badding',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
            itemCount: hotel.length,
            itemBuilder: (context, index) {
              var item = hotel[index];
              return Card(
                elevation: 3,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.age,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(item.gender),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
