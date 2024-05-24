import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/screen/product/detail_produk_screen.dart';
import 'package:mini_project/format/format_currency.dart';
import 'package:mini_project/service/api_service.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  List<KaosModel> kaosList = [];
  String? messageError;

  bool isLoading = false;

  void fetchData() async {
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
                child: RefreshIndicator(
                  onRefresh: () async => ApiService().getAllKaos(),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 4,
                            ),
                            itemCount: kaosList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailProdukScreen(
                                                kaosId: kaosList[index].id),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                kaosList[index].image ?? '',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            kaosList[index].nama ??
                                                'Nama Produk',
                                            style: TextStyleConstant.ibmPlexSans
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                formatCurrency(
                                                    kaosList[index].harga),
                                                style: TextStyleConstant
                                                    .ibmPlexSans
                                                    .copyWith(fontSize: 12),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: ColorConstant
                                                        .yellowAccent,
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                      kaosList[index].rating ??
                                                          'Rating',
                                                      style: TextStyleConstant
                                                          .ibmPlexSans
                                                          .copyWith(
                                                              fontSize: 12)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            kaosList[index].keterangan ??
                                                'Detail Produk',
                                            style: TextStyleConstant.ibmPlexSans
                                                .copyWith(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
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
            ),
    );
  }
}
