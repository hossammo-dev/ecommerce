import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/shared/constants.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  //TODO: Customize Cart!!!

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _mainCubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              'Shopping Cart',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: (_mainCubit.cartItemsList.isEmpty)
              ? Center(
                  child: Column(
                    children: [
                      Image.network(Constants.emptyCart),
                      const SizedBox(height: 20),
                      const Text(
                        'Your cart is empty, add items now!',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _mainCubit.cartItemsList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final _product =
                                _mainCubit.cartItemsList.values.toList()[index];
                            return Dismissible(
                              key: Key(_product.id.toString()),
                              onDismissed: (direction) =>
                                  _mainCubit.removeFromCart(_product.id),
                              background: Container(
                                color: Colors.red,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading:
                                          Image.network(_product.imageUrl!),
                                      title: Text(
                                        _product.title!,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 2,
                                      ),
                                      trailing: Column(
                                        children: [
                                          Text(
                                            '\$${_product.price!}',
                                            style: const TextStyle(
                                              color: Colors.teal,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: 80,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => _mainCubit.increaseQuantity(_product),
                                                  child: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    _product.quantity.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => _mainCubit.decreaseQuantity(_product),
                                                  child: const Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(color: Colors.black54),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Total Quantity:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            _mainCubit.cartItemsList.length.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children:  [
                          const Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '\$${_mainCubit.totalPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: MaterialButton(
                          onPressed: () => _mainCubit.makeOrder(),
                          color: Colors.teal,
                          padding: const EdgeInsets.all(8),
                          minWidth: double.infinity,
                          height: 48,
                          child: const Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
