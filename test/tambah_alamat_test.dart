import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/provider/cart_provider.dart';
import 'package:mini_project/screen/alamat/tambah_alamat_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('TambahAlamatScreen inisial UI testing', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: MaterialApp(
          home: TambahAlamatScreen(),
        ),
      ),
    );

    // Allow the widget to settle
    await tester.pumpAndSettle();

    // Verify the initial state of the screen
    expect(find.text('Tambah Data Alamat'), findsOneWidget);
    expect(find.text('Alamat'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Nomor'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });
}
