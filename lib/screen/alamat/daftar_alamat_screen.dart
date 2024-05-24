import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/model/alamat_model.dart';
import 'package:mini_project/screen/checkout/checkout_screen.dart';
import 'package:mini_project/screen/alamat/tambah_alamat_screen.dart';
import 'package:mini_project/service/api_service.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';

class DaftarAlamatScreen extends StatefulWidget {
  const DaftarAlamatScreen({super.key});

  @override
  State<DaftarAlamatScreen> createState() => _DaftarAlamatScreenState();
}

class _DaftarAlamatScreenState extends State<DaftarAlamatScreen> {
  List<AlamatModel> alamatList = [];
  String? messageError;

  bool isLoading = false;
  bool isLoading2 = false;

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

  Future<void> deleteAlamat(String? id) async {
    setState(() {
      isLoading = true;
    });

    try {
      bool isSuccess = await ApiService().deleteAlamat(id);
      if (isSuccess) {
        print('Data berhasil dihapus');
        fetchAlamatData();
      } else {
        print('Gagal menghapus data');
      }
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
    fetchAlamatData();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => ApiService().getAllKaos(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daftar Alamat Kamu',
                      style: TextStyleConstant.ibmPlexSans,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorConstant.blueAccent),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TambahAlamatScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Tambah Alamat',
                        style: TextStyleConstant.ibmPlexSans,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: ColorConstant.blueAccent,
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 28 / 9,
                          ),
                          itemCount: alamatList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Container(
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
                                      SizedBox(
                                        width: 192,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 8),
                                            Text(
                                                alamatList[index].nama ??
                                                    'Nama',
                                                style: TextStyleConstant
                                                    .ibmPlexSans
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                                alamatList[index].nomor ??
                                                    'Nomor',
                                                style: TextStyleConstant
                                                    .ibmPlexSans
                                                    .copyWith(fontSize: 16)),
                                            Text(
                                              alamatList[index].alamat ??
                                                  'Alamat',
                                              style: TextStyleConstant
                                                  .ibmPlexSans
                                                  .copyWith(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                try {
                                                  final String? objectId =
                                                      alamatList[index].id;
                                                  await deleteAlamat(objectId);
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              icon: const Icon(Icons.delete)),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckoutScreen(
                                                    alamatReq:
                                                        alamatList[index],
                                                    cartList: cartList,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Gunakan',
                                              style: TextStyleConstant
                                                  .ibmPlexSans
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
