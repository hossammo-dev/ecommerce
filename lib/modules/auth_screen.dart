import 'package:ecommerce/layouts/home_layout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/shared/cubit/auth_cubit/auth_states.dart';

import '../shared/constants.dart';
import '../shared/widgets/components.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final _authCubit = AuthCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.asset(Constants.appLogo),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (!_authCubit.isLogin) ...[
                            defaultTextField(
                              controller: _nameController,
                              hint: 'jhon wick',
                              label: 'Username',
                            ),
                            defaultTextField(
                              controller: _phoneController,
                              type: const TextInputType.numberWithOptions(),
                              hint: '01021411525',
                              label: 'Phone Number',
                            ),
                          ],
                          defaultTextField(
                            controller: _emailController,
                            type: TextInputType.emailAddress,
                            hint: 'email@gmail.com',
                            label: 'Email',
                          ),
                          const SizedBox(height: 10),
                          defaultTextField(
                            controller: _passController,
                            type: TextInputType.visiblePassword,
                            isPassword: true,
                            showPassword: !_authCubit.showPassword,
                            changePassVisibility: () =>
                                _authCubit.changePasswordVisibility(),
                            hint: '*******',
                            label: 'Password',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    defaultButton(
                      title: (_authCubit.isLogin) ? 'Login' : 'Register',
                      btnFun: () {
                        if (_formKey.currentState!.validate()) {
                          if (_authCubit.isLogin) {
                            _authCubit
                                .logUserIn(
                                    email: _emailController.text,
                                    password: _passController.text)
                                .then((_) => navigateReplace(context,
                                    page: const HomeLayout()));
                          } else {
                            _authCubit
                                .createUser(
                                    username: _nameController.text,
                                    phoneNumber: _phoneController.text,
                                    email: _emailController.text,
                                    password: _passController.text)
                                .then((_) => navigateReplace(context,
                                    page: const HomeLayout()));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _authCubit.changePageState(),
                      child: Text(
                        (_authCubit.isLogin)
                            ? 'Don\'t have an account? Register'
                            : 'Already have an account? login',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
