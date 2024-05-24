import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/constant/color_constant.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import '../../provider/ai_area_provider.dart';

class AiAreaScreen extends StatelessWidget {
  const AiAreaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AiAreaProvider>(
      builder: (context, aiProvider, child) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image/bg-pattern.png"),
                  fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            TextFormField(
                              style: TextStyleConstant.ibmPlexSans
                                  .copyWith(color: ColorConstant.blackAccent),
                              decoration: InputDecoration(
                                  hintText: 'Tuliskan pertanyaan anda',
                                  fillColor: ColorConstant.foregroundColor,
                                  filled: true,
                                  hintStyle:
                                      TextStyleConstant.ibmPlexSans.copyWith(
                                    color: ColorConstant.backgroundColor,
                                  )),
                              controller: aiProvider.qnaController,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '*Tanya seputar produk ini',
                              style: TextStyleConstant.ibmPlexSans.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  aiProvider.askQuestion();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorConstant.blueAccent,
                                  ),
                                  height: 40,
                                  width: 200,
                                  child: Center(
                                    child: Text(
                                      'Tanya AI',
                                      style: TextStyleConstant.ibmPlexSans
                                          .copyWith(
                                        fontSize: 14,
                                        color: ColorConstant.foregroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
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
                                          Text(
                                            'Jawaban AI',
                                            style: TextStyleConstant.ibmPlexSans
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          aiProvider.isLoading
                                              ? CircularProgressIndicator(
                                                  color:
                                                      ColorConstant.blueAccent,
                                                )
                                              : Text(
                                                  aiProvider.data ?? '',
                                                  style: TextStyleConstant
                                                      .ibmPlexSans,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
        );
      },
    );
  }
}
