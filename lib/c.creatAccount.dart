import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport/c.home.dart';
import 'package:sport/c.signin.dart';

class CcreateAccount extends StatefulWidget {
  const CcreateAccount({Key? key}) : super(key: key);

  @override
  State<CcreateAccount> createState() => _CcreateAccountState();
}

class _CcreateAccountState extends State<CcreateAccount> {
  int selectedValue = 0;

  final CollectionReference user =
      FirebaseFirestore.instance.collection('users');
  bool visible = true;
  final emailedController = TextEditingController();
  final passwordedController = TextEditingController();
  final useredController = TextEditingController();
  final ageController = TextEditingController();
  final numberController = TextEditingController();
  final dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('users').add({
          'Account type': 'User Account',
          'Name': useredController.text.trim(),
          'Age': ageController.text.trim(),
          'DOb': dobController.text.trim(),
          'Number': numberController.text.trim(),
        });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.orangeAccent,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Create An Account",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    "assets/image/sport1.png",
                    height: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "SportMela!",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: useredController,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.supervised_user_circle),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "UserName",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter UserName";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailedController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "EmailId",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter valid Emailid";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordedController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            visible = !visible;
                                          });
                                        },
                                        icon: Icon(visible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "password",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.length <= 8 && value.isEmpty) {
                                        return "please enter valid password";
                                      }
                                      return null;
                                    },
                                    obscureText: visible,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: ageController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.face_outlined),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "Age",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Your Age";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: numberController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "PhoneNumber",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Your PhoneNumber";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.datetime,
                                    controller: dobController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.face_outlined),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      labelText: "DOB",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent,
                                            width: 1),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter Your DOB";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.orangeAccent)),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Gender",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Radio(
                                            value: 1,
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                value = selectedValue = 1;
                                              });
                                            },
                                          ),
                                          Text("male"),
                                          // SizedBox(
                                          //   width: 5,
                                          // ),
                                          Radio<int>(
                                            value: 2,
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                value = selectedValue = 2;
                                              });
                                            },
                                          ),
                                          Text("female"),
                                          // SizedBox(
                                          //   width: 5,
                                          // ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.orangeAccent),
                                        child: Text(
                                          " Signup",
                                        ),
                                        onPressed: () {
                                          final docUser = FirebaseFirestore
                                              .instance
                                              .collection('users')
                                              .doc('my-Id');
                                          final json = {
                                            'Account type': 'User Account',
                                            'Name':
                                                useredController.text.trim(),
                                            'Age': ageController.text.trim(),
                                            'DOb': dobController.text.trim(),
                                            'Number':
                                                numberController.text.trim(),
                                          };
                                          docUser.set(json);
                                          addContact();
                                          FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailedController.text,
                                                  password:
                                                      passwordedController.text)
                                              .then((value) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreaterHome()));
                                          }).onError((error, stackTrace) {
                                            print("Error${error.toString()}");
                                          });
                                          FocusScope.of(context).unfocus();
                                        }),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CsignIn()));
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Already Have An Account!",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
