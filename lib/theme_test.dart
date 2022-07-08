import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/themes/service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

import 'modules/startup/views/splash_screen_view.dart';

//Google
GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '342516576144-7ae2hmoj3t49phteovbon4jcrtah4eql.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class TestThemeView extends StatefulWidget {
  const TestThemeView({Key? key}) : super(key: key);

  @override
  State<TestThemeView> createState() => _TestThemeViewState();
}

class _TestThemeViewState extends State<TestThemeView> {
  ThemeService themeService = ThemeService();
  bool isSystem = true;
  GetStorage localData = GetStorage();
  final _keySystem = 'isSystemMode';

  //Google
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    isSystem = localData.read(_keySystem) ?? false;
    super.initState();

    //Google
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  //Google
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  //Google
  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  //Google
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  //Google
  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Get.isDarkMode ? 'Dark' : 'Light',
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: _handleSignIn,
              child: const Text('Login Google'),
            ),
            SizedBox(
              width: 280,
              height: 32,
              child: SignInWithAppleButton(
                onPressed: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );

                  print(credential);
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BouncingButtonHelper(
                  //enable: false,
                  width: 88,
                  height: 36,
                  color: Colors.red,
                  bouncDeep: 0.9,
                  onTap: () {
                    setState(() {
                      isSystem = !isSystem;
                    });
                    themeService.switchTheme('system');
                  },
                  child: Icon(isSystem ? Icons.check_box_outlined : Icons.check_box_outline_blank),
                ),
                isSystem
                    ? const SizedBox()
                    : BouncingButtonHelper(
                        //enable: false,
                        width: 88,
                        height: 36,
                        color: Colors.red,
                        bouncDeep: 0.9,
                        onTap: () {
                          themeService.switchTheme(Get.isDarkMode ? 'light' : 'dark');
                        },
                        child: Icon(Get.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
