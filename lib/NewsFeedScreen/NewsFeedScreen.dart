import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto News',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: fetchNews(), // Call the fetchNews function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return NewsCard(
                  title: articles[index].title,
                  content: articles[index].content,
                );
              },
            );
          }
        },
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    );
  }

  Future<List<NewsArticle>> fetchNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=b25e7fb5bf7d4fe886e654123e78d509'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((article) => NewsArticle.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class NewsArticle {
  final String title;
  final String content;

  NewsArticle({required this.title, required this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'],
      content: json['description'] ?? '', 
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String content;

  const NewsCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}