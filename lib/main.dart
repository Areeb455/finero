import 'package:flutter/material.dart';
import 'crypto model/crypto model.dart';
import 'FavoritesScreen/FavoritesScreen.dart';
import 'api service/api service.dart';
import 'PortfolioScreen/PortfolioScreen.dart';
import 'NewsFeedScreen/NewsFeedScreen.dart';
import 'crypto_detail_screen/crypto_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Market Data',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        primaryColor: const Color(0xFFBB86FC),
      ),
      home: const CryptoMarketScreen(),
    );
  }
}

class CryptoMarketScreen extends StatefulWidget {
  const CryptoMarketScreen({super.key});

  @override
  _CryptoMarketScreenState createState() => _CryptoMarketScreenState();
}

class _CryptoMarketScreenState extends State<CryptoMarketScreen> {
  List<Crypto> cryptoData = [];
  List<Crypto> favoriteCryptos = [];

  @override
  void initState() {
    super.initState();
    fetchCryptoData();
  }

  Future<void> fetchCryptoData() async {
    List<Crypto> data = await fetchCryptoMarketData();
    setState(() {
      cryptoData = data;
    });
  }

  void toggleFavorite(Crypto crypto) {
    setState(() {
      if (favoriteCryptos.contains(crypto)) {
        favoriteCryptos.remove(crypto); 
      } else {
        favoriteCryptos.add(crypto); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Finero',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PortfolioScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favoriteCryptos: favoriteCryptos),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.article),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsScreen()),
              );
            },
          ),
        ],
      ),
      body: cryptoData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cryptoData.length,
              itemBuilder: (context, index) {
                return CryptoCard(
                  crypto: cryptoData[index],
                  isFavorite: favoriteCryptos.contains(cryptoData[index]),
                  onFavoriteToggle: toggleFavorite,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CryptoDetailScreen(crypto: cryptoData[index]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final Crypto crypto;
  final Function(Crypto) onFavoriteToggle;
  final bool isFavorite;
  final Function() onTap;

  const CryptoCard({super.key, 
    required this.crypto,
    required this.onFavoriteToggle,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF323232), Color(0xFF1C1C1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.network(
                crypto.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      crypto.symbol.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${crypto.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBB86FC),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 14,
                      color: crypto.priceChangePercentage24h >= 0
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () => onFavoriteToggle(crypto),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CryptoDetailScreen extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailScreen({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(crypto.name),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(crypto.image, width: 100, height: 100),
            const SizedBox(height: 20),
            Text(
              'Current Price: \$${crypto.currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '24h Price Change: ${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18, color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 10),
           
          ],
        ),
      ),
    );
  }
}
