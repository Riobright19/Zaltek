import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zaltek/application/auth_controller.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Muhammed Naseem',
                  style: TextStyle(color: Colors.black, fontSize: 50.h),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  'ID : 410',
                  style: TextStyle(color: Colors.black, fontSize: 35.h),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.h),
                    bottomRight: Radius.circular(40.h))),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              'Log out',
              style: TextStyle(color: Colors.grey, fontSize: 50.h),
            ),
            onTap: () => {Get.find<AuthController>().signOut()},
          ),
        ],
      ),
    );
  }
}
