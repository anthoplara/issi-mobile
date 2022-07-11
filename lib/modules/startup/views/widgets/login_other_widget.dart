import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../blocs/login_other_bloc.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
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
  bool loading = false;
  int loadingType = 0;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      callbackGoogle(account);
    });
    super.initState();
  }

  void callbackGoogle(GoogleSignInAccount? responseLogin) {
    if (responseLogin != null) {
      /* Map<String, String> dataLogin = {
        'userId': responseLogin.id.toString(),
        'userFullName': responseLogin.displayName.toString(),
        'userEmail': responseLogin.email.toString(),
        'userPhoto': responseLogin.photoUrl.toString(),
      }; */
      setState(() {
        loading = true;
        loadingType = 1;
      });
      _loginOtherBloc.fetchResponse(
        "Google-${responseLogin.id}",
        responseLogin.displayName.toString(),
        responseLogin.email.toString(),
        responseLogin.photoUrl.toString(),
      );
    }
  }

  void callbackFacebook(Map<String, dynamic> responseLogin) {
    if (responseLogin.isNotEmpty) {
      /* Map<String, String> dataLogin = {
        'userId': responseLogin['id']!.toString(),
        'userFullName': responseLogin['name']!.toString(),
        'userEmail': responseLogin['email']!.toString(),
        'userPhoto': responseLogin['picture']!['data']!['url']!.toString(),
      }; */
      setState(() {
        loading = true;
        loadingType = 2;
      });
      _loginOtherBloc.fetchResponse(
        "Facebook-${responseLogin['id']!}",
        responseLogin['name']!.toString(),
        responseLogin['email']!.toString(),
        responseLogin['picture']!['data']!['url']!.toString(),
      );
    }
  }

  void callbackApple(AuthorizationCredentialAppleID? responseLogin) {
    if (responseLogin != null) {
      /* Map<String, String> dataLogin = {
        'userId': responseLogin.userIdentifier.toString(),
        'userFullName': responseLogin.givenName != null ? "${responseLogin.givenName} ${responseLogin.familyName}".toString() : "",
        'userEmail': responseLogin.email != null ? responseLogin.email.toString() : "",
        'userPhoto': "",
      }; */
      setState(() {
        loading = true;
        loadingType = 3;
      });
      _loginOtherBloc.fetchResponse(
        "Apple-${responseLogin.userIdentifier}",
        responseLogin.givenName != null ? "${responseLogin.givenName} ${responseLogin.familyName}".toString() : "",
        responseLogin.email != null ? responseLogin.email.toString() : "",
        "",
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    double formLoginWidth = mediaSize.width > 320 ? 320 : (mediaSize.width - 36);
    return Column(
      children: [
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
            "Sign Up or Log In with",
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
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
