class KaosModel {
  String? image;
  String? nama;
  String? harga;
  String? keterangan;
  String? rating;
  String? id;
  String? oid;
  List? review;

  KaosModel({
    this.image,
    this.nama,
    this.harga,
    this.keterangan,
    this.rating,
    this.id,
    this.oid,
    this.review,
  });

  factory KaosModel.fromJson(Map<String, dynamic> json) => KaosModel(
        image: json["image"],
        nama: json["nama"],
        harga: json["harga"],
        keterangan: json["keterangan"],
        rating: json["rating"],
        id: json["id"],
        oid: json["_id"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "nama": nama,
        "harga": harga,
        "keterangan": keterangan,
        "rating": rating,
        "id": id,
        "_id": oid,
        "review": review,
      };
}
