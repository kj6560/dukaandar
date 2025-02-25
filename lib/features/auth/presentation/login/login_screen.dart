part of login_library;

class LoginScreenUI extends WidgetView<LoginScreenUI, LoginScreenState> {
  const LoginScreenUI(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            controllerState.handleApiResponse(state);
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: AuthBackground(
                welcomeMessage: 'Welcome',
                subtitleMessage: 'Please login to continue',
                child: Form(
                  key: controllerState.loginFormKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: AppTextStyles.inter14w400,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomInputField(
                          controller: controllerState.emailPhoneController,
                          hintText: 'Email or Mobile Number',
                          labelText: 'Email or Mobile Number',
                          validator: (value) {
                            final trimmedValue = value?.trim() ?? '';
                            if (trimmedValue.isEmpty) {
                              return 'Email or Mobile Number is required';
                            } else if (!MyValidator.isValidEmail(
                                    trimmedValue) &&
                                !MyValidator.isValidPhoneNumber(trimmedValue)) {
                              return 'Invalid email or mobile number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomInputField(
                          controller: controllerState.passwordController,
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          obscureText: false,
                          validator: (value) {
                            final trimmedValue = value?.trim() ?? '';
                            if (trimmedValue.isEmpty) {
                              return 'Password is required';
                            } else if (!MyValidator.isValidPassword(
                                trimmedValue)) {
                              return 'Incorrect Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, AppRoutes.forgotPassword);
                            },
                            child: Text(
                              'Forgot Password',
                              style: AppTextStyles.inter14w600DarkGreen,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OnboardingButton(
                            text: 'Login',
                            onPressed: controllerState.onLoginPressed
                            // onPressed: loginInitial.isButtonEnabled
                            //     ? controllerState.onLoginPressed
                            //     : () {},
                            ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(82, 82, 82, 1)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, AppRoutes.register);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color.fromRGBO(19, 146, 127, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Inter'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
