// To parse this JSON data, do
//
//     final modelDate = modelDateFromJson(jsonString);

import 'dart:convert';

ModelDate modelDateFromJson(String str) => ModelDate.fromJson(json.decode(str));

String modelDateToJson(ModelDate data) => json.encode(data.toJson());

class ModelDate {
    ModelDate({
        this.dId,
        this.sensor1,
        this.sensor2,
        this.sensor3,
        this.sensor4,
        this.sensor5,
        this.sensor6,
        this.sensor7,
        this.sensor8,
        this.sensor9,
        this.sensor10,
        this.date,
        this.hour,
    });

    String? dId;
    double? sensor1;
    double? sensor2;
    double? sensor3;
    double? sensor4;
    double? sensor5;
    double? sensor6;
    double? sensor7;
    double? sensor8;
    double? sensor9;
    double? sensor10;
    String? date;
    int? hour;

    factory ModelDate.fromJson(Map<String, dynamic> json) => ModelDate(
        dId: json["d_id"],
        sensor1: json["sensor1"].toDouble(),
        sensor2: json["sensor2"].toDouble(),
        sensor3: json["sensor3"].toDouble(),
        sensor4: json["sensor4"].toDouble(),
        sensor5: json["sensor5"].toDouble(),
        sensor6: json["sensor6"].toDouble(),
        sensor7: json["sensor7"].toDouble(),
        sensor8: json["sensor8"].toDouble(),
        sensor9: json["sensor9"].toDouble(),
        sensor10: json["sensor10"].toDouble(),
        date: json["date"],
        hour: json["hour"],
    );

    Map<String, dynamic> toJson() => {
        "d_id": dId,
        "sensor1": sensor1,
        "sensor2": sensor2,
        "sensor3": sensor3,
        "sensor4": sensor4,
        "sensor5": sensor5,
        "sensor6": sensor6,
        "sensor7": sensor7,
        "sensor8": sensor8,
        "sensor9": sensor9,
        "sensor10": sensor10,
        "date": date,
        "hour": hour,
    };
   factory ModelDate.fromMap(Map<String, dynamic> json) => ModelDate(
        dId: json["d_id"],
        sensor1: json["sensor1"],
        sensor2: json["sensor2"],
        sensor3: json["sensor3"],
        sensor4: json["sensor4"],
        sensor5: json["sensor5"],
        sensor6: json["sensor6"],
        sensor7: json["sensor7"],
        sensor8: json["sensor8"],
        sensor9: json["sensor9"],
        sensor10: json["sensor10"],
        date: json["date"],
        hour: json["hour"],
    );

    Map<String, dynamic> toMap() => {
        "d_id": dId,
        "sensor1": sensor1,
        "sensor2": sensor2,
        "sensor3": sensor3,
        "sensor4": sensor4,
        "sensor5": sensor5,
        "sensor6": sensor6,
        "sensor7": sensor7,
        "sensor8": sensor8,
        "sensor9": sensor9,
        "sensor10": sensor10,
        "date": date,
        "hour": hour,
    };
   
}
