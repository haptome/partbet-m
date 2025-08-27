import 'package:get/get.dart';

class OrderModel {
  final String orderId;
  final String date;
  final String title;
  final String brand;
  final String price;
  final String status; // e.g., 'Pending', 'Processing'
  final String buttonText;
  final String tab; // 'Active', 'Completed', 'Canceled'

  OrderModel({
    required this.orderId,
    required this.date,
    required this.title,
    required this.brand,
    required this.price,
    required this.status,
    required this.buttonText,
    required this.tab,
  });
}

class OrdersController extends GetxController {
  var selectedTabIndex = 0.obs;

  final orders = <OrderModel>[
    OrderModel(
      orderId: "#ORD-90213",
      date: "January 12, 2025",
      title: "Carbonator",
      brand: "Brand",
      price: "ETB 5200",
      status: "Pending",
      buttonText: "Pay Now",
      tab: "Active",
    ),
    OrderModel(
      orderId: "#ORD-90213",
      date: "January 12, 2025",
      title: "Carbonator",
      brand: "Brand",
      price: "ETB 5200",
      status: "Processing",
      buttonText: "Track",
      tab: "Active",
    ),
    // Example Completed
    OrderModel(
      orderId: "#ORD-89122",
      date: "January 10, 2025",
      title: "Compressor",
      brand: "Brand",
      price: "ETB 3200",
      status: "Completed",
      buttonText: "Invoice",
      tab: "Completed",
    ),
       OrderModel(
      orderId: "#ORD-89128",
      date: "January 10, 2025",
      title: "Compressor",
      brand: "Brand",
      price: "ETB 3200",
      status: "Canceled",
      buttonText: "Canceled",
      tab: "Canceled",
    ),
  ].obs;

  List<OrderModel> get filteredOrders {
    final tab = ['Active', 'Completed', 'Canceled'][selectedTabIndex.value];
    return orders.where((o) => o.tab == tab).toList();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
