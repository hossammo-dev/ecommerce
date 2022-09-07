import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_cubit.dart';
import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, this.productModel}) : super(key: key);

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final _mainCubit = MainCubit.get(context);  
        debugPrint('is Favorited? - ${productModel!.isFavorited}');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30,
                )),
            actions: [
              IconButton(
                onPressed: () => _mainCubit.addProductToFavs(productModel!),
                icon: (productModel!.isFavorited!)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                iconSize: 35,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    productModel!.imageUrl!,
                    height: 300,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    productModel!.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${productModel!.price}',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.teal,
                            height: 3,
                          ),
                        ),
                        const Text(
                          ' Description ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.teal,
                            height: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    productModel!.description!,
                    style: const TextStyle(
                      fontSize: 18,
                      wordSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _mainCubit.addToCart(productModel!),
            backgroundColor: Colors.teal,
            child: const Icon(
              Icons.shopping_cart_checkout,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
