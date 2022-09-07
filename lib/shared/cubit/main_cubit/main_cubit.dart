import 'package:flutter/material.dart';

import 'package:ecommerce/shared/widgets/components.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/shared/constants.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:ecommerce/shared/network/remote/firebase_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/shared/cubit/main_cubit/main_states.dart';
import 'package:uuid/uuid.dart';

import '../../../models/cart_item.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(MainInitState());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<ProductModel> _products = [];
  List<ProductModel> get prodcuts => _products;

  final Map<String, CartItem> _cartItemsList = {};
  Map<String, CartItem> get cartItemsList => _cartItemsList;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _lightTheme = true;
  bool get lightTheme => _lightTheme;

  //cart total price
  double get totalPrice {
    double _total = 0;
    _cartItemsList.forEach((_, item) {
      _total += item.price! * item.quantity!;
    });
    return _total;
  }

  //get user data
  Future<void> getUserData() async {
    emit(MainLoadingState());
    FirebaseHelper().get(collection: 'users', docId: Constants.userId).then(
      (user) {
        _userModel = UserModel.fromJson(user.data()!);
        debugPrint('--${_userModel!.email}');
        emit(MainGetUserDataSuccessState());
      },
    ).catchError((error) {
      debugPrint(error.toString());
      emit(MainGetUserDataErrorState());
    });
  }

  //get products
  Future<void> getProducts() async {
    emit(MainLoadingState());
    DioHelper().get(path: 'products').then((prods) {
      prods.data.forEach((prod) => _products.add(ProductModel.fromJson(prod)));
      debugPrint(_products[0].title);
      debugPrint(_products.length.toString());
      emit(MainGetProductsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(MainGetProductsErrorState());
    });
  }

  //add item to cart
  void addToCart(ProductModel productModel) {
    emit(MainLoadingState());
    CartItem _item = CartItem(
        id: productModel.id,
        title: productModel.title,
        imageUrl: productModel.imageUrl,
        price: productModel.price,
        quantity: 1);
    _cartItemsList.putIfAbsent(productModel.id.toString(), () => _item);
    defaultToast(
        message: 'Item added to cart successfully!',
        bgColor: Colors.teal,
        txColor: Colors.white);
    emit(MainAddToCartSuccessState());
  }

  //remove from cart
  void removeFromCart(int? productId) {
    emit(MainLoadingState());
    _cartItemsList.remove(productId.toString());
    defaultToast(
        message: 'Item removed from cart successfully!',
        bgColor: Colors.red,
        txColor: Colors.white);
    emit(MainRemoveFromCartSuccessState());
  }

  //increase item qunatity
  void increaseQuantity(CartItem item) {
    debugPrint('Increased!');
    item.quantity = item.quantity! + 1;
    emit(MainIncreaseQuantityState());
  }

  //decrease item qunatity
  void decreaseQuantity(CartItem item) {
    if (item.quantity! > 1) {
      item.quantity = item.quantity! - 1;
    }
    emit(MainDecreaseQuantityState());
  }

  //make an order
  void makeOrder() {
    emit(MainLoadingState());
    final String _orderId = const Uuid().v4();
    List<CartItem> _tempList = _cartItemsList.values.toList();
    FirebaseHelper().save(
      collection: 'orders',
      docId: _orderId,
      data: {
        'id': _orderId,
        'user': {
          'username': _userModel!.username,
          'email': _userModel!.email,
          'phone-number': _userModel!.phoneNumber,
        },
        'total-price': totalPrice,
        'quantity': _cartItemsList.length,
        'cart-items': _tempList.map((item) => item.toJson()).toList(),
      },
    ).then((_) {
      defaultToast(
          message: 'Order created successfully!',
          bgColor: Colors.teal,
          txColor: Colors.white);
      _cartItemsList.clear();
      emit(MainMakeOrderSuccessState());
    }).catchError((error) {
      defaultToast(
          message: error.toString(),
          bgColor: Colors.red,
          txColor: Colors.black);
      emit(MainMakeOrderErrorState());
    });
  }

  //change current index
  void changeIndex(int index) {
    _currentIndex = index;
    emit(MainChangeIndexState());
  }

  void addProductToFavs(ProductModel product) {
    product.isFavorited = !product.isFavorited!;
    emit(MainFavProductState());
  }

  //change theme
  void changeTheme() {
    _lightTheme = !_lightTheme;
    emit(MainChangeThemeState());
  }
}
