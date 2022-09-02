import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zaltek/Screens/order_summary.dart';
import 'package:zaltek/application/item_controller.dart';

import 'widgets/nav_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: Get.find<ItemListingController>().menuList.length, vsync: this);
    tabController!.addListener(_getActiveTabIndex);
  }

  void _getActiveTabIndex() {
    setState(() {
      _selectedIndex = tabController!.index;
    });
  }

  @override
  void dispose() {
    tabController!.dispose();
    Get.find<ItemListingController>().reset(context);
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            GetBuilder<ItemListingController>(
                id: Get.find<ItemListingController>().itemListingWidgetId,
                builder: (controller) {
                  return InkWell(
                    onTap: () {
                      controller.orderList.isNotEmpty
                          ? Navigator.push(
                              Get.context!,
                              MaterialPageRoute(
                                  builder: (context) => OrderSummary(
                                        controller: controller,
                                      )),
                            )
                          : Get.snackbar(
                              "ALERT", "No items addd to the cart !!!!",
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(25.h),
                      child: Badge(
                        padding: EdgeInsets.all(18.h),
                        badgeContent: Text(
                          Get.find<ItemListingController>().badgeCount,
                          style: const TextStyle(color: Colors.white),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.grey,
                          size: 70.h,
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              width: 30.w,
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 4.0,
              // ignore: prefer_const_constructors
              onTap: (i) {
                Get.find<ItemListingController>()
                    .itemsToDisplay(_selectedIndex);
              },

              indicator: const ShapeDecoration(
                  shape: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                          style: BorderStyle.solid)),
                  color: Colors.red),
              tabs: Get.find<ItemListingController>()
                  .menuList
                  .map((tabName) => Container(
                        color: Colors.white,
                        child: Text(
                          tabName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40.h),
                        ),
                      ))
                  .toList(),
              controller: tabController,
            ),
          ),
        ),
        body: GetBuilder<ItemListingController>(
            id: Get.find<ItemListingController>().itemListingWidgetId,
            builder: (controller) {
              if (controller.isLoadingItems.isTrue) {
                return const Center(
                  child: Text('Loading Error'),
                );
              } else if (controller.isLoadingItems.isTrue ||
                  controller.displyItemList.isEmpty) {
                return const Center(
                  child: Text('Loading'),
                );
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemSale(
                        controller: controller,
                        index: index,
                        quantity: controller.dishes.values.toList());
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.grey,
                    );
                  },
                  itemCount: controller.displyItemList.length);
            }));
  }
}

// ignore: must_be_immutable
class ItemSale extends StatefulWidget {
  final ItemListingController controller;
  List quantity;
  final int index;

  ItemSale({
    Key? key,
    required this.controller,
    // required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  State<ItemSale> createState() => _ItemSaleState();
}

class _ItemSaleState extends State<ItemSale> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  width: 45.h,
                  height: 45.h,
                  margin: EdgeInsets.symmetric(vertical: 15.h),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.red)),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      size: 30.h,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                  flex: 10,
                  child: SizedBox(
                    height: 480.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.controller.displyItemList[widget.index]
                                .dishName
                                .toString(),
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 50.h, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SAR ${widget.controller.displyItemList[widget.index].dishPrice.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${widget.controller.displyItemList[widget.index].dishCalories.toString()} calories',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          flex: 4,
                          child: SizedBox(
                            height: 200.h,
                            width: 700.w,
                            child: Text(
                              widget.controller.displyItemList[widget.index]
                                  .dishDescription
                                  .toString(),
                              style: const TextStyle(color: Colors.black54),
                              overflow: TextOverflow.clip,
                              maxLines: 3,
                            ),
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 300.w,
                          margin: EdgeInsets.all(8.h),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100.h)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    widget.controller.removeProduct(widget
                                        .controller
                                        .displyItemList[widget.index]);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 45.h,
                                  )),
                              Text(
                                widget.index < widget.quantity.length
                                    ? widget.quantity[widget.index].toString()
                                    : '0',
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {
                                    widget.controller.addProduct(widget
                                        .controller
                                        .displyItemList[widget.index]);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add,
                                      size: 45.h, color: Colors.white)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        widget.controller.displyItemList[widget.index].addonCat!
                                .isEmpty
                            ? const SizedBox()
                            : const Text(
                                '   Customiztions Available',
                                style: TextStyle(color: Colors.red),
                              )
                      ],
                    ),
                  )),
              SizedBox(
                width: 10.h,
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                    width: 100.h,
                    height: 200.h,
                    child: Image(
                      fit: BoxFit.cover,
                      image: const NetworkImage(
                          'https://img.freepik.com/free-photo/flat-lay-batch-cooking-composition_23-2148765597.jpg?w=2000'),
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.network(widget
                            .controller.displyItemList[widget.index].dishName
                            .toString());
                      },
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
