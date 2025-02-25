import 'package:flutter/material.dart';

import '../config/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading ? CircularProgressIndicator() : Text(text),
    );
  }
}

Widget OnboardingButton({
  required String text,
  bool isButtonDisabled = false,
  bool isButtonFaded = false,
  required Function() onPressed,
}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: isButtonFaded == true
          ? AppConstants.disabledColor
          : Color.fromRGBO(19, 146, 127, 1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: TextButton(
      onPressed: () {
        if (isButtonDisabled == true || isButtonFaded == true) return;
        onPressed();
      },
      child: isButtonDisabled == true
          ? Text(
        '${text}...',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'inter',
            fontSize: 18,
            fontWeight: FontWeight.w600),
      )
          : Text(
        text,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'inter',
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}