import 'package:flutter/material.dart';

class InquiriesSeeAllView extends StatelessWidget {
  final List<Map<String, dynamic>> inquiries;

  const InquiriesSeeAllView({Key? key, required this.inquiries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Inquiries'),
      ),
      body: ListView.builder(
        itemCount: inquiries.length,
        itemBuilder: (context, index) {
          final inquiry = inquiries[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(inquiry['title'] as String),
              subtitle: Text('Status: ${inquiry['status'] as String}'),
              trailing: inquiry['status'] == 'Available'
                  ? IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Add to cart functionality
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}