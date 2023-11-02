import 'package:flutter/material.dart';

void showFormDialog(BuildContext context) {
  TextEditingController titleText = TextEditingController();
  TextEditingController subTitleText = TextEditingController();

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
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // validator: Validator().validateUsername, // Uncomment and define your validator if needed
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // validator: Validator().validateUsername, // Uncomment and define your validator if needed
                  ),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: const Icon(
                    Icons.label,
                    size: 40,
                  ),
                  title: DropdownButtonFormField(
                    hint: const Text('Kategori'),
                    decoration: InputDecoration(
                      hintText: 'Kategori',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
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
                      // Uncomment if needed:
                      // setState(() {
                      //   dropDownValue = newValue;
                      // });
                    },
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
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              // Uncomment if needed:
              // if (dataToDo.doc().id == true) {
              //   await dataToDo.doc().update({
              //     'Title': titleText.text,
              //     'Deskripsi': subTitleText.text,
              //     'keperluan': dropDownValue.toString(),
              //   });
              //   Navigator.of(context).pop();
              // }
              // addToDo();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
