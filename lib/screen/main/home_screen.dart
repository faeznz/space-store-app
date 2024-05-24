import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/gen/assets_gen.dart';
import 'package:mini_project/model/kaos_model.dart';
import 'package:mini_project/screen/product/detail_produk_screen.dart';
import 'package:mini_project/format/format_currency.dart';
import 'package:mini_project/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/bg-pattern.png"),
                    fit: BoxFit.cover),
              ),
              child: RefreshIndicator(
                onRefresh: () async => fetchData(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: ColorConstant.backgroundColor,
                        child: Center(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ShaderMask(
                                      shaderCallback: (rect) {
                                        return const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                        ).createShader(Rect.fromLTRB(
                                            0, 50, rect.width, rect.height));
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child:
                                          Assets.image.spaceBcakground.image()),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 120),
                                      child: Column(
                                        children: [
                                          Text(
                                            'The future is here, Own it!',
                                            style: TextStyleConstant
                                                .bebasNeueBold
                                                .copyWith(
                                              fontSize: 32,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32, right: 32, top: 12),
                                            child: Text(
                                              'Jelajahi gaya yang luar biasa dengan koleksi baju bertema angkasa kami! Terinspirasi dari keindahan alam semesta, baju-baju ini mengangkatmu ke level berikutnya. Mulai petualangan fashionmu sekarang dan terbang tinggi dengan gaya yang tak terbatas!',
                                              style: TextStyleConstant
                                                  .ibmPlexSans
                                                  .copyWith(
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trending Brands',
                              style: TextStyleConstant.ibmPlexSans.copyWith(
                                color: ColorConstant.foregroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProdukScreen(
                                        kaosId: kaosList[0].id),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  color: ColorConstant.blackAccent,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      if (kaosList.isNotEmpty)
                                        AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Image.network(
                                            kaosList[0].image ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      if (kaosList.isNotEmpty)
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 180,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorConstant.blackAccent,
                                                ColorConstant.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  kaosList[0].nama ??
                                                      'Nama Produk',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      kaosList.isNotEmpty
                                                          ? formatCurrency(
                                                              kaosList[0].harga)
                                                          : 'Harga Produk',
                                                      style: TextStyleConstant
                                                          .ibmPlexSans
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 20,
                                                          color: ColorConstant
                                                              .yellowAccent,
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                            kaosList[0]
                                                                    .rating ??
                                                                'Rating',
                                                            style:
                                                                TextStyleConstant
                                                                    .ibmPlexSans
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProdukScreen(
                                        kaosId: kaosList[4].id),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  color: ColorConstant.blackAccent,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      if (kaosList.isNotEmpty)
                                        AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Image.network(
                                            kaosList[4].image ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      if (kaosList.isNotEmpty)
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 180,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorConstant.blackAccent,
                                                ColorConstant.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  kaosList[4].nama ??
                                                      'Nama Produk',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      kaosList.isNotEmpty
                                                          ? formatCurrency(
                                                              kaosList[4].harga)
                                                          : 'Detail Produk',
                                                      style: TextStyleConstant
                                                          .ibmPlexSans
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 20,
                                                          color: ColorConstant
                                                              .yellowAccent,
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                            kaosList[4]
                                                                    .rating ??
                                                                'Rating',
                                                            style:
                                                                TextStyleConstant
                                                                    .ibmPlexSans
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProdukScreen(
                                        kaosId: kaosList[3].id),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  color: ColorConstant.blackAccent,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      if (kaosList.isNotEmpty)
                                        AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Image.network(
                                            kaosList[3].image ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      if (kaosList.isNotEmpty)
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          height: 180,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ColorConstant.blackAccent,
                                                ColorConstant.transparent
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  kaosList[3].nama ??
                                                      'Nama Produk',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans
                                                      .copyWith(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      kaosList.isNotEmpty
                                                          ? formatCurrency(
                                                              kaosList[3].harga)
                                                          : 'Detail Produk',
                                                      style: TextStyleConstant
                                                          .ibmPlexSans
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 20,
                                                          color: ColorConstant
                                                              .yellowAccent,
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Text(
                                                            kaosList[3]
                                                                    .rating ??
                                                                'Rating',
                                                            style:
                                                                TextStyleConstant
                                                                    .ibmPlexSans
                                                                    .copyWith(
                                                                        fontSize:
                                                                            16)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Store',
                              style: TextStyleConstant.ibmPlexSans.copyWith(
                                color: ColorConstant.foregroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: ColorConstant.purpleAccent),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2 / 1,
                                      child: Assets.image.toko1
                                          .image(fit: BoxFit.fill),
                                    ),
                                    Container(
                                      height: 150,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color:
                                              ColorConstant.blacktransparent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.location_pin,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Yogyakarta',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans
                                                      .copyWith(
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'JL. Brigjen Katamso, Prawirodirjan, Keparakan, Kota Yogyakarta, Daerah Istimewa Yogyakarta',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyleConstant
                                                  .ibmPlexSans
                                                  .copyWith(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 150,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: ColorConstant.purpleAccent),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2 / 1,
                                      child: Assets.image.toko2
                                          .image(fit: BoxFit.fill),
                                    ),
                                    Container(
                                      height: 150,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color:
                                              ColorConstant.blacktransparent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.location_pin,
                                                  size: 24,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Semarang',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans
                                                      .copyWith(
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Jl. Indraprasta 1, Pendrikan Kidul, Kota Semarang, Jawa Tengah',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyleConstant
                                                  .ibmPlexSans
                                                  .copyWith(fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Join our community !',
                              style: TextStyleConstant.ibmPlexSans.copyWith(
                                color: ColorConstant.foregroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await EasyLauncher.url(
                                    mode: Mode.inAppBrowser,
                                    url: "https://discord.com/invite/B7x3sHPQ");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConstant.blueAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 12),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.discord,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Discord',
                                        style: TextStyleConstant.ibmPlexSans,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await EasyLauncher.url(
                                    mode: Mode.inAppBrowser,
                                    url: "https://t.me/+xKdImNbOD7kxZjc1");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorConstant.blueAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 12),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.telegram,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Telegram',
                                        style: TextStyleConstant.ibmPlexSans,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyleConstant.ibmPlexSans.copyWith(
                                color: ColorConstant.foregroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () async {
                            await EasyLauncher.url(
                                mode: Mode.inAppBrowser,
                                url: "http://wa.me//+6285156254824");
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorConstant.blueAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Whatsapp',
                                    style: TextStyleConstant.ibmPlexSans,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
