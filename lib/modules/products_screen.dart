import 'package:ecommerce/shared/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';

import '../shared/widgets/components.dart';
import 'details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _mainCubit = MainCubit.get(context);
        return Scaffold(
          body: (_mainCubit.prodcuts.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(
                              Constants.categories.length,
                              (index) => Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: Colors.white,
                                elevation: 5.6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      Constants.categories[index],
                                      style: const TextStyle(
                                        color: Colors.teal,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(),
                        const SizedBox(height: 5),
                        Expanded(
                          child: GridView.builder(
                            itemCount: _mainCubit.prodcuts.length,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.6,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => navigateTo(context,
                                  page: DetailsScreen(
                                    productModel: _mainCubit.prodcuts[index],
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Image.network(
                                        // Constants.dummyImage,
                                        _mainCubit.prodcuts[index].imageUrl!,
                                        height: 200,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _mainCubit.prodcuts[index].title!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '\$${_mainCubit.prodcuts[index].price}',
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}