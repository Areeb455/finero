class Crypto {
  final String name;
  final String symbol;
  final double currentPrice;
  final double priceChangePercentage24h;
  final String image;
  final double? marketCap; 

  Crypto({
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChangePercentage24h,
    required this.image,
    this.marketCap, // Nullable field
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: (json['current_price'] as num).toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
      image: json['image'],
      marketCap: (json['market_cap'] as num?)?.toDouble(), 
    );
  }
}
class NewsArticle {
  final String title;
  final String content;

  NewsArticle({required this.title, required this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      content: json['content'] ?? '',
    );
  }
}
