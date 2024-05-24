import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AiAreaProvider extends ChangeNotifier {
  final TextEditingController qnaController = TextEditingController();
  final Gemini gemini = Gemini.instance;

  String? data;
  bool isLoading = false;

  @override
  void dispose() {
    qnaController.dispose();
    super.dispose();
  }

  Future<void> askQuestion() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await gemini.text(
          "Dari data produk kaos saya berikut : Cosmic Explorer Tee dengan harga Rp.150.000 dan rating 4. Review untuk item ini mencakup kata-kata Mantap, Keren, Barangnya bagus, dan Nice. Meteor Shower T-shirt dijual dengan harga Rp.120.000 dan mendapat rating 5. Solar System Skirt tersedia dengan harga Rp.220.000 dan mendapat rating 5. Review untuk item ini menyatakan bahwa desainnya keren, produknya mantap sekali, dan sangat keren. Aurora Borealis dijual dengan harga Rp.150.000 dan mendapat rating 5. Satu-satunya review yang ada untuk item ini menyebutkan bahwa produknya Mantap banget. Rocket Ringer T-shirt dengan harga Rp.120.000 dan rating 4.5. Review untuk item ini mencakup kata-kata Keren dan Mantap. Solar Flare Shorts dijual dengan harga Rp.140.000 dan mendapat rating 4. Satu-satunya review untuk item ini menyatakan bahwa kualitasnya bagus banget. Constellation tersedia dengan harga Rp.150.000 dan mendapat rating 5. Astronaut On A Bike dijual dengan harga Rp.150.000 dan mendapat rating 5. Starlight T-Shirt dengan harga Rp.150.000 dan mendapat rating 4. Interplanetary tersedia dengan harga Rp.160.000 dan mendapat rating 5. Dari informasi yang telah saya berikan, ${qnaController.text}");
      data = response?.output;
    } catch (e) {
      print(e);
    } finally {
      qnaController.clear();
      isLoading = false;
      notifyListeners();
    }
  }
}
