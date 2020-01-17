
import 'dart:convert';

List<ApiList> apiListFromJson(String str) => List<ApiList>.from(json.decode(str).map((x) => ApiList.fromJson(x)));

String apiListToJson(List<ApiList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiList {
    String id;
    String name;
    List<Cards> cards;

    ApiList({
        this.id,
        this.name,
        this.cards,
    });

    factory ApiList.fromJson(Map<String, dynamic> json) => ApiList(
        id: json["id"],
        name: json["name"],
        cards: List<Cards>.from(json["cards"].map((x) => Cards.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
    };
}

class Cards {
    String id;
    String name;
    String desc;

    Cards({
        this.id,
        this.name,
        this.desc,
    });

    factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
    };
}
