// ignore_for_file: unused_import, unnecessary_null_comparison, avoid_print, avoid_unnecessary_containers, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:todo_list2/commponents/validator.dart';
import 'package:todo_list2/models/todomodel.dart';
import 'package:todo_list2/ppp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference dataToDo =
      FirebaseFirestore.instance.collection('Activity');

  GlobalKey<FormState> formKeySignin = GlobalKey<FormState>();
  TextEditingController titleText = TextEditingController();
  TextEditingController subTitleText = TextEditingController();
  TextEditingController tagText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? dropDownValue = '';
  List<ToDoModel> dataactivity = <ToDoModel>[];
  textClear() {
    titleText.clear();
    subTitleText.clear();
  }

  Future<void> deleteActivity(String id) {
    return dataToDo.firestore
        .collection('Activity')
        .doc(id)
        .delete()
        .then((value) => print("Activity Deleted"))
        .catchError((error) => print("Failed to delete Activity: $error"));
  }

  Future<void> updateActivity(id) async {
    return dataToDo.firestore
        .collection('Activity')
        .doc(id)
        .update({
          'Title': titleText.text,
          'Deskripsi': subTitleText.text,
          'Keperluan': dropDownValue.toString(),
        })
        .then((value) => print("Activity Updated"))
        .catchError((error) => print("Failed to Update Activity: $error"));
  }

  handleSubmit() {
    print(titleText.text);
    print(subTitleText.text);
    print(dropDownValue);
  }

  final Stream<QuerySnapshot> streamactivity =
      FirebaseFirestore.instance.collection('Activity').snapshots();

  addToDo() {
    dataToDo
        .add({
          'Title': titleText.text,
          'Deskripsi': subTitleText.text,
          'Keperluan': dropDownValue.toString()
        })
        .then((value) => print("Activity Added"))
        .catchError((error) => print("Failed to add Activity: $error"));
  }

  @override
  void initState() {
    textClear();

    // ODO: implement initState
    super.initState();
  }

  List<Color> colorsTag = [
    Colors.redAccent,
    Colors.teal,
    Colors.green,
    Colors.grey
  ];

//form untuk mengisi data
  showform() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Isi Kegiatan Anda'),
          content: Form(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.maxFinite,
              child: Column(
                verticalDirection: VerticalDirection.down,
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons.list_alt,
                      size: 40,
                    ),
                    title: TextFormField(
                      autofocus: true,
                      controller: titleText,
                      decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: Validator().validateUsername,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons.message,
                      size: 40,
                    ),
                    title: TextFormField(
                      controller: subTitleText,
                      decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: Validator().validateUsername,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: const Icon(
                      Icons.label,
                      size: 40,
                    ),
                    title: Container(
                      child: DropdownButtonFormField(
                        hint: const Text('Kategori'),
                        decoration: InputDecoration(
                            hintText: 'Kategori',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        isExpanded: true,
                        elevation: 0,
                        icon: const Icon(
                          Icons.arrow_downward_outlined,
                        ),
                        items: <String>[
                          'Sekolah',
                          'Kantor',
                          'Rumah',
                          'Lain - lain',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: const Text('Cancel'),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () async {
                if (dataToDo.doc().id == true) {
                  await dataToDo.doc().update({
                    'Title': titleText.text,
                    'Deskripsi': subTitleText.text,
                    'keperluan': dropDownValue.toString(),
                  });
                  Navigator.of(context).pop();
                }
                addToDo();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    ).then((value) => textClear());
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime selectDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO APP'),
        centerTitle: true,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: selectDate,
                firstDate: selectDate,
                lastDate: DateTime(2500),
              );
            },
            icon: const Icon(
              Icons.date_range_outlined,
              size: 40,
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showform();
        },
        child: const Icon(
          Icons.add_circle_outline,
          size: 50,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor.withAlpha(255),
        elevation: 0,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_rounded,
                size: 40,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.label,
                size: 40,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              label: 'Edit',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (text) {
                // Handle search here based on the text entered
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: streamactivity,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView(
                  padding: const EdgeInsets.all(5),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          style: ListTileStyle.list,
                          title: Text(data['Title']),
                          subtitle: Text(data['Deskripsi']),
                          leading: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.favorite_border)),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text("Edit"),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Text("Delete"),
                                    ),
                                  ];
                                },
                                onSelected: (value) async {
                                  if (value == 1) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          alignment: Alignment.center,
                                          title: const Text(
                                            'Delete Task?',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                'Are You Sure Want To Delete This Item?',
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Text(
                                                data['Title'],
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                child: const Text('Cancel'),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  deleteActivity(document.id);
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'You Have Successfully Deleted a Activity',
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Container(
                                                child: const Text('Delete'),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (value == 0) {
                                    if (data != null) {
                                      showform();
                                      await dataToDo
                                          .doc(document.id)
                                          .update(data);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
