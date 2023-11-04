import 'package:admin/routes/routes.dart';
import 'package:admin/widget/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import '../globalState.dart';
import '../helpers/image_placeholder.dart';
import '../helpers/responsiveness.dart';
import '../pages/login/login.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        color: themeColor,
        child: ListView(children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(
                //   height: 40,
                // ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Hero(
                        tag: 'icon',
                        child: Container(
                          height: 55,
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: const ExcludeSemantics(
                            child: FadeInImagePlaceholder(
                              image: AssetImage('images/app_icon.png'),
                              placeholder: SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        'WarehousXpress',
                        style: appNameStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(width: _width / 48),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: GlobalState.sideMenuItems
                .map((itemName) => SideMenuItem(
                      itemName: itemName == AuthenticationPageRoute
                          ? "Log out"
                          : itemName,
                      onTap: () {
                        if (itemName == AuthenticationPageRoute) {
                          Get.off(const LoginPage());
                        }
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(itemName);
                        }
                      },
                    ))
                .toList(),
          ),
        ]));
  }
}
