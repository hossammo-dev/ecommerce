import 'package:ecommerce/shared/cubit/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/shared/cubit/auth_cubit/auth_states.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/components.dart';
import 'auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  final List<String> _titles = const ['LightTheme', 'Language', 'LogOut'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final _authCubit = AuthCubit.get(context);
          final _mainCubit = MainCubit.get(context);
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: List.generate(
                _titles.length,
                (index) => ListTile(
                  title: Text(_titles[index]),
                  trailing: tileTrailing(
                    context,
                    index,
                    cubit: _mainCubit,
                    authCubit: _authCubit,
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }

  Widget? tileTrailing(BuildContext context, int index,
      {MainCubit? cubit, AuthCubit? authCubit}) {
    switch (index) {
      case 0:
        return Switch(
            value: cubit!.lightTheme, onChanged: (_) => cubit.changeTheme());
      case 1:
        return const Text(
          'English',
          style: TextStyle(color: Colors.grey),
        );
      case 2:
        return IconButton(
            onPressed: () => authCubit!
                .logUserOut()
                .then((value) => navigateReplace(context, page: AuthScreen())),
            icon: const Icon(
              Icons.logout,
              color: Colors.teal,
            ));
      default:
        return null;
    }
  }
}
