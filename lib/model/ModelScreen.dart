import 'dart:convert';

Model1 ModelFromJson(String str) => Model1.fromJson(json.decode(str));

String ModelToJson(Model1 data) => json.encode(data.toJson());

class Model1 {
  String shlokName;
  String shlokImg;
  String shlokNo;
  String meaning;
  bool favourite;

  Model1({
    required this.shlokName,
    required this.meaning,
    required this.favourite,
    required this.shlokImg,
    required this.shlokNo,
  });

  factory Model1.fromJson(Map<String, dynamic> json) => Model1(
        favourite: json["favourite"],
        shlokImg: json["shlok_img"],
        shlokNo: json["shlok_no"],
        shlokName: json["shlok_name"],
        meaning: json["meaning"],
      );

  Map<String, dynamic> toJson() => {
        "favourite": favourite,
        "shlok_img": shlokImg,
        "shlok_no": shlokNo,
        "shlok_name": shlokName,
        "meaning": meaning,
      };
}

List<Model1> model = [];
