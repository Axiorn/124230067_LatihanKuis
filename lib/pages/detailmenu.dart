import 'package:flutter/material.dart';
import 'package:latkuis_ppam/data/menudata.dart';

class DetailPesan extends StatefulWidget {
  final int index;
  const DetailPesan({super.key, required this.index});

  @override
  State<DetailPesan> createState() => _DetailPesanState();
}

class _DetailPesanState extends State<DetailPesan> {
  final TextEditingController _controller = TextEditingController();
  int totalHarga = 0;
  String? _errorText;

  void _hitungTotal() {
    int? jumlah = int.tryParse(_controller.text);
    if (jumlah == null || jumlah <= 0) {
      setState(() {
        _errorText = "Jumlah tidak valid";
        totalHarga = 0;
      });
      return;
    }
    int harga = int.parse(menuList[widget.index].price.replaceAll('.', ''));
    setState(() {
      _errorText = null;
      totalHarga = jumlah * harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
        backgroundColor: const Color(0xFF00AA13),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar menu dalam card rounded
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  menuList[widget.index].imageassets[0],
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nama & harga
            Text(
              menuList[widget.index].name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              "Rp ${menuList[widget.index].price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // Input jumlah
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Pesanan',
                prefixIcon: const Icon(Icons.shopping_bag),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText: _errorText,
              ),
            ),

            const SizedBox(height: 20),

            // Tombol submit mirip style Gojek
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AA13), // hijau khas
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 2,
                ),
                onPressed: _hitungTotal,
                child: const Text(
                  "Pesan Sekarang",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Total harga
            if (totalHarga > 0)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Harga",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Rp $totalHarga",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
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
