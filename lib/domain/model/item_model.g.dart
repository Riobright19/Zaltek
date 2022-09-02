// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemListingModel _$ItemListingModelFromJson(Map<String, dynamic> json) =>
    ItemListingModel(
      restaurantId: json['restaurant_id'] as String?,
      restaurantName: json['restaurant_name'] as String?,
      restaurantImage: json['restaurant_image'] as String?,
      tableId: json['table_id'] as String?,
      tableName: json['table_name'] as String?,
      branchName: json['branch_name'] as String?,
      nexturl: json['nexturl'] as String?,
      tableMenuList: (json['table_menu_list'] as List<dynamic>?)
          ?.map((e) => TableMenuList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListingModelToJson(ItemListingModel instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId,
      'restaurant_name': instance.restaurantName,
      'restaurant_image': instance.restaurantImage,
      'table_id': instance.tableId,
      'table_name': instance.tableName,
      'branch_name': instance.branchName,
      'nexturl': instance.nexturl,
      'table_menu_list': instance.tableMenuList,
    };

TableMenuList _$TableMenuListFromJson(Map<String, dynamic> json) =>
    TableMenuList(
      menuCategory: json['menu_category'] as String?,
      menuCategoryId: json['menu_category_id'] as String?,
      menuCategoryImage: json['menu_category_image'] as String?,
      nexturl: json['nexturl'] as String?,
      categoryDishes: (json['category_dishes'] as List<dynamic>?)
          ?.map((e) => CategoryDish.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TableMenuListToJson(TableMenuList instance) =>
    <String, dynamic>{
      'menu_category': instance.menuCategory,
      'menu_category_id': instance.menuCategoryId,
      'menu_category_image': instance.menuCategoryImage,
      'nexturl': instance.nexturl,
      'category_dishes': instance.categoryDishes,
    };

CategoryDish _$CategoryDishFromJson(Map<String, dynamic> json) => CategoryDish(
      dishId: json['dish_id'] as String?,
      dishName: json['dish_name'] as String?,
      dishPrice: (json['dish_price'] as num?)?.toDouble(),
      dishImage: json['dish_image'] as String?,
      dishCurrency: json['dish_currency'] as String?,
      dishCalories: (json['dish_calories'] as num?)?.toDouble(),
      dishDescription: json['dish_description'] as String?,
      dishAvailability: json['dish_Availability'] as bool?,
      dishType: (json['dish_Type'] as num?)?.toDouble(),
      nexturl: json['nexturl'] as String?,
      addonCat: (json['addonCat'] as List<dynamic>?)
          ?.map((e) => AddonCat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDishToJson(CategoryDish instance) =>
    <String, dynamic>{
      'dish_id': instance.dishId,
      'dish_name': instance.dishName,
      'dish_price': instance.dishPrice,
      'dish_image': instance.dishImage,
      'dish_currency': instance.dishCurrency,
      'dish_calories': instance.dishCalories,
      'dish_description': instance.dishDescription,
      'dish_Availability': instance.dishAvailability,
      'dish_Type': instance.dishType,
      'nexturl': instance.nexturl,
      'addonCat': instance.addonCat,
    };

AddonCat _$AddonCatFromJson(Map<String, dynamic> json) => AddonCat(
      addonCategory: json['addon_category'] as String?,
      addonCategoryId: json['addon_category_id'] as String?,
      addonSelection: (json['addon_selection'] as num?)?.toDouble(),
      nexturl: json['nexturl'] as String?,
      addons: (json['addons'] as List<dynamic>?)
          ?.map((e) => Addon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddonCatToJson(AddonCat instance) => <String, dynamic>{
      'addon_category': instance.addonCategory,
      'addon_category_id': instance.addonCategoryId,
      'addon_selection': instance.addonSelection,
      'nexturl': instance.nexturl,
      'addons': instance.addons,
    };

Addon _$AddonFromJson(Map<String, dynamic> json) => Addon(
      dishId: json['dish_id'] as String?,
      dishName: json['dish_name'] as String?,
      dishPrice: (json['dish_price'] as num?)?.toDouble(),
      dishImage: json['dish_image'] as String?,
      dishCurrency: json['dish_currency'] as String?,
      dishCalories: (json['dish_calories'] as num?)?.toDouble(),
      dishDescription: json['dish_description'] as String?,
      dishAvailability: json['dish_Availability'] as bool?,
      dishType: (json['dish_Type'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddonToJson(Addon instance) => <String, dynamic>{
      'dish_id': instance.dishId,
      'dish_name': instance.dishName,
      'dish_price': instance.dishPrice,
      'dish_image': instance.dishImage,
      'dish_currency': instance.dishCurrency,
      'dish_calories': instance.dishCalories,
      'dish_description': instance.dishDescription,
      'dish_Availability': instance.dishAvailability,
      'dish_Type': instance.dishType,
    };
