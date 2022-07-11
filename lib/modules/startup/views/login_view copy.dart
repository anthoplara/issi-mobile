/* import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/home/views/dashboard_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:mobile/utils/networks/key_storage.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GetStorage localData = GetStorage();
  final LoginBloc _loginBloc = LoginBloc();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool remember = false;

  String errorMessage = "";

  @override
  void initState() {
    usernameController.text = localData.read(KeyStorage.userName) ?? "";
    passwordController.text = ""; //adi:gogo123
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    double formLoginWidth = mediaSize.width > 320 ? 320 : (mediaSize.width - 36);
    double formLoginHeight = 200;
    double footerHeight = 260;
    double paddingBottomHeight = 22;
    double headerHeight = (mediaSize.height - formLoginHeight - footerHeight - mediaPadding.bottom - paddingBottomHeight - mediaPadding.top) * 0.7;
    double spacerHeight = (mediaSize.height - formLoginHeight - footerHeight - mediaPadding.bottom - paddingBottomHeight - mediaPadding.top) * 0.3;
    return Scaffold(
      body: Stack(
        children: [
          ConstantConfig().background,
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Column(
                    children: [
                      headerForm(mediaSize.width, headerHeight),
                      SizedBox(
                        height: spacerHeight / 2,
                      ),
                      bodyForm(formLoginWidth, formLoginHeight),
                      SizedBox(
                        height: spacerHeight / 2,
                      ),
                      footerForm(formLoginWidth, footerHeight),
                      SizedBox(
                        height: paddingBottomHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget headerForm(double headerWidth, double headerHeight) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Column(
      children: [
        Container(
          width: mediaSize.width,
          height: mediaPadding.top,
          color: Colors.white,
        ),
        Stack(
          children: [
            SizedBox(
              height: headerHeight,
              width: headerWidth,
              child: ClipPath(
                clipper: LogoClipPath(),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 22,
                        ),
                        child: const Image(
                          image: AssetImage(
                            'assets/images/logo_full.png',
                          ),
                          height: 42,
                          //fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: (mediaSize.width / 2) - 80,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Google-Sans",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bodyForm(double formLoginWidth, double formLoginHeight) {
    return Container(
      height: formLoginHeight,
      width: formLoginWidth,
      color: Colors.grey.withOpacity(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: const Text(
              "Email",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF444444),
                fontFamily: "Google-Sans",
              ),
            ),
          ),
          SizedBox(
            height: 42,
            child: TextField(
              cursorHeight: 16,
              autofocus: false,
              textInputAction: TextInputAction.next,
              controller: usernameController,
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                hintStyle: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontFamily: "Google-Sans",
                ),
                prefixIcon: const Icon(
                  Icons.alternate_email_rounded,
                  size: 22,
                  color: Colors.grey,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: const Text(
              "Password",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF444444),
                fontFamily: "Google-Sans",
              ),
            ),
          ),
          SizedBox(
            height: 42,
            child: TextField(
              obscureText: true,
              cursorHeight: 16,
              autofocus: false,
              controller: passwordController,
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
              onSubmitted: (value) async {
                doLogin();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                hintStyle: const TextStyle(fontSize: 14.0, color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.key_outlined,
                  size: 22,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    size: 22,
                    color: Colors.grey,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: SizedBox(
                        width: 22.0,
                        height: 22.0,
                        child: Transform.scale(
                          scale: 0.6,
                          child: CupertinoSwitch(
                            value: remember,
                            onChanged: (bool value) {
                              setState(() {
                                remember = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            remember = !remember;
                          });
                        },
                        child: Text(
                          "Remember",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                            fontFamily: 'Google-Sans',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 14.0,
                  fontFamily: "Google-Sans",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget footerForm(double formLoginWidth, double footerHeight) {
    return Container(
      height: footerHeight,
      width: formLoginWidth,
      color: Colors.grey.withOpacity(0.0),
      child: Column(
        children: [
          SizedBox(
            height: 22,
            child: Center(
              child: Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: "Google-Sans",
                  color: Colors.red[600]!,
                ),
              ),
            ),
          ),
          Center(
            child: //buttonActive(formLoginWidth),
                StreamBuilder<dynamic>(
              stream: _loginBloc.antDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.status!) {
                    case Status.initial:
                      return buttonActive(formLoginWidth);
                    //break;
                    case Status.loading:
                      return buttonLoading(formLoginWidth);
                    //break;
                    case Status.completed:
                      Timer(
                        const Duration(milliseconds: 1),
                        () => {
                          Get.offAll(
                            const DashboardView(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 400),
                          ),
                        },
                      );
                      return buttonSuccess(formLoginWidth);
                    //break;
                    case Status.errror:
                      Timer(
                        const Duration(milliseconds: 1),
                        () {
                          setState(() {
                            errorMessage = snapshot.data!.message! ?? "Kesalahan tidak diketahui";
                          });
                        },
                      );

                      return buttonActive(formLoginWidth);
                  }
                }
                return Container();
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Center(
            child: Text(
              "Or login with",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: "Google-Sans",
                color: Color(0xFF444444),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BouncingButtonHelper(
                width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey),
                onTap: () async {
                  doLogin();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: const [
                      Image(
                        image: AssetImage(
                          'assets/images/icons/google.png',
                        ),
                        width: 22.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Google",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Google-Sans",
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BouncingButtonHelper(
                width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                color: const Color(0xff39529a),
                //border: const BoxBorder(),
                onTap: () async {
                  doLogin();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: const [
                      Image(
                        image: AssetImage(
                          'assets/images/icons/facebook.png',
                        ),
                        width: 22.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Google-Sans",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BouncingButtonHelper(
                width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                color: const Color(0xff222222),
                onTap: () async {

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: const [
                      Image(
                        image: AssetImage(
                          'assets/images/icons/apple.png',
                        ),
                        width: 22.0,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Apple ID",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Google-Sans",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BouncingButtonHelper(
                width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                color: Colors.green[800]!,
                //border: const BoxBorder(),
                onTap: () async {
                  localData.write(KeyStorage.userId, "0");
                  Get.offAll(
                    const DashboardView(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 400),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.person_rounded,
                        size: 26,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "As Guest",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Google-Sans",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account yet? ",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Google-Sans",
                  color: Color(0xFF444444),
                ),
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 14.0,
                  fontFamily: "Google-Sans",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buttonActive(double formLoginWidth) {
    return BouncingButtonHelper(
      width: formLoginWidth > 300.0 ? 300.0 : formLoginWidth,
      color: Colors.red[800]!,
      onTap: () async {
        doLogin();
      },
      child: const Text(
        "Sign In",
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: "Google-Sans",
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }

  Widget buttonLoading(double formLoginWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: formLoginWidth > 300.0 ? 300.0 : formLoginWidth,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.grey[200]!,
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  Widget buttonSuccess(double formLoginWidth) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: formLoginWidth > 300.0 ? 300.0 : formLoginWidth,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.grey[200]!,
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  void doLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username == "" || password == "") {
      setState(() {
        errorMessage = "Masukkan Email dan Password";
      });
    } else {
      setState(() {
        errorMessage = "";
      });
      _loginBloc.fetchResponse(username, password);
    }
  }
}

class LogoClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    path.relativeQuadraticBezierTo(size.width / 2, ((size.height * 0.25) * 2) - 36, size.width, 0);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
 */