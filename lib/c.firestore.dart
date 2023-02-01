import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport/c.home.dart';
import 'package:sport/cfile.dart';

class FireStores extends StatefulWidget {
  const FireStores({Key? key}) : super(key: key);

  @override
  State<FireStores> createState() => _FireStoresState();
}

class _FireStoresState extends State<FireStores> {
  final CollectionReference user =
      FirebaseFirestore.instance.collection('creater');

  final _formKey = GlobalKey<FormState>();
  final nameContoller = TextEditingController();
  final ageContoller = TextEditingController();
  final genderContoller = TextEditingController();
  final numberContoller = TextEditingController();
  void addContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('creater').add({
          'Account type': 'creater',
          'Name': nameContoller.text.trim(),
          'Age': ageContoller.text.trim(),
          'Gender': genderContoller.text.trim(),
          'Number': numberContoller.text.trim(),
        });
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Cfile(),
              ));
        }
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Plese fill all the feildas')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plese fill all the feildas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreaterHome(),
                        ));
                  },
                  icon: Icon(Icons.arrow_back)),
            ),
            SizedBox(
              width: 200,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Cfile(),
                      ));
                },
                icon: Icon(Icons.folder)),
          ],
        ),
        body: ListView(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameContoller,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: ageContoller,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Age';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Age',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: genderContoller,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Gender';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Gender',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: numberContoller,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Your PhoneNumber';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Number',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: addContact, child: Text('Craete')),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
