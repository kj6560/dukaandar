import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text_input.dart';
import '../../../../core/widgets/custom_button.dart';
import 'bloc/forgot_pass_bloc.dart';
import 'bloc/forgot_pass_event.dart';
import 'bloc/forgot_pass_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: BlocProvider(
        create: (context) => ForgotPasswordBloc(authRepository: context.read()),
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomInputField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 16),
                BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                  builder: (context, state) {
                    if (state is ForgotPasswordLoading) {
                      return CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: 'Submit',
                      onPressed: () {
                        context.read<ForgotPasswordBloc>().add(
                          ForgotPasswordSubmitted(
                            email: _emailController.text,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}