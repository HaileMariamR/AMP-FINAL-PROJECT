class Schedule {
  String? createdby;
  String? title;
  String? description;
  List<String>? allprograms;
  Schedule(this.createdby, this.allprograms,{this.title,this.description});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      json['createdby'],
      json['programs'],
      title: json['title'],
      description: json['description'],

    );
  }

  Map<String, dynamic> tojson() {
    return {
      "createdby": createdby,
      "programs ": allprograms,
      "title ": title,
      "description ": description,
    };
  }
}
