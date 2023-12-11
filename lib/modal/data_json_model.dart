class DataJsonModel {
  List<FastFoodItems>? fastFoodItems;

  DataJsonModel({this.fastFoodItems});

  DataJsonModel.fromJson(Map<String, dynamic> json) {
    if (json['fast_food_items'] != null) {
      fastFoodItems = <FastFoodItems>[];
      json['fast_food_items'].forEach((v) {
        fastFoodItems!.add(new FastFoodItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fastFoodItems != null) {
      data['fast_food_items'] =
          this.fastFoodItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FastFoodItems {
  String? name;
  String? image;
  String? description;
  bool? veg;

  FastFoodItems({this.name, this.image, this.description, this.veg});

  FastFoodItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    veg = json['veg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['veg'] = this.veg;
    return data;
  }
}
