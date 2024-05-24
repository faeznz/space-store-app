import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/model/alamat_model.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/screen/checkout/checkout_screen.dart';
import 'package:mini_project/screen/alamat/tambah_alamat_screen.dart';
import 'package:mini_project/format/format_currency.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:mini_project/service/api_service.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<KaosModel> kaosList = [];
  List<AlamatModel> alamatList = [];
  String? messageError;

  String totalStr = '';

  bool isLoading = false;

  void fetchAllKaos() async {
    setState(() {
      isLoading = true;
    });

    try {
      kaosList = await ApiService().getAllKaos();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      messageError = e.toString();
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchAlamatData() async {
    setState(() {
      isLoading = true;
    });

    try {
      alamatList = await ApiService().getAlamatList();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      messageError = e.toString();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllKaos();
    fetchAlamatData();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    var selectedKaos = cartProvider.selectedKaos;
    var listHarga = cartProvider.listHarga;
    var totalStr = cartProvider.totalStr;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.shopping_cart),
        title: Text(
          'Your Cart',
          style: TextStyleConstant.ibmPlexSans.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstant.blueAccent,
              ),
            )
          : SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/bg-pattern.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          cartList.isEmpty
                              ? const Center(child: Text('Cart Kamu Kosong'))
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: cartList.length,
                                    itemBuilder: (context, index) {
                                      for (int i = 0;
                                          i < kaosList.length;
                                          i++) {
                                        if (kaosList[i].id == cartList[index]) {
                                          selectedKaos = kaosList[i];
                                          break;
                                        }
                                      }
                                      return ListTile(
                                        leading: selectedKaos != null
                                            ? AspectRatio(
                                                aspectRatio: 1 / 1,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    selectedKaos?.image ?? '',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                        title: Text(selectedKaos?.nama ?? ''),
                                        subtitle: Text(
                                          formatCurrency(
                                              selectedKaos?.harga ?? '0'),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            setState(
                                              () {
                                                cartList
                                                    .remove(selectedKaos?.id);
                                                listHarga.remove(
                                                    selectedKaos?.harga);
                                                cartProvider.updateCart(
                                                    cartList, listHarga);
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Harga',
                                    style: TextStyleConstant.ibmPlexSans,
                                  ),
                                  Text(totalStr.toString()),
                                ],
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorConstant.blueAccent),
                                ),
                                onPressed: () {
                                  if (alamatList.isEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TambahAlamatScreen(),
                                      ),
                                    );
                                  } else {
                                    if (cartList.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Cart Kosong'),
                                          content: const Text(
                                              'Tambahkan produk terlebih dahulu'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutScreen(
                                            alamatReq: alamatList[0],
                                            cartList: cartList,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Text(
                                  'Checkout',
                                  style: TextStyleConstant.ibmPlexSans,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
