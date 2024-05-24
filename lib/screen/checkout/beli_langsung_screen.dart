import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/model/alamat_model.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/screen/alamat/daftar_alamat_screen.dart';
import 'package:mini_project/screen/main/home_main_screen.dart';
import 'package:mini_project/screen/checkout/proses_pesanan_screen.dart';
import 'package:mini_project/format/format_currency.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:mini_project/service/api_service.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BeliLangsungScreen extends StatefulWidget {
  final AlamatModel? alamatReq;

  List<dynamic> cartList2 = [];
  BeliLangsungScreen({super.key, this.alamatReq, required this.cartList2});

  @override
  State<BeliLangsungScreen> createState() => _BeliLangsungScreen();
}

class _BeliLangsungScreen extends State<BeliLangsungScreen> {
  List<KaosModel> kaosList = [];
  List<AlamatModel> alamatList = [];
  String? messageError;

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
    final cartList2 = cartProvider.cartList2;
    final listHarga2 = cartProvider.listHarga2;
    var selectedKaos = cartProvider.selectedKaos;
    var totalStr2 = cartProvider.totalStr2;

    return Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Checkout',
                              style: TextStyleConstant.ibmPlexSans,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 100,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: ColorConstant.blueAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (kaosList.isNotEmpty)
                                    SizedBox(
                                      width: 280,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Alamat Pengiriman Kamu',
                                              style: TextStyleConstant
                                                  .ibmPlexSans),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_pin,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    widget.alamatReq?.nama ??
                                                        '',
                                                    style: TextStyleConstant
                                                        .ibmPlexSans
                                                        .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                widget.alamatReq?.alamat ?? '',
                                                style: TextStyleConstant
                                                    .ibmPlexSans,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DaftarAlamatScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Text('Barang Kamu',
                              style: TextStyleConstant.ibmPlexSans),
                          Expanded(
                            child: ListView.builder(
                              itemCount: cartList2.length,
                              itemBuilder: (context, index) {
                                for (int i = 0; i < kaosList.length; i++) {
                                  if (kaosList[i].id == cartList2[index]) {
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
                                    formatCurrency(selectedKaos?.harga ?? '0'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Divider(
                                height: 4,
                                color: ColorConstant.foregroundColor),
                            const SizedBox(height: 12),
                            Text('Ringkasan Belanja',
                                style: TextStyleConstant.ibmPlexSans),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Harga',
                                    style: TextStyleConstant.ibmPlexSans),
                                Text(totalStr2.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(120, 24)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorConstant.blueAccent),
                                ),
                                onPressed: () {
                                  cartList2.clear();
                                  listHarga2.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeMain(currentIndex: 1)),
                                  );
                                },
                                child: Text(
                                  'Batal',
                                  style: TextStyleConstant.ibmPlexSans,
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: const MaterialStatePropertyAll(
                                      Size(120, 24)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorConstant.blueAccent),
                                ),
                                onPressed: () {
                                  cartList2.clear();
                                  listHarga2.clear();
                                  cartProvider.totalHarga2 = 0;
                                  totalStr2 = '';
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProsesPesananScreen()),
                                  );
                                },
                                child: Text(
                                  'Beli',
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
