import 'package:flutter/material.dart';

class InquiryDetailsView extends StatelessWidget {
  final String inquiryId;
  final String submissionDate;
  final String title;
  final String description;
  final String status;
  final double? price;

  const InquiryDetailsView({
    Key? key,
    required this.inquiryId,
    required this.submissionDate,
    required this.title,
    required this.description,
    required this.status,
    this.price,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Available':
        return Colors.green;
      case 'Unavailable':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inquiry Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submitted Date: $submissionDate',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Inquiry #$inquiryId',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (price != null)
              Text('ETB ${price!.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.green,
                      )),
            const SizedBox(height: 8),
            Text(description, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            Chip(
              label: Text(status),
              backgroundColor: _getStatusColor(status),
            ),
            const Spacer(),
            if (status == 'Available')
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
              ),
          ],
        ),
      ),
    );
  }
}