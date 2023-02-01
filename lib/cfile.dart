import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sport/c.firestore.dart';

class Cfile extends StatefulWidget {
  const Cfile({Key? key}) : super(key: key);

  @override
  State<Cfile> createState() => _CfileState();
}

class _CfileState extends State<Cfile> {
  final nameContoller = TextEditingController();
  final ageContoller = TextEditingController();
  final genderContoller = TextEditingController();
  final numberContoller = TextEditingController();

  final CollectionReference user =
      FirebaseFirestore.instance.collection('creater');
  Future<void> delete(String productId) async {
    await user.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      nameContoller.text = documentSnapshot['Name'];
      ageContoller.text = documentSnapshot['Age'].toString();
      genderContoller.text = documentSnapshot['Gender'];
      numberContoller.text = documentSnapshot['Number'].toString();
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  // prevent the soft keyboard from covering text fields
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameContoller,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: ageContoller,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: genderContoller,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                  ),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: numberContoller,
                    decoration: const InputDecoration(
                      labelText: 'Number',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(action == 'create' ? 'Create' : 'Update'),
                    onPressed: () async {
                      final String? name = nameContoller.text;
                      final double? age = double.tryParse(ageContoller.text);
                      final String? gender = nameContoller.text;
                      final double? number = double.tryParse(ageContoller.text);
                      if (name != null &&
                          age != null &&
                          gender != null &&
                          number != null) {
                        if (action == 'create') {
                          // Persist a new product to Firestore
                          await user.add({
                            "Name": name,
                            "Age": age,
                            "Gender": gender,
                            "Number": number,
                          });
                        }

                        if (action == 'update') {
                          // Update the product
                          await user.doc(documentSnapshot.id).update({
                            "Name": name,
                            "Age": age,
                            "Gender": gender,
                            "Number": number,
                          });
                        }

                        // Clear the text fields
                        nameContoller.text = '';
                        ageContoller.text = '';
                        genderContoller.text = '';
                        numberContoller.text = '';
                        // Hide the bottom sheet
                        // Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FireStores(),
                      ));
                },
                icon: Icon(Icons.arrow_back)),
          ),
          SizedBox(
            width: 40,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Profile Page',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            width: 80,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
          stream: user.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['Name']),
                        subtitle: Column(
                          children: [
                            Text(documentSnapshot['Age'].toString()),
                            Text(documentSnapshot['Gender']),
                            Text(documentSnapshot['Number'].toString()),
                          ],
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _createOrUpdate(documentSnapshot),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => delete(documentSnapshot.id),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FireStores(),
                ));
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
