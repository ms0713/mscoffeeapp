// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mscoffeeapp/helpers/constants.dart';
import 'package:mscoffeeapp/models/auth0_id_token.dart';

import '../models/auth0_user.dart';

typedef AsyncCallbackString = Future<String> Function();

class _LoginInfo extends ChangeNotifier {
  var _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }
}

/// -----------------------------------
///   Auth0 environment variables
/// -----------------------------------

class AuthService {

  /// -----------------------------------
  ///  Auth Service Singleton
  /// -----------------------------------
  static final AuthService instance = AuthService._internal();
  factory AuthService() {
    return instance;
  }
  AuthService._internal();

  String? accessToken;
  Auth0IdToken? idToken;
  Auth0User? user;

  final _loginInfo = _LoginInfo();
  get loginInfo => _loginInfo;

  Future<String> errorHandler(AsyncCallbackString callback) async {
    try {
      return await callback();
    } on TimeoutException catch (e) {
      return e.message ?? 'Timeout Error!';
    } on SocketException catch (e) {
      return e.message;
    } on FormatException catch (e) {
      return e.message;
    } on PlatformException catch (e) {
      return e.message ?? 'Something is Wrong! Code: ${e.code}';
    } on UserInfoException catch (e) {
      return e.message;
    } catch (e) {
      return 'Unknown error ${e.runtimeType}';
    }
  }

  /// -----------------------------------
  ///  1- instantiate appAuth
  /// -----------------------------------
  final appAuth = const FlutterAppAuth();

  /// -----------------------------------
  ///  2- instantiate secure storage
  /// -----------------------------------
  final secureStorage = const FlutterSecureStorage();

  /// -----------------------------------
  ///  3- init
  /// -----------------------------------
  Future<String> init() async {
    return errorHandler(
      () async {
        final securedRefreshToken =
            await secureStorage.read(key: REFRESH_TOKEN_KEY);

        if (securedRefreshToken == null) {
          return 'You need to login!';
        }

        final response = await appAuth.token(
          TokenRequest(
            AUTH0_CLIENT_ID,
            AUTH0_REDIRECT_URI,
            issuer: AUHT0_ISSUER,
            refreshToken: securedRefreshToken,
          ),
        );

        return await _setLocalVariables(response);
      },
    );
  }

  /// -----------------------------------
  ///  4- login
  /// -----------------------------------
  Future<String> login() async {
    return errorHandler(() async {
      final authirizationTokenRequest = AuthorizationTokenRequest(
        AUTH0_CLIENT_ID,
        AUTH0_REDIRECT_URI,
        issuer: AUHT0_ISSUER,
        scopes: [
          'openid',
          'profile',
          'email',
          'offline-access',
        ],
        promptValues: ['login'],
      );

      final result =
          await appAuth.authorizeAndExchangeCode(authirizationTokenRequest);

      return _setLocalVariables(result);
    });
  }

  /// -----------------------------------
  ///  5- setProfileAndIdToken
  /// -----------------------------------
  bool isAuthResultValid(TokenResponse? response) {
    return response?.accessToken != null && response?.idToken != null;
  }

  Future<String> _setLocalVariables(TokenResponse? response) async {
    if (isAuthResultValid(response)) {
      accessToken = response!.accessToken!;
      idToken = parseIdToken(response.idToken!);
      user = await getUserDetails(response.accessToken!);
      
      //print(response.accessToken);
      //parseAccessToken(response.accessToken!);

      if (response.refreshToken != null) {
        await secureStorage.write(
            key: REFRESH_TOKEN_KEY, value: response.refreshToken);
      }

      _loginInfo._isLoggedIn = true;
      return 'Success';
    }

    return 'Something went wrong!';
  }

  /// -----------------------------------
  ///  6- logout
  /// -----------------------------------
  logout() async {
    await secureStorage.delete(key: REFRESH_TOKEN_KEY);

    // final request = EndSessionRequest(
    //   idTokenHint: jsonEncode(idToken!.toJson()),
    //   issuer: AUHT0_ISSUER,
    //   postLogoutRedirectUrl: '$BUNDLE_IDENTIFIER:/',
    // );

    // print(request.issuer);
    // print(request.idTokenHint);
    // print(request.postLogoutRedirectUrl);
    // await appAuth.endSession(request);


    // final url = Uri.https(
    //   AUTH0_DOMAIN,
    //   '/v2/logout',
    //   {
    //     'client_id':AUTH0_CLIENT_ID,
    //     'federated':'',
    //     //'returnTo':'YOUR_RETURN_LOGOUT_URL',
    //   },
    // );

    // final response = await http.get(
    //   url,
    //   headers:{'Authorization':'Bearer $accessToken'},
    // );

    //_loginInfo.isLoggedIn = false;
    
  }

  /// -----------------------------------
  ///  7- parseIdToken
  /// -----------------------------------
  Auth0IdToken parseIdToken(String idToken) {
    final parts = idToken.split(r'.');

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    print(idToken);
    return Auth0IdToken.fromJson(json);
  }

  parseAccessToken(String accessToken) {
    print(accessToken);
    final parts = accessToken.split(r'.');

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    print(json);
    //return Auth0IdToken.fromJson(json);
  }

  /// -----------------------------------
  ///  8- getUserDetails
  /// -----------------------------------
  Future getUserDetails(String accessToken) async {
    final url = Uri.https(AUTH0_DOMAIN, '/userinfo');

    final response = await http.get(
      url,
      headers:{'Authorization':'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return Auth0User.fromJson(jsonDecode(response.body));  
    }else{
      throw const UserInfoException('Failed to get user details');
    }
    
    
  }

  /// -----------------------------------
  ///  9- availableCustomerService
  /// -----------------------------------

}

class UserInfoException implements Exception{
  const UserInfoException(this.message);
  final String message;
}
