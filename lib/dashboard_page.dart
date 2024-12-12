import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk parsing JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Impor intl untuk memformat angka
import 'package:latlogin/settings_page.dart';
import 'cart_page.dart';
import 'login.dart'; // Impor halaman login
import 'productdetailpage.dart';
import 'riwayat.dart'; // Impor halaman ProductDetailPage

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List cartItems = [];
  List products = [];
  bool isLoading = true; // Menyimpan status loading
  String errorMessage = ''; // Menyimpan pesan error jika ada

  // Fungsi untuk mengambil data produk dari API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/latlogin/get_products.php'), // Ganti dengan URL API Anda
      );

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading =
              false; // Set loading ke false setelah data berhasil diambil
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading ke false jika terjadi error
        errorMessage = e.toString(); // Simpan pesan error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Panggil fungsi untuk mengambil data saat widget diinisialisasi
  }

  // Fungsi untuk memformat harga
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigasi ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cartItems: [],)),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Keranjang Belanja'),
              onTap: () {
Navigator.push(context,MaterialPageRoute(builder: (context) => CartPage(cartItems: [],)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat Belanja'),
              onTap: () {
                // Navigasi ke halaman riwayat belanja
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RiwayatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                ); // Tambahkan logika untuk navigasi ke halaman pengaturan
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Berbelanja',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Text(errorMessage)) // Menampilkan pesan error
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        product['image'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.error,
                                            size: 100,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['product'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        // Gunakan format angka untuk harga
                                        Text(
                                          formatCurrency(product['price']),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                  productName:
                                                      product['product'] ??
                                                          'Unknown Product',
                                                  productPrice: formatCurrency(
                                                      product['price'] ?? '0'),
                                                  productImage:
                                                      product['image'] ?? '',
                                                  productDescription:
                                                      product['description'] ??
                                                          'No description',
                                                  productId:
                                                      product['idproduct'] ??
                                                          '0',
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size(double.infinity, 36),
                                          ),
                                          child: const Text('Beli'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

exit() {}
