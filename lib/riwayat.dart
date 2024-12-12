import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  // Contoh data riwayat belanja
  final List<Map<String, dynamic>> riwayatBelanja = [
    {
      'tanggal': '05 Desember 2024',
      'produk': 'Tote Bag',
      'jumlah': 1,
      'total': 3588899,
    },
    // Tambahkan lebih banyak data sesuai kebutuhan
  ];

  RiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Belanja'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: riwayatBelanja.length,
          itemBuilder: (context, index) {
            final item = riwayatBelanja[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(item['produk']),
                subtitle: Text('Tanggal: ${item['tanggal']}'),
                trailing: Text('Total: Rp ${item['total']}'),
                onTap: () {
                  // Logika untuk melihat detail belanja
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Detail Belanja'),
                        content: Text(
                          'Produk: ${item['produk']}\n'
                          'Jumlah: ${item['jumlah']}\n'
                          'Total: Rp ${item['total']}\n'
                          'Tanggal: ${item['tanggal']}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Tutup'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}