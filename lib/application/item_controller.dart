import 'package:get/get.dart';
import 'package:zaltek/domain/exceptions/network_exceptions.dart';
import 'package:zaltek/domain/model/item_list_facde.dart';
import 'package:zaltek/domain/model/item_model.dart';

class ItemListingController extends GetxController {
  final ItemListingFacade _itemListingFacade;

  ItemListingController(this._itemListingFacade);
  String get itemListingWidgetId => 'itemListingWidgetId';
  Rx<bool> isLoadingItems = false.obs;

  Rx<bool> itemListingExceptionOccured = Rx(false);
  List<ItemListingModel> itemsList = [];

  final List _menuList = [];
  List<CategoryDish> _displayItem = [];
  List get menuList => _menuList;
  List<CategoryDish> get displyItemList => _displayItem;

  Future<void> getAllItems() async {
    isLoadingItems = Rx(true);
    final result = await _itemListingFacade.getItemList();
    result.fold(
      (NetworkExceptions exceptions) {
        isLoadingItems = Rx(false);
        itemListingExceptionOccured = Rx(true);
        update([itemListingWidgetId]);
      },
      (List<ItemListingModel> resp) {
        isLoadingItems = Rx(false);
        itemListingExceptionOccured = Rx(false);
        itemsList.addAll(resp);
        for (int i = 0; i < itemsList[0].tableMenuList!.length; i++) {
          _menuList.add(itemsList[0].tableMenuList![i].menuCategory.toString());
        }
        _displayItem = itemsList[0].tableMenuList![0].categoryDishes!;
        update([itemListingWidgetId]);
      },
    );
  }

  Future<void> itemsToDisplay(int index) async {
    _displayItem = itemsList[0].tableMenuList![index].categoryDishes!;
    update([itemListingWidgetId]);
  }

  final _dishes = {}.obs;

  final List<CategoryDish> _orderList = [];

  void addProduct(CategoryDish dish) {
    _orderList.add(dish);
    try {
      if (_dishes.containsKey(dish)) {
        _dishes[dish] += 1;
      } else {
        _dishes[dish] = 1;
      }
    } on Exception catch (e) {
      Get.snackbar("Alert", "Something went wrong!!",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
    update([itemListingWidgetId]);
    Get.snackbar("Item Added", "You have added the ${dish.dishName}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));
    _orderList.toSet().toList();
  }

  void removeProduct(CategoryDish dish) {
    _orderList.remove(dish);
    if (_dishes[dish] == null) {
      Get.snackbar("Alert", "${dish.dishName} already removed",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2));
    }
    if (_dishes.containsKey(dish) && _dishes[dish] == 1) {
      _dishes.removeWhere((key, value) => key == dish);
    } else {
      _dishes[dish] -= 1;
    }
    update([itemListingWidgetId]);
    Get.snackbar("Item Removed", "You have removed the ${dish.dishName}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2));
    _orderList.toSet().toList();
  }

  List<CategoryDish> get orderList => _orderList;

  get dishes => _dishes;

  String get badgeCount => _dishes.keys.toList().length.toString();

  get dishSubtotal => _dishes.entries
      .map((product) =>
          double.parse(product.key.dishPrice.toString()) *
          int.parse(product.value.toString()))
      .toList();
  get dishTotal => _dishes.entries
      .map((product) =>
          double.parse(product.key.dishPrice.toString()) *
          int.parse(product.value.toString()))
      .toList()
      .reduce((value, element) => value + element);

  void reset(context) {
    _dishes.clear();
    _orderList.clear();
    update([itemListingWidgetId]);
  }
}
