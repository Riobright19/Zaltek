import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemListingModel {
  @JsonKey(name: 'restaurant_id')
  String? restaurantId;
  @JsonKey(name: 'restaurant_name')
  String? restaurantName;
  @JsonKey(name: 'restaurant_image')
  String? restaurantImage;
  @JsonKey(name: 'table_id')
  String? tableId;
  @JsonKey(name: 'table_name')
  String? tableName;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'nexturl')
  String? nexturl;
  @JsonKey(name: 'table_menu_list')
  List<TableMenuList>? tableMenuList;

  ItemListingModel({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.tableId,
    this.tableName,
    this.branchName,
    this.nexturl,
    this.tableMenuList,
  });

  factory ItemListingModel.fromJson(Map<String, dynamic> json) =>
      _$ItemListingModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemListingModelToJson(this);
}

@JsonSerializable()
class TableMenuList {
  @JsonKey(name: 'menu_category')
  String? menuCategory;
  @JsonKey(name: 'menu_category_id')
  String? menuCategoryId;
  @JsonKey(name: 'menu_category_image')
  String? menuCategoryImage;
  @JsonKey(name: 'nexturl')
  String? nexturl;
  @JsonKey(name: 'category_dishes')
  List<CategoryDish>? categoryDishes;

  TableMenuList({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nexturl,
    this.categoryDishes,
  });

  factory TableMenuList.fromJson(Map<String, dynamic> json) =>
      _$TableMenuListFromJson(json);
  Map<String, dynamic> toJson() => _$TableMenuListToJson(this);
}

@JsonSerializable()
class CategoryDish {
  @JsonKey(name: 'dish_id')
  String? dishId;
  @JsonKey(name: 'dish_name')
  String? dishName;
  @JsonKey(name: 'dish_price')
  double? dishPrice;
  @JsonKey(name: 'dish_image')
  String? dishImage;
  @JsonKey(name: 'dish_currency')
  String? dishCurrency;
  @JsonKey(name: 'dish_calories')
  double? dishCalories;
  @JsonKey(name: 'dish_description')
  String? dishDescription;
  @JsonKey(name: 'dish_Availability')
  bool? dishAvailability;
  @JsonKey(name: 'dish_Type')
  double? dishType;
  @JsonKey(name: 'nexturl')
  String? nexturl;
  @JsonKey(name: 'addonCat')
  List<AddonCat>? addonCat;

  CategoryDish({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.dishType,
    this.nexturl,
    this.addonCat,
  });

  factory CategoryDish.fromJson(Map<String, dynamic> json) =>
      _$CategoryDishFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDishToJson(this);
}

@JsonSerializable()
class AddonCat {
  @JsonKey(name: 'addon_category')
  String? addonCategory;
  @JsonKey(name: 'addon_category_id')
  String? addonCategoryId;
  @JsonKey(name: 'addon_selection')
  double? addonSelection;
  @JsonKey(name: 'nexturl')
  String? nexturl;
  @JsonKey(name: 'addons')
  List<Addon>? addons;

  AddonCat({
    this.addonCategory,
    this.addonCategoryId,
    this.addonSelection,
    this.nexturl,
    this.addons,
  });

  factory AddonCat.fromJson(Map<String, dynamic> json) =>
      _$AddonCatFromJson(json);
  Map<String, dynamic> toJson() => _$AddonCatToJson(this);
}

@JsonSerializable()
class Addon {
  @JsonKey(name: 'dish_id')
  String? dishId;
  @JsonKey(name: 'dish_name')
  String? dishName;
  @JsonKey(name: 'dish_price')
  double? dishPrice;
  @JsonKey(name: 'dish_image')
  String? dishImage;
  @JsonKey(name: 'dish_currency')
  String? dishCurrency;
  @JsonKey(name: 'dish_calories')
  double? dishCalories;
  @JsonKey(name: 'dish_description')
  String? dishDescription;
  @JsonKey(name: 'dish_Availability')
  bool? dishAvailability;
  @JsonKey(name: 'dish_Type')
  double? dishType;

  Addon({
    this.dishId,
    this.dishName,
    this.dishPrice,
    this.dishImage,
    this.dishCurrency,
    this.dishCalories,
    this.dishDescription,
    this.dishAvailability,
    this.dishType,
  });

  factory Addon.fromJson(Map<String, dynamic> json) => _$AddonFromJson(json);

  Map<String, dynamic> toJson() => _$AddonToJson(this);
}
