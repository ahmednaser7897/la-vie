// ignore_for_file: unnecessary_null_comparison

class Blogs {
  String? type;
  String? message;
  Data? data;

  Blogs({type, message, data});

  Blogs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Plant>? plants;
  List<Seed>? seeds;
  List<Tool>? tools;

  Data({plants, seeds, tools});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['plants'] != null) {
      plants = <Plant>[];
      json['plants'].forEach((v) {
        plants!.add(Plant.fromJson(v));
      });
    }
    if (json['seeds'] != null) {
      seeds = <Seed>[];
      json['seeds'].forEach((v) {
        seeds!.add(Seed.fromJson(v));
      });
    }
    if (json['tools'] != null) {
      tools = <Tool>[];
      json['tools'].forEach((v) {
        tools!.add(Tool.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (plants != null) {
      data['plants'] = plants!.map((v) => v.toJson()).toList();
    }
    if (seeds != null) {
      data['seeds'] = seeds!.map((v) => v.toJson()).toList();
    }
    if (tools != null) {
      data['tools'] = tools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainData {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  MainData({this.id, this.name, this.description, this.imageUrl});
}

class Plant extends MainData {
  int? waterCapacity;
  int? sunLight;
  int? temperature;
  Plant(
      {super.id,
      super.name,
      super.description,
      super.imageUrl,
      this.waterCapacity,
      this.sunLight,
      this.temperature});

  Plant.fromJson(Map<String, dynamic> json) {
    id = json['plantId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plantId'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['waterCapacity'] = waterCapacity;
    data['sunLight'] = sunLight;
    data['temperature'] = temperature;
    return data;
  }
}

class Seed extends MainData {
  Seed.fromJson(Map<String, dynamic> json) {
    id = json['seedId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seedId'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Tool extends MainData {
  Tool.fromJson(Map<String, dynamic> json) {
    id = json['toolId'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toolId'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
