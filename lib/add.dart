import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final bloodGroups = ["A+", "B+", "c+", "AB+"];
  String? selectedGroup;
  TextEditingController donarname = TextEditingController();
  TextEditingController donarnumber = TextEditingController();
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void AddDonor() {
    final data = {
      'name': donarname.text,
      'phone': donarnumber.text,
      'group': selectedGroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("add page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donarname,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Donar Name")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donarnumber,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("phone no")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                  items: bloodGroups
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    selectedGroup = val as String;
                  }),
            ),
            CupertinoButton(
                color: Colors.amber,
                child: const Text("add"),
                onPressed: () {
                  AddDonor();
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
