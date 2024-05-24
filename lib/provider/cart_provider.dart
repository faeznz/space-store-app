import 'package:flutter/material.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/format/format_currency.dart';

class CartProvider extends ChangeNotifier {
  List<dynamic> cartList = [];
  List<dynamic> cartList2 = [];
  List<dynamic> listHarga = [];
  List<dynamic> listHarga2 = [];
  KaosModel? selectedKaos;

  int totalHarga = 0;
  int totalHarga2 = 0;
  int hargaTotal2 = 0;
  int hargaTotal = 0;
  String totalStr = '';
  String totalStr2 = '';

  void updateCart(List<dynamic> newCartList, List<dynamic> newListHarga) {
    cartList = newCartList;
    listHarga = newListHarga;
    totalHarga = 0;
    for (var i = 0; i < listHarga.length; i++) {
      totalHarga += int.parse(listHarga[i]);
    }
    totalStr = formatCurrency(totalHarga.toString());
    notifyListeners();
  }

  void updateCartLangsung(
      List<dynamic> newCartList2, List<dynamic> newListHarga2) {
    cartList2 = newCartList2;
    listHarga2 = newListHarga2;
    totalHarga2 = 0;
    for (var i = 0; i < listHarga2.length; i++) {
      totalHarga2 += int.parse(listHarga2[i]);
    }
    totalStr2 = formatCurrency(totalHarga2.toString());
    notifyListeners();
  }

  void removeCart(String? id) {
    cartList.remove(id);
    notifyListeners();
  }
}
