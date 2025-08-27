import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partbet/app/Pages/orders/controller/orders_controller.dart';
import 'package:partbet/app/Pages/orders/widgets/order_card.dart';

class ActiveOrdersTab extends StatelessWidget {
  const ActiveOrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrdersController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Text(
            "Orders",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            final orders = controller.filteredOrders;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, index) => OrderCard(order: orders[index]),
            );
          }),
        ),
      ],
    );
  }
}
