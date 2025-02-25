import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text_input.dart';

import '../../../../core/widgets/custom_button.dart';
import 'bloc/register_bloc.dart';
import 'bloc/register_event.dart';
import 'bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(authRepository: context.read()),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
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
                  controller: _usernameController,
                  labelText: 'Username',
                ),
                CustomInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),
                CustomInputField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 16),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return CircularProgressIndicator();
                    }
                    return CustomButton(
                      text: 'Register',
                      onPressed: () {
                        context.read<RegisterBloc>().add(
                          RegisterSubmitted(
                            username: _usernameController.text,
                            password: _passwordController.text,
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