// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:admin/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../api.dart';
import '../../helpers/colors.dart';
import '../../helpers/image_placeholder.dart';
import '../../layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with RestorationMixin {
  final RestorableTextEditingController _usernameController =
      RestorableTextEditingController();
  final RestorableTextEditingController _passwordController =
      RestorableTextEditingController();

  @override
  String get restorationId => 'login_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_usernameController, restorationId);
    registerForRestoration(_passwordController, restorationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(102, 102, 102, 2),
      body: SafeArea(
        child: _MainView(
          usernameController: _usernameController.value,
          passwordController: _passwordController.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _MainView extends StatefulWidget {
  const _MainView({
    this.usernameController,
    this.passwordController,
  });

  final TextEditingController? usernameController;
  final TextEditingController? passwordController;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> {
  BoxDecoration? borderDecoration;
  bool showError = false;
  void _login(BuildContext context) {
    Get.to(SiteLayout());
  }

  @override
  Widget build(BuildContext context) {
    var screenw = MediaQuery.of(context).size.width;
    final isDesktop = screenw > 700 ? true : false;
    List<Widget> listViewChildren;
    String logStatus = "0";
    bool logStatus1 = false;

    if (isDesktop) {
      final desktopMaxWidth = screenw / 4;
      listViewChildren = [
        const _AppLogo(),
        _UsernameInput(
          maxWidth: 400,
          usernameController: widget.usernameController,
        ),
        const SizedBox(height: 12),
        _PasswordInput(
          maxWidth: 400,
          passwordController: widget.passwordController,
        ),
        const SizedBox(height: 12),
        _LoginButton(
          maxWidth: 400,
          onTap: () async {
            logStatus1 = await userValidationTemp(widget.usernameController!.text,
                widget.passwordController!.text);
            if (logStatus1) {
              showError = false;
              _login(context);
            } else {
              showError = true;
              setState(() {});
            }
          },
          status: showError,
        ),
      ];
    } else {
      listViewChildren = [
        const _AppLogo(),
        _UsernameInput(
          usernameController: widget.usernameController,
        ),
        const SizedBox(height: 12),
        _PasswordInput(
          passwordController: widget.passwordController,
        ),
        _ThumbButton(
          onTap: () {
            _login(context);
          },
        ),
      ];
    }

    return Column(
      children: [
        // if (isDesktop) const _TopBar(),
        Expanded(
          child: Align(
            alignment: isDesktop ? Alignment.center : Alignment.topCenter,
            child: ListView(
              restorationId: 'login_list_view',
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: listViewChildren,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    const spacing = SizedBox(width: 30);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ExcludeSemantics(
              //   child: SizedBox(
              //     height: 80,
              //     child: FadeInImagePlaceholder(
              //       image:
              //           const AssetImage('logo.png', package: 'rally_assets'),
              //       placeholder: LayoutBuilder(builder: (context, constraints) {
              //         return SizedBox(
              //           width: constraints.maxHeight,
              //           height: constraints.maxHeight,
              //         );
              //       }),
              //     ),
              //   ),
              // ),
              spacing,
              Text(
                "HRMS",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 35 / 2,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text(
          //       "",
          //       style: Theme.of(context).textTheme.titleMedium,
          //     ),
          //     spacing,
          //     const _BorderButton(
          //       text: "",
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children:  const [
          SizedBox(
            height: 160,
            child: ExcludeSemantics(
              child: FadeInImagePlaceholder(
                image: AssetImage('images/app_icon.png'),
                placeholder: SizedBox.shrink(),
              ),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              "HR Mate",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  fontFamily: "LobsterFont",
                  color: Colors.black54 ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    this.maxWidth,
    this.usernameController,
  });

  final double? maxWidth;
  final TextEditingController? usernameController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          autofillHints: const [AutofillHints.username],
          textInputAction: TextInputAction.next,
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: "User Name",
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    this.maxWidth,
    this.passwordController,
  });

  final double? maxWidth;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: "Password",
          ),
          obscureText: true,
        ),
      ),
    );
  }
}

class _ThumbButton extends StatefulWidget {
  const _ThumbButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  _ThumbButtonState createState() => _ThumbButtonState();
}

class _ThumbButtonState extends State<_ThumbButton> {
  BoxDecoration? borderDecoration;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: true,
      label: "HRMS",
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Focus(
            onKey: (node, event) {
              if (event is RawKeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.space) {
                  widget.onTap();
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                setState(() {
                  borderDecoration = BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 2,
                    ),
                  );
                });
              } else {
                setState(() {
                  borderDecoration = null;
                });
              }
            },
            child: Container(
              decoration: borderDecoration,
              height: 120,
              child: ExcludeSemantics(
                child: Image.asset(
                  'thumb.png',
                  package: 'rally_assets',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatefulWidget {
  _LoginButton({required this.onTap, this.maxWidth, required this.status});

  bool status;
  final double? maxWidth;
  final VoidCallback onTap;

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  BoxDecoration? borderDecoration;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: widget.maxWidth ?? double.infinity),
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            widget.status
                ? const Icon(Icons.error_outline_rounded, color: Colors.red)
                : Container(),
            widget.status ? const SizedBox(width: 12) : Container(),
            widget.status
                ? const Text("user name or password is wrong")
                : Container(),
            const Expanded(child: SizedBox.shrink()),
            _FilledButton(
              text: "Login",
              onTap: widget.onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _BorderButton extends StatelessWidget {
  const _BorderButton({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: RallyColors.buttonColor),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Get.to(SiteLayout());
      },
      child: Text(text),
    );
  }
}

class _FilledButton extends StatelessWidget {
  const _FilledButton({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: RallyColors.buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          const Icon(Icons.lock),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }
}
