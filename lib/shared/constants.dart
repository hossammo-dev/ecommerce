import 'package:flutter/material.dart';

import '../modules/cart_screen.dart';
import '../modules/products_screen.dart';
import '../modules/profile_screen.dart';
import '../modules/settings_screen.dart';

class Constants {
  static List<Widget> pagesList = [
    const ProductsScreen(),
    const CartScreen(),
    ProfileScreen(),
    const SettingsScreen(),
  ];

  static List<String> categories = [
    'electronics',
    'jewelery',
    'men\'s clothing',
    'women\'s clothing',
  ];

  static const String appLogo = 'assets/images/logo.jpg';

  static const String emptyCart =
      'https://img.freepik.com/free-vector/shopping-cart-realistic_1284-6011.jpg?t=st=1658241135~exp=1658241735~hmac=8453ebc0f17f2107f5f80c82cdd46f2e2bd1036b923abe6158e367a3d0e8e60c&w=740';

  static String userId = '';
}
