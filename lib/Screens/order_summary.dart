import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zaltek/application/item_controller.dart';

class OrderSummary extends StatefulWidget {
  ItemListingController controller;
  OrderSummary({Key? key, required this.controller}) : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          leading: InkWell(
            onTap: () {
              widget.controller.reset(context);
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black54,
            ),
          ),
          title: const Text(
            'Order Summary',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.h),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ]),
              child: GetBuilder<ItemListingController>(
                  id: Get.find<ItemListingController>().itemListingWidgetId,
                  builder: (controller) {
                    return Column(
                      children: [
                        Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                              color: const Color(0xff1A3F14),
                              borderRadius: BorderRadius.circular(10.h)),
                          child: Center(
                            child: Text(
                              '${controller.badgeCount} Dishes - ${controller.badgeCount} Items',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 50.h),
                            ),
                          ),
                        ),
                        SizedBox(height: 800.h, child: itemList(controller)),
                        const Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 50.h),
                              ),
                              Text(
                                'INR ${controller.dishTotal}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 50.h),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.h),
                    width: MediaQuery.of(context).size.width,
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.h),
                        color: const Color(0xff1A3F14)),
                    child: Center(
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.h,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ));
  }

  Widget itemList(ItemListingController controller) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.controller.orderList.toSet().toList().length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 220.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.controller.orderList[index].dishName.toString(),
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 40.h, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'INR ${widget.controller.orderList[index].dishPrice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        '${widget.controller.orderList[index].dishCalories} calories',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black87),
                      )
                    ],
                  )),
              Container(
                height: 100.h,
                margin: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                    color: const Color(0xff1A3F14),
                    borderRadius: BorderRadius.circular(100.h)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.controller.dishes.values
                                      .toList()[index]
                                      .toString() ==
                                  '1'
                              ? null
                              : controller.removeProduct(
                                  widget.controller.orderList[index]);
                        },
                        icon: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 25.h,
                        )),
                    Text(
                      widget.controller.dishes.values
                          .toList()[index]
                          .toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          controller
                              .addProduct(widget.controller.orderList[index]);
                        },
                        icon: Icon(Icons.add, size: 25.h, color: Colors.white)),
                  ],
                ),
              ),
              Text(
                'INR ${widget.controller.dishSubtotal[index]}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 50.h),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
        );
      },
    );
  }
}
