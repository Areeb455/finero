import 'package:flutter/material.dart';

import '../crypto model/crypto model.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          crypto.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                crypto.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Symbol: ${crypto.symbol.toUpperCase()}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Current Price: \$${crypto.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Price Change (24h): ${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 18,
                color: crypto.priceChangePercentage24h >= 0
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Market Cap: ${_formatMarketCap(crypto.marketCap)}',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB86FC),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text('Back to Market'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    );
  }

  // Helper function to format the market cap
  String _formatMarketCap(double? marketCap) {
    if (marketCap == null) return 'N/A';
    if (marketCap >= 1e9) {
      return '\$${(marketCap / 1e9).toStringAsFixed(2)} B';
    } else if (marketCap >= 1e6) {
      return '\$${(marketCap / 1e6).toStringAsFixed(2)} M';
    } else {
      return '\$${marketCap.toStringAsFixed(2)}';
    }
  }
}
