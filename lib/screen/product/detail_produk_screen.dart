import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/env/env.dart';
import 'package:mini_project/model/alamat_model.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/screen/alamat/tambah_alamat_screen.dart';
import 'package:mini_project/screen/checkout/beli_langsung_screen.dart';
import 'package:mini_project/format/format_currency.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:mini_project/service/api_service.dart';
import 'package:provider/provider.dart';

class DetailProdukScreen extends StatefulWidget {
  final String? kaosId;
  const DetailProdukScreen({super.key, required this.kaosId});

  @override
  State<DetailProdukScreen> createState() => _DetailProdukScreenState();
}

class _DetailProdukScreenState extends State<DetailProdukScreen> {
  List<KaosModel> kaosList = [];
  List<AlamatModel> alamatList = [];
  String? messageError;

  bool isLoading = false;
  bool isLoading2 = false;

  TextEditingController reviewController = TextEditingController();

  void fetchKaosById() async {
    setState(() {
      isLoading = true;
    });

    try {
      kaosList = await ApiService().getKaosById(widget.kaosId);
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
      isLoading2 = true;
    });

    try {
      alamatList = await ApiService().getAlamatList();
      setState(() {
        isLoading2 = false;
      });
    } catch (e) {
      messageError = e.toString();
      setState(() {
        isLoading2 = false;
      });
    }
  }

  Future<void> submitReview(review, oid) async {
    final String api = '${Env.apiKey}/$oid/review';

    setState(() {
      isLoading2 = true;
    });

    try {
      final dio = Dio();
      final response = await dio.post(
        api,
        data: {'review': review},
      );

      if (response.statusCode == 200) {
        kaosList = await ApiService().getKaosById(widget.kaosId);
        print('Review berhasil dikirim');
        isLoading2 = false;

        setState(() {});
      } else {
        print('Gagal mengirim review');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchKaosById();
    fetchAlamatData();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    final cartList2 = cartProvider.cartList2;
    var listHarga = cartProvider.listHarga;
    var listHarga2 = cartProvider.listHarga2;
    String review = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        foregroundColor: ColorConstant.foregroundColor,
        title: Text(
          'Space Store App',
          style: TextStyleConstant.bebasNeueBold,
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: ColorConstant.blueAccent,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      if (kaosList.isNotEmpty)
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            kaosList[0].image ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 16),
                      if (kaosList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        kaosList[0].nama ?? 'Nama Produk',
                                        style: TextStyleConstant.ibmPlexSans
                                            .copyWith(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        kaosList.isNotEmpty
                                            ? formatCurrency(kaosList[0].harga)
                                            : 'Harga Produk',
                                        style: TextStyleConstant.ibmPlexSans
                                            .copyWith(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 24,
                                        color: ColorConstant.yellowAccent,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(kaosList[0].rating ?? 'Rating',
                                          style: TextStyleConstant.ibmPlexSans
                                              .copyWith(fontSize: 24)),
                                      const SizedBox(width: 6),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (kaosList.isNotEmpty)
                                Text(
                                  kaosList[0].keterangan ?? 'Keterangan',
                                  style: TextStyleConstant.ibmPlexSans
                                      .copyWith(fontSize: 16),
                                ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (kaosList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.blackAccent3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.blueAccent,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Center(
                                    child: Text(
                                      'Review',
                                      style: TextStyleConstant.ibmPlexSans
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: reviewController,
                                    style: TextStyleConstant.ibmPlexSans
                                        .copyWith(
                                            color: ColorConstant.blackAccent),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 16),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      labelStyle: TextStyleConstant.ibmPlexSans
                                          .copyWith(
                                        color: ColorConstant.backgroundColor,
                                      ),
                                      hintText: 'Tulis Review Anda',
                                      hintStyle: TextStyleConstant.ibmPlexSans
                                          .copyWith(
                                              color:
                                                  ColorConstant.backgroundColor,
                                              fontSize: 14),
                                      filled: true,
                                      fillColor: ColorConstant.foregroundColor,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                ColorConstant.blueAccent),
                                      ),
                                      onPressed: () {
                                        review = reviewController.text;
                                        submitReview(review, kaosList[0].oid);
                                        reviewController.clear();
                                        setState(() {});
                                      },
                                      child: isLoading2
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: ColorConstant
                                                    .foregroundColor,
                                              ),
                                            )
                                          : Text(
                                              'Kirim',
                                              style:
                                                  TextStyleConstant.ibmPlexSans,
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (kaosList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.blackAccent3,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  if (kaosList.isNotEmpty)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: kaosList[0].review!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            'Review ${index + 1}',
                                            style: TextStyleConstant.ibmPlexSans
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            (kaosList[0].review![index] ?? '0'),
                                            style: TextStyleConstant.ibmPlexSans
                                                .copyWith(fontSize: 14),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
      bottomSheet: BottomAppBar(
        height: 72,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorConstant.blueAccent),
                  ),
                  onPressed: () {
                    cartList2.clear();
                    listHarga2.clear();
                    cartList2.add(kaosList[0].id);
                    listHarga2.add(kaosList[0].harga);
                    cartProvider.updateCartLangsung(cartList2, listHarga2);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sukses'),
                        content: const Text(
                            'Item berhasil ditambahkan ke keranjang.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyleConstant.ibmPlexSans
                                  .copyWith(color: ColorConstant.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (alamatList.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TambahAlamatScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeliLangsungScreen(
                            alamatReq: alamatList[0],
                            cartList2: cartList2,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Beli Langsung',
                    style: TextStyleConstant.ibmPlexSans.copyWith(
                      color: ColorConstant.foregroundColor,
                    ),
                  ),
                ),
                const SizedBox(width: 36),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorConstant.blueAccent),
                  ),
                  onPressed: () {
                    cartList.add(kaosList[0].id);
                    listHarga.add(kaosList[0].harga);
                    cartProvider.updateCart(cartList, listHarga);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Sukses'),
                        content: const Text(
                            'Item berhasil ditambahkan ke keranjang.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyleConstant.ibmPlexSans
                                  .copyWith(color: ColorConstant.blueAccent),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    '+ Keranjang',
                    style: TextStyleConstant.ibmPlexSans.copyWith(
                      color: ColorConstant.foregroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
