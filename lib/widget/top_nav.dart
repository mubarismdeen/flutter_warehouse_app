import 'package:admin/constants/style.dart';
import 'package:admin/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

import '../globalState.dart';
import '../helpers/image_placeholder.dart';
import 'custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Hero(
            tag: 'icon',
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: const ExcludeSemantics(
                child: FadeInImagePlaceholder(
                  image: AssetImage('images/app_icon.png'),
                  placeholder: SizedBox.shrink(),
                ),
              ),
            ),
          )
          : IconButton(
              icon: const Icon(Icons.menu_outlined),
              onPressed: () {
                key.currentState?.openDrawer();
              }),
      elevation: 0,
      title: Wrap(children: [
        Row(
          children: [
            if (!ResponsiveWidget.isSmallScreen(context))
              ResponsiveWidget.isLargeScreen(context)
              ? const Text(
                'WarehousXpress',
                style: appNameStyle,
              )
              : const Text(
                'WX',
                style: appNameStyle,
              ),
            Expanded(child: Container()),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: lightGrey.withOpacity(.7),
              ),
              onPressed: () {},
            ),
            Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: lightGrey.withOpacity(.7),
                    ),
                    onPressed: () {}),
                Positioned(
                    top: 7,
                    right: 7,
                    child: Container(
                      width: 8,
                      height: 12,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: light, width: 2)),
                    ))
              ],
            ),
            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomText(
                text: GlobalState.username,
                size: 16,
                color: lightGrey,
                weight: FontWeight.bold),
            const SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: const CircleAvatar(
                  backgroundColor: light,
                  child: Icon(
                    Icons.person_outline,
                    color: lightGrey,
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
      iconTheme: const IconThemeData(color: lightGrey),
      backgroundColor: Colors.transparent,
    );
