import 'package:flutter/material.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/model/alamat_model.dart';
import 'package:mini_project/screen/checkout/checkout_screen.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:mini_project/service/api_service.dart';
import 'package:provider/provider.dart';

class TambahAlamatScreen extends StatefulWidget {
  TambahAlamatScreen({super.key});

  @override
  State<TambahAlamatScreen> createState() => _TambahAlamatScreenState();
}

class _TambahAlamatScreenState extends State<TambahAlamatScreen> {
  TextEditingController labelController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void submitForm(String label, String alamat, String nama, String nomor,
      List cartlist) async {
    Map<String, dynamic> alamatModel = {
      'label': label,
      'alamat': alamat,
      'nama': nama,
      'nomor': nomor,
    };

    AlamatModel modelAlamat = AlamatModel(
      label: label,
      alamat: alamat,
      nama: nama,
      nomor: nomor,
    );

    setState(() {
      isLoading = true;
    });

    try {
      bool isSuccess = await ApiService().submitAlamat(alamatModel);

      if (isSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutScreen(
              alamatReq: modelAlamat,
              cartList: cartlist,
            ),
          ),
        );
        isLoading = false;
        print('Data berhasil dikirim');
      } else {
        setState(() {
          isLoading = false;
        });
        print('Gagal mengirim data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    labelController.dispose();
    alamatController.dispose();
    namaController.dispose();
    nomorController.dispose();
    idController.dispose();
    super.dispose();
  }

  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  final ValueNotifier<String?> selectedItem = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartList = cartProvider.cartList;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Text('Tambah Data Alamat', style: TextStyleConstant.ibmPlexSans),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: TextStyleConstant.ibmPlexSans
                          .copyWith(color: ColorConstant.blackAccent),
                      decoration: InputDecoration(
                        hintText: 'Alamat',
                        hintStyle: TextStyleConstant.ibmPlexSans
                            .copyWith(color: ColorConstant.blackAccent),
                        fillColor: ColorConstant.foregroundColor,
                        filled: true,
                      ),
                      controller: alamatController,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: TextStyleConstant.ibmPlexSans
                          .copyWith(color: ColorConstant.blackAccent),
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyleConstant.ibmPlexSans
                            .copyWith(color: ColorConstant.blackAccent),
                        fillColor: ColorConstant.foregroundColor,
                        filled: true,
                      ),
                      controller: namaController,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: TextStyleConstant.ibmPlexSans
                          .copyWith(color: ColorConstant.blackAccent),
                      decoration: InputDecoration(
                        hintText: 'Nomor',
                        hintStyle: TextStyleConstant.ibmPlexSans
                            .copyWith(color: ColorConstant.blackAccent),
                        fillColor: ColorConstant.foregroundColor,
                        filled: true,
                      ),
                      controller: nomorController,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorConstant.blueAccent)),
                onPressed: () {
                  String alamat = alamatController.text;
                  String nama = namaController.text;
                  String nomor = nomorController.text;
                  String label = labelController.text;
                  submitForm(label, alamat, nama, nomor, cartList);
                },
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.foregroundColor,
                        ),
                      )
                    : Text(
                        'Submit',
                        style: TextStyleConstant.ibmPlexSans,
                      ))
          ],
        ),
      ),
    );
  }
}
