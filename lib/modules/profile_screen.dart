import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';
import 'package:ecommerce/shared/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _userCubit = MainCubit.get(context).userModel;
        _nameController.text = _userCubit!.username!;
        _emailController.text = _userCubit.email!;
        _phoneController.text = _userCubit.phoneNumber!;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-smiling-young-man-eyewear_171337-4842.jpg?t=st=1657709112~exp=1657709712~hmac=e08e142cbba4b47cee0bdede2f0e1817c014acdd7169544a107c1e1d8fd56c29&w=1060'),
                      radius: 80,
                    ),
                    const SizedBox(height: 20),
                    defaultTextField(
                        controller: _nameController,
                        hint: 'Jhon Wick',
                        label: 'Username'),
                    const SizedBox(height: 10),
                    defaultTextField(
                      controller: _emailController,
                      hint: 'email@gmail.com',
                      label: 'Email',
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    defaultTextField(
                      controller: _phoneController,
                      hint: '01014124124',
                      label: 'Phone Number',
                      type: const TextInputType.numberWithOptions(),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.teal,
                      padding: const EdgeInsets.all(8),
                      minWidth: double.infinity,
                      height: 48,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
