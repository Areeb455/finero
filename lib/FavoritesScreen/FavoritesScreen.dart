import 'package:flutter/material.dart';

import '../crypto model/crypto model.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Crypto> favoriteCryptos;

  const FavoritesScreen({super.key, required this.favoriteCryptos});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.black87,
      ),
      body: widget.favoriteCryptos.isEmpty
          ? const Center(
              child: Text(
                'No favorites added yet.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: widget.favoriteCryptos.length,
              itemBuilder: (context, index) {
                final crypto = widget.favoriteCryptos[index];
                return ListTile(
                  leading: Image.network(crypto.image, width: 50),
                  title: Text(crypto.name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                );
              },
            ),
      backgroundColor: const Color(0xFF1E1E1E),
    );
  }
}
