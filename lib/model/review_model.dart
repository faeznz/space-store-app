class KaosModel {
  String? review;
  String? id;
  String? oid;

  KaosModel({
    this.review,
    this.id,
    this.oid,
  });

  factory KaosModel.fromJson(Map<String, dynamic> json) => KaosModel(
        review: json["review"],
        id: json["id"],
        oid: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "review": review,
        "id": id,
        "_id": oid,
      };
}
