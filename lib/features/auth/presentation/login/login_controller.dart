library login_library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/config/text_styles.dart';
import '../../../../core/config/theme.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../../core/network/firebase_token.dart';
import '../../../../core/routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widget_view_base.dart';
import '../../../../core/widgets/app_auth_background.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../data/models/user_model.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

part 'login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  int platform = 0;
  String version = "";

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    platform = Platform.isAndroid ? 1 : 2;
  }

  @override
  void dispose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LoginScreenUI(this);

  void onLoginPressed() {
    if (loginFormKey.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        emailPhone: emailPhoneController.text,
        password: passwordController.text,
      ));
    }
  }

  void loginWithSelectedAccount(int selectedUser) async {
    String? fcmToken = await getFirebaseToken();
    BlocProvider.of<LoginBloc>(context).add(LoginWithUserId(
      emailPhone: emailPhoneController.text,
      password: passwordController.text,
      fcmToken: fcmToken!,
      userId: selectedUser,
    ));
  }

  void handleApiResponse(Object? apiState) async {
    if (apiState is LoginLoading) {
      CircularProgressIndicator; // Implement a loading indicator
    } else if (apiState is LoginSuccess) {
      await authBox.put(HiveKeys.userBox, jsonEncode(apiState.user.toJson()));
      await authBox.put(HiveKeys.accessToken, apiState.token);
      Navigator.popAndPushNamed(context, AppRoutes.home,
          arguments: apiState.user);
    } else if (apiState is LoginFailure) {
      print('Error!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1');
    }
  }

  void showAccountSelectionBottomSheet(List<User> userList) {
    int? selectedUserId;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...userList.map((user) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        user.name?.isNotEmpty == true ? user.name : '?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text("${user.name} ${user.name}"),
                    subtitle: Text(user.email?.isNotEmpty == true
                        ? user.email
                        : user.number),
                    trailing: Radio<int>(
                      value: user.id,
                      groupValue: selectedUserId,
                      onChanged: (int? value) {
                        setState(() {
                          selectedUserId = value!;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        selectedUserId = user.id;
                      });
                    },
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: selectedUserId == null
                      ? null
                      : () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          loginWithSelectedAccount(selectedUserId!);
                        },
                  child: Text("Select Account"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
