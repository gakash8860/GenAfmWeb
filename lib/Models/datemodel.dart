// To parse this JSON data, do
//
//     final dateTable = dateTableFromJson(jsonString);

import 'dart:convert';

DateTable dateTableFromJson(String str) => DateTable.fromJson(json.decode(str));

String dateTableToJson(DateTable data) => json.encode(data.toJson());

class DateTable {
      DateTable({
        this.dId,
        this.sensor,
        this.date,
        this.hour1,
        this.hour2,
        this.hour3,
        this.hour4,
        this.hour5,
        this.hour6,
        this.hour7,
        this.hour8,
        this.hour9,
        this.hour10,
        this.hour11,
        this.hour12,
        this.hour13,
        this.hour14,
        this.hour15,
        this.hour16,
        this.hour17,
        this.hour18,
        this.hour19,
        this.hour20,
        this.hour21,
        this.hour22,
        this.hour23,
        this.hour24,
    });

    String? dId;
    double? sensor;
    String? date;
    String? hour1;
    String? hour2;
    String? hour3;
    String? hour4;
    String? hour5;
    String? hour6;
    String? hour7;
    String? hour8;
    String? hour9;
    String? hour10;
    String? hour11;
    String? hour12;
    String? hour13;
    String? hour14;
    String? hour15;
    String? hour16;
    String? hour17;
    String? hour18;
    String? hour19;
    String? hour20;
    String? hour21;
    String? hour22;
    String? hour23;
    String? hour24;

    factory DateTable.fromJson(Map<String, dynamic> json) => DateTable(
        dId: json["d_id"],
        sensor: json["sensor"].toDouble(),
        date: json["date"].toString(),
        hour1: json["hour1"].toString(),
        hour2: json["hour2"].toString(),
        hour3: json["hour3"].toString(),
        hour4: json["hour4"].toString(),
        hour5: json["hour5"].toString(),
        hour6: json["hour6"].toString(),
        hour7: json["hour7"].toString(),
        hour8: json["hour8"].toString(),
        hour9: json["hour9"].toString(),
        hour10: json["hour10"].toString(),
        hour11: json["hour11"].toString(),
        hour12: json["hour12"].toString(),
        hour13: json["hour13"].toString(),
        hour14: json["hour14"].toString(),
        hour15: json["hour15"].toString(),
        hour16: json["hour16"].toString(),
        hour17: json["hour17"].toString(),
        hour18: json["hour18"].toString(),
        hour19: json["hour19"].toString(),
        hour20: json["hour20"].toString(),
        hour21: json["hour21"].toString(),
        hour22: json["hour22"].toString(),
        hour23: json["hour23"].toString(),
        hour24: json["hour24"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "d_id": dId,
        "sensor": sensor,
        "date": date,
        "hour1": hour1,
        "hour2": hour2,
        "hour3": hour3,
        "hour4": hour4,
        "hour5": hour5,
        "hour6": hour6,
        "hour7": hour7,
        "hour8": hour8,
        "hour9": hour9,
        "hour10": hour10,
        "hour11": hour11,
        "hour12": hour12,
        "hour13": hour13,
        "hour14": hour14,
        "hour15": hour15,
        "hour16": hour16,
        "hour17": hour17,
        "hour18": hour18,
        "hour19": hour19,
        "hour20": hour20,
        "hour21": hour21,
        "hour22": hour22,
        "hour23": hour23,
        "hour24": hour24,
    };
}
