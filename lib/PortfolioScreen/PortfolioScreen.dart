import 'package:flutter/material.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final Map<String, double> holdings = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio'),
        backgroundColor: Colors.black87,
      ),
      body: holdings.isEmpty
          ? const Center(
              child: Text(
                'No holdings added yet.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: holdings.entries.map((entry) {
                return ListTile(
                  title: Text(
                    '${entry.key}: ${entry.value} coins',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFBB86FC),
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddHoldingDialog();
        },
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    );
  }

  void _showAddHoldingDialog() {
    String cryptoName = '';
    double amount = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C2C2C),
          title: const Text(
            'Add Holding',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => cryptoName = value,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Crypto Name',
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
              TextField(
                onChanged: (value) => amount = double.parse(value),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add', style: TextStyle(color: Color(0xFFBB86FC))),
              onPressed: () {
                setState(() {
                  holdings[cryptoName] = amount;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
