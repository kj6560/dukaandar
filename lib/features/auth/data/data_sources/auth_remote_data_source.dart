import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import '../../../../core/network/endpoints.dart';
import '../../../../core/network/firebase_token.dart';
import '../../../../core/utils/validators.dart';

class AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource({required this.client});

  Future<Map<String, dynamic>?> login(
      String emailOrPhone, String password) async {
    String? fcmToken = await getFirebaseToken();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    bool isEmail = MyValidator.isValidEmail(emailOrPhone);

    var body = {
      'password': password,
      'fcm_token': fcmToken,
      'app_version': packageInfo.version,
      'login_type': 1,
      "platform": Platform.isAndroid ? 1 : 2,
    };

    if (isEmail) {
      body['email'] = emailOrPhone;
    } else {
      body['number'] = emailOrPhone;
    }

    final response = await client.post(
      Uri.parse(EndPoints.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  Future<Map<String, dynamic>?> loginWithUserId(
      String emailOrPhone, String password, int userId) async {
    String? fcmToken = await getFirebaseToken();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // Determine if the input is an email or a phone number
    bool isEmail = MyValidator.isValidEmail(emailOrPhone);

    var mBody = {
      'password': password,
      'fcm_token': fcmToken,
      'app_version': packageInfo.version,
      'user_id': userId,
      'login_type': 1,
      "platform": Platform.isAndroid ? 1 : 2,
    };

    // Add the correct key based on the input type
    if (isEmail) {
      mBody['email'] = emailOrPhone;
    } else {
      mBody['number'] = emailOrPhone;
    }

    final response = await http.post(
      Uri.parse(EndPoints.login),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mBody),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseObject = json.decode(response.body);
      return responseObject;
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      return {
        'error': true,
        'message': errorResponse['message'] ?? 'Failed to login'
      };
    }
  }

  Map<String, dynamic>? _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {'error': true, 'message': 'Something went wrong'};
    }
  }
}
