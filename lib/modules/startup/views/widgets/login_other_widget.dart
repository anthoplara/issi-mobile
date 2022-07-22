import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/modules/startup/models/login_check_model.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../blocs/login_check_bloc.dart';
import '../../blocs/login_active_bloc.dart';
import '../../blocs/login_other_bloc.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginOtherWidget extends StatefulWidget {
  final Function callback;
  const LoginOtherWidget({Key? key, required this.callback}) : super(key: key);

  @override
  State<LoginOtherWidget> createState() => _LoginOtherWidgetState();
}

class _LoginOtherWidgetState extends State<LoginOtherWidget> {
  GetStorage localData = GetStorage();
  final LoginOtherBloc _loginOtherBloc = LoginOtherBloc();
  final LoginCheckBloc _loginCheckBloc = LoginCheckBloc();
  final LoginActiveBloc _loginActiveBloc = LoginActiveBloc();
  bool loading = false;
  int loadingType = 0;

  Map<String, String> dataLogin = {};

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      callbackGoogle(account);
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  void callbackGoogle(GoogleSignInAccount? responseLogin) {
    if (responseLogin != null) {
      dataLogin = {
        'userId': "Google-${responseLogin.id}",
        'userFullName': responseLogin.displayName.toString(),
        'userEmail': responseLogin.email.toString(),
        'userPhoto': responseLogin.photoUrl.toString(),
        "loginType": "1",
      };
      /* setState(() {
        loading = true;
        loadingType = 1;
      }); */
      /* _loginOtherBloc.fetchResponse(
        "Google-${responseLogin.id}",
        responseLogin.displayName.toString(),
        responseLogin.email.toString(),
        responseLogin.photoUrl.toString(),
      ); */
    }
  }

  void callbackFacebook(Map<String, dynamic> responseLogin) {
    if (responseLogin.isNotEmpty) {
      dataLogin = {
        'userId': "Facebook-${responseLogin['id']!}",
        'userFullName': responseLogin['name']!.toString(),
        'userEmail': responseLogin['email']!.toString(),
        'userPhoto': responseLogin['picture']!['data']!['url']!.toString(),
        "loginType": "2",
      };
      /* setState(() {
        loading = true;
        loadingType = 2;
      }); */
      /* _loginOtherBloc.fetchResponse(
        "Facebook-${responseLogin['id']!}",
        responseLogin['name']!.toString(),
        responseLogin['email']!.toString(),
        responseLogin['picture']!['data']!['url']!.toString(),
      ); */
    }
  }

  void callbackApple(AuthorizationCredentialAppleID? responseLogin) {
    if (responseLogin != null) {
      dataLogin = {
        'userId': "Apple-${responseLogin.userIdentifier}",
        'userFullName': responseLogin.givenName != null ? "${responseLogin.givenName} ${responseLogin.familyName}".toString() : "",
        'userEmail': responseLogin.email != null ? responseLogin.email.toString() : "",
        'userPhoto': "",
        "loginType": "3",
      };
      /* setState(() {
        loading = true;
        loadingType = 3;
      }); */
      _loginCheckBloc.fetchResponse(dataLogin['userId']!);
      /* _loginOtherBloc.fetchResponse(
        "Apple-${responseLogin.userIdentifier}",
        responseLogin.givenName != null ? "${responseLogin.givenName} ${responseLogin.familyName}".toString() : "",
        responseLogin.email != null ? responseLogin.email.toString() : "",
        "",
      ); */
    }
  }

  void callBackLogin() {
    setState(() {
      loading = true;
      loadingType = int.parse(dataLogin['loginType'] ?? "0");
    });
    _loginOtherBloc.fetchResponse(
      dataLogin['userId']!,
      dataLogin['userFullName']!,
      dataLogin['userEmail']!,
      dataLogin['userPhoto']!,
    );
  }

  @override
  void dispose() {
    _loginOtherBloc.dispose();
    _loginCheckBloc.dispose();
    _loginActiveBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    double formLoginWidth = mediaSize.width > 320 ? 320 : (mediaSize.width - 36);
    return Column(
      children: [
        StreamBuilder<dynamic>(
          stream: _loginActiveBloc.antDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status!) {
                case Status.initial:
                  return const SizedBox.shrink();
                //break;
                case Status.loading:
                  return const SizedBox.shrink();
                //break;
                case Status.completed:
                  Timer(
                    const Duration(milliseconds: 1),
                    () {
                      callBackLogin();
                    },
                  );
                  return const SizedBox.shrink();
                //break
                case Status.errror:
                  return const SizedBox.shrink();
              }
            }
            return Container();
          },
        ),
        StreamBuilder<dynamic>(
          stream: _loginCheckBloc.antDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status!) {
                case Status.initial:
                  return const SizedBox.shrink();
                //break;
                case Status.loading:
                  return const SizedBox.shrink();
                //break;
                case Status.completed:
                  LoginCheckModel responses = snapshot.data!.data as LoginCheckModel;
                  if (responses.data?.first.statusUser == "Tidak Aktif") {
                    Timer(
                      const Duration(milliseconds: 1),
                      () {
                        setState(() {
                          loading = false;
                          loadingType = 3;
                        });
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: CupertinoActionSheet(
                              title: Text(
                                "Konfirmasi",
                                style: TextStyle(
                                  color: Colors.grey[900]!,
                                  fontSize: 16.0,
                                  fontFamily: "Google-Sans",
                                ),
                              ),
                              message: Text(
                                "Akun anda sudah dihapus, klaim ulang?",
                                style: TextStyle(
                                  color: Colors.grey[900]!,
                                  fontSize: 14.0,
                                  fontFamily: "Google-Sans",
                                ),
                              ),
                              actions: <CupertinoActionSheetAction>[
                                CupertinoActionSheetAction(
                                  isDefaultAction: true,
                                  child: const Text(
                                    "Ya, Klaim!",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontFamily: "Google-Sans",
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      loading = false;
                                      loadingType = int.parse(dataLogin['loginType'] ?? "0");
                                    });
                                    Navigator.of(context).pop(false);
                                    _loginActiveBloc.fetchResponse(dataLogin['userId']!);
                                  },
                                )
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                child: const Text(
                                  "Tidak",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "Google-Sans",
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(false),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    Timer(
                      const Duration(milliseconds: 1),
                      () {
                        callBackLogin();
                      },
                    );
                  }
                  _loginCheckBloc.setInitial();
                  return const SizedBox.shrink();
                //break
                case Status.errror:
                  return const SizedBox.shrink();
              }
            }
            return Container();
          },
        ),
        StreamBuilder<dynamic>(
          stream: _loginOtherBloc.antDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status!) {
                case Status.initial:
                  return const SizedBox.shrink();
                //break;
                case Status.loading:
                  return const SizedBox.shrink();
                //break;
                case Status.completed:
                  Timer(
                    const Duration(milliseconds: 1),
                    () {
                      widget.callback();
                    },
                  );
                  return const SizedBox.shrink();
                //break
                case Status.errror:
                  return const SizedBox.shrink();
              }
            }
            return Container();
          },
        ),
        const Center(
          child: Text(
            "Sign Up or Sign In with",
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
            loading && loadingType == 1
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  )
                : BouncingButtonHelper(
                    width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                    color: Colors.white,
                    border: Border.all(width: 1.0, color: Colors.grey),
                    onTap: () async {
                      try {
                        await _googleSignIn.signIn();
                      } catch (error) {}
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
            loading && loadingType == 2
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.grey[200]!,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  )
                : BouncingButtonHelper(
                    //enable: false,
                    width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                    color: const Color(0xff39529a),
                    //border: const BoxBorder(),
                    onTap: () async {
                      try {
                        final LoginResult result = await FacebookAuth.instance.login(
                          permissions: ['public_profile', 'email'],
                        );
                        final userData = await FacebookAuth.instance.getUserData();
                        callbackFacebook(userData);
                      } catch (e) {}
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
        Platform.isIOS
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: loading && loadingType == 3
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[200]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          //width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                          width: (formLoginWidth > 300.0 ? 300.0 : formLoginWidth),
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.grey[200]!,
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      )
                    : BouncingButtonHelper(
                        //width: ((formLoginWidth > 300.0 ? 300.0 : formLoginWidth) - 22) / 2,
                        width: (formLoginWidth > 300.0 ? 300.0 : formLoginWidth),
                        color: const Color(0xff222222),
                        onTap: () async {
                          try {
                            final credential = await SignInWithApple.getAppleIDCredential(
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                            );
                            callbackApple(credential);
                          } catch (e) {}
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage(
                                  'assets/images/icons/apple.png',
                                ),
                                width: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Sign in with Apple",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: "Google-Sans",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                /* SignInWithAppleButton(
                        onPressed: () async {
                          final credential = await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                          );

                          // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                          // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                        },
                      ), */
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
