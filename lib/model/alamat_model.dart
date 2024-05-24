class AlamatModel {
  String? label;
  String? alamat;
  String? nama;
  String? nomor;
  String? uuid;
  String? id;

  AlamatModel({
    this.label,
    this.alamat,
    this.nama,
    this.nomor,
    this.uuid,
    this.id,
  });

  factory AlamatModel.fromJson(Map<String, dynamic> json) => AlamatModel(
        label: json["label"],
        alamat: json["alamat"],
        nama: json["nama"],
        nomor: json["nomor"],
        uuid: json["uuid"],
        id: json["_id"],
      );

  factory AlamatModel.fromMap(Map<String, dynamic> json) => AlamatModel(
        label: json["label"],
        alamat: json["alamat"],
        nama: json["nama"],
        nomor: json["nomor"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "alamat": alamat,
        "nama": nama,
        "nomor": nomor,
        "uuid": uuid,
      };
}
