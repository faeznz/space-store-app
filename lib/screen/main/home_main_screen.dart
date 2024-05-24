import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mini_project/constant/text_style_constant.dart';
import 'package:mini_project/screen/main/all_product_screen.dart';
import 'package:mini_project/screen/main/ai_area_screen.dart';
import 'package:mini_project/screen/main/cart_screen.dart';
import 'package:mini_project/screen/main/home_screen.dart';
import '../../constant/color_constant.dart';

// ignore: must_be_immutable
class HomeMain extends StatefulWidget {
  int currentIndex = 0;
  HomeMain({super.key, required this.currentIndex});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const AllProductScreen(),
    const CartScreen(),
    const AiAreaScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Space Store App',
          style: TextStyleConstant.bebasNeueBold,
        ),
        centerTitle: true,
      ),
      body: _pages.elementAt(widget.currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        currentIndex: widget.currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.shirt,
              size: 20,
            ),
            label: 'All Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people),
            label: 'Ask AI',
          ),
        ],
      ),
    );
  }
}
