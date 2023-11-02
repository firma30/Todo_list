// ignore_for_file: non_constant_identifier_names, unnecessary_this

class ToDoModel {
  late String? id, title, deskripsi, kategori;
  ToDoModel.map(dynamic data, key) {
    id = key;
    title = data['nama'];
    deskripsi = data['user_name'];
    kategori = data['jenis_kelamin'];
  }
}
