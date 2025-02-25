import 'package:flutter/material.dart';

import '../config/text_styles.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final String welcomeMessage;
  final String subtitleMessage;

  const AuthBackground(
      {required this.child,
      required this.welcomeMessage,
      required this.subtitleMessage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.8),
              Color.fromRGBO(255, 87, 51, 0)
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   child: Image.asset(
                //     'assets/launcher_icon.png',
                //     height: 300,
                //   ),
                // ),
                Text(
                  welcomeMessage,
                  style: AppTextStyles.inter24w600,
                ),
                Text(
                  subtitleMessage,
                  style: AppTextStyles.inter16w400,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: child,
          )
        ],
      ),
    );
  }
}
