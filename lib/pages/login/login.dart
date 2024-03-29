import 'package:admin/constants/style.dart';
import 'package:admin/globalState.dart';
import 'package:admin/models/userScreens.dart';
import 'package:admin/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
      backgroundColor: themeColor,
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
  bool showLoading = false;
  void _login(BuildContext context) {
    Get.to(SiteLayout());
  }

  @override
  Widget build(BuildContext context) {
    var screenw = MediaQuery.of(context).size.width;
    final isDesktop = screenw > 700 ? true : false;
    List<Widget> listViewChildren;
    bool logStatus1 = false;

      listViewChildren = [
        _AppLogo(isDesktop),
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
            setState(() {
              showLoading = true;
            });

            List<UserScreens> screensForUser = [];
            try {
              screensForUser = await authorizeUser(
                widget.usernameController!.text,
                widget.passwordController!.text,
              );
            } catch (ex) {
              setState(() {
                showError = false;
              });
              showSaveFailedMessage(context, "Error in establishing connection with the server");
            }

            if (screensForUser.isNotEmpty) {
              logStatus1 = true;
              GlobalState.setScreensForUser(widget.usernameController!.text, screensForUser.first);
            }
            if (logStatus1) {
              showError = false;
              setState(() {
                showLoading = false;
              });
              _login(context);
            } else {
              showError = true;
              setState(() {
                showLoading = false;
              });
            }
          },
          status: showError,
        ),
      ];

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: isDesktop ? Alignment.center : Alignment.topCenter,
            child: showLoading
                ? const SpinKitWave(
                    color: Colors.white,
                    size: 30,
                  )
                : ListView(
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

class _AppLogo extends StatelessWidget {
  final isDesktop;

  const _AppLogo([this.isDesktop = true]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 70),
      child: Column(
        children: [
          Hero(
            tag: 'icon',
            child: SizedBox(
              height: isDesktop ? 160 : 100,
              child: const ExcludeSemantics(
                child: FadeInImagePlaceholder(
                  image: AssetImage('images/app_icon.png'),
                  placeholder: SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              "WarehousXpress",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: isDesktop ? 30 : 25,
                  fontFamily: "LobsterFont",
                  color: Colors.white),
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
      child: InputBox(
          maxWidth: maxWidth,
          displayText: "Username",
          obscureText: false,
          controller: usernameController),
    );
  }
}

class InputBox extends StatelessWidget {
  OutlineInputBorder inputBoxStyle = const OutlineInputBorder(
    borderSide: BorderSide(color: RallyColors.buttonColor),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  late final double? maxWidth;
  String? displayText;
  final TextEditingController? controller;
  bool obscureText;

  InputBox(
      {Key? key,
      this.maxWidth,
      required this.displayText,
      required this.obscureText,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        autofillHints: const [AutofillHints.username],
        textInputAction: TextInputAction.next,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: displayText,
          labelStyle: const TextStyle(color: RallyColors.buttonColor),
          focusColor: Colors.white,
          enabledBorder: inputBoxStyle,
          focusedBorder: inputBoxStyle,
        ),
        cursorColor: RallyColors.buttonColor,
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
      child: InputBox(
          maxWidth: maxWidth,
          displayText: "Password",
          obscureText: true,
          controller: passwordController),
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
                ? const Text(
                    "username or password is wrong",
                    style: TextStyle(color: Colors.white),
                  )
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
