// To parse this JSON data, do
//
//     final countHour = countHourFromJson(jsonString);

import 'dart:convert';

CountHour countHourFromJson(String str) => CountHour.fromJson(json.decode(str));

String countHourToJson(CountHour data) => json.encode(data.toJson());

class CountHour {
    CountHour({
       required this.countHour,
    });

    int countHour;

    factory CountHour.fromJson(Map<String, dynamic> json) => CountHour(
        countHour: json["countHour"],
    );

    Map<String, dynamic> toJson() => {
        "countHour": countHour,
    };
}
