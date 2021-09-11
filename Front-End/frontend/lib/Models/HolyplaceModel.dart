class HolyplaceModel {
  String? createtor_id;
  String? nameofholyplace;
  String? location;
  String? history;
  String? imageUrl;

  HolyplaceModel(this.createtor_id, this.nameofholyplace,
      {this.location, this.history, this.imageUrl});

  factory HolyplaceModel.fromJson(Map<String, dynamic> json) {
    return HolyplaceModel(
      json['creator_id'],
      json['nameofholyplace'],
    );
  }

  Map<String, dynamic> tojson() {
    return {"create_id": createtor_id, "nameofholyplace": nameofholyplace};
  }
}
