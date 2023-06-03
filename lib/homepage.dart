import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void DeleteDonor(id) {
    donor.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("new text"),
      ),
      body: StreamBuilder(
          stream: donor.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorSnap =
                        snapshot.data!.docs[index];
                    return ListTile(
                      subtitle: IconButton(
                          onPressed: () {
                            DeleteDonor(donorSnap.id);
                          },
                          icon: const Icon(Icons.delete)),
                      trailing: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/updatepage',
                                    arguments: {
                                      'name': donorSnap['name'].toString(),
                                      'phone': donorSnap['phone'].toString(),
                                      'group': donorSnap['group'].toString(),
                                      'id': donorSnap.id.toString()
                                    });
                              },
                              icon: const Icon(Icons.abc)),
                        ],
                      ),
                      title: Text(donorSnap['name']),
                    );
                  });
            } else
              return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addpage');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
