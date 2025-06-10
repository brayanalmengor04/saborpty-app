// To parse this JSON data, do
//
//     final acitivyDetailModel = acitivyDetailModelFromJson(jsonString);
import 'dart:convert';

List<AcitivyDetailModel> acitivyDetailModelFromJson(String str) => List<AcitivyDetailModel>.from(json.decode(str).map((x) => AcitivyDetailModel.fromJson(x)));

String acitivyDetailModelToJson(List<AcitivyDetailModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AcitivyDetailModel {
    String? type;
    String? description;
    String? time;

    AcitivyDetailModel({
        this.type,
        this.description,
        this.time,
    });

    factory AcitivyDetailModel.fromJson(Map<String, dynamic> json) => AcitivyDetailModel(
        type: json["type"],
        description: json["description"],
        time: json["time"],
    );
    Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
        "time": time,
    };
}
