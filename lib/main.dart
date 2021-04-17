import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Material App Bar'),
            ),
            body: Container(child: Center(child: lista()))));
  }

  Widget lista() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return Swiper(
            layout: SwiperLayout.STACK,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Image.network(
                snapshot.data.docs[index]['photo'],
                fit: BoxFit.cover,
              );
            },
            itemWidth: 300.0,
            itemHeight: 300.0,
          );

          /*return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Image.network(snapshot.data.docs[index]['photo']),
                      Text(snapshot.data.docs[index]['name']),
                      Text(snapshot.data.docs[index]['job'])
                    ],
                  ),
                );
              });*/
          //});
        });
  }
}
