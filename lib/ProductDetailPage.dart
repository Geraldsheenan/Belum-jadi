import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// Import package intl

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;
  final String productDescription;
  final String productId;

  const ProductDetailPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isWishlisted = false; // Status wishlist

  // Fungsi untuk memformat harga dengan NumberFormat
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter
        .format(int.parse(price.replaceAll(RegExp(r'[^0-9]'), '')) / 100);
  }

  Future<void> _buyProduct(BuildContext context) async {
  final productId = 1; // ID produk
  final userId = 123;  // ID pengguna
  final quantity = 1;  // Jumlah yang dibeli

  final url = Uri.parse('http://localhost/latlogin/penjualan.php');
  try {
    final response = await http.post(
      url,
      body: {
        'product_id': productId.toString(),
        'user_id': userId.toString(),
        'quantity': quantity.toString(),
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembelian berhasil dicatat')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mencatat pembelian: ${responseData['message']}')),
      );
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan: $error')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    String formattedPrice = formatCurrency(widget.productPrice);

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Judul produk di kiri
            Text(
              widget.productName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Ikon chat di sebelah kanan AppBar
          IconButton(
            icon: const Icon(Icons.chat_outlined, color: Colors.black45),
            onPressed: () {
              // Tindakan yang diambil ketika ikon chat diklik
              print('Chatbox ditekan!');
              // Bisa tambahkan navigasi ke halaman chat
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar di sisi kiri
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.productImage,
                width: 350, // Perbesar gambar dengan width
                height: 350, // Perbesar gambar dengan height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    size: 100,
                    color: Colors.red,
                  );
                },
              ),
            ),
            const SizedBox(width: 16), // Jarak antara gambar dan teks
            // Penjelasan dan tombol di sisi kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                          width: 10), // Jarak antara harga dan ikon wishlist
                      // Ikon wishlist di sebelah kanan harga
                      IconButton(
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: isWishlisted ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isWishlisted =
                                !isWishlisted; // Toggle wishlist status
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    formattedPrice,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 137, 198, 139),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.productDescription,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('keranjang ditekan!');
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    label: const Text(
                      'Keranjang',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 70, 70),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _buyProduct(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side:
                            BorderSide(color: Colors.green.shade100, width: 1),
                      ),
                    ),
                    child: Text(
                      'Beli Sekarang',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 233, 68, 68),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
