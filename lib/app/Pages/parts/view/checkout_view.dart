import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../../../shared/widgets/address_select_bottom_sheet.dart';
import '../../../shared/widgets/order_summary_section.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List<Map<String, dynamic>> items = [
    {
      'image':
          'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png',
      'name': 'Carbonator',
      'brand': 'Brand',
      'qty': 2,
      'price': 500,
    },
    {
      'image':
          'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png',
      'name': 'Air Filter A281',
      'brand': 'Bosch',
      'qty': 1,
      'price': 500,
    },
  ];

  String deliveryMode = 'delivery'; // 'pickup' or 'delivery'
  String addressLabel = 'Home';
  String addressText = 'Addis Abeba, Ethiopia';

  int get subTotal =>
      items.fold(0, (s, e) => s + (e['qty'] as int) * (e['price'] as int));
  int get deliveryCost => deliveryMode == 'delivery' ? 200 : 0;
  int get total => subTotal + deliveryCost;

  void _increment(int index) {
    setState(() => items[index]['qty'] = (items[index]['qty'] as int) + 1);
  }

  void _decrement(int index) {
    setState(() {
      final q = items[index]['qty'] as int;
      items[index]['qty'] = q > 1 ? q - 1 : 1;
    });
  }

  void _remove(int index) {
    setState(() => items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const GeneralAppBar(title: 'Checkout', showBackButton: true),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
                children: [
                  OrderSummarySection(
                    items: items,
                    title: 'Order Summary',
                    trailing: Text('${items.length} Items',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12)),
                    onIncrement: (i) => setState(
                        () => items[i]['qty'] = (items[i]['qty'] as int) + 1),
                    onDecrement: (i) => setState(() {
                      final q = items[i]['qty'] as int;
                      items[i]['qty'] = q > 1 ? q - 1 : 1;
                    }),
                    onRemove: (i) => setState(() => items.removeAt(i)),
                  ),
                  const SizedBox(height: 12),
                  _section(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionHeader('Delivery Address'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _modeChip('Pick Up',
                                subtitle: 'Free',
                                selected: deliveryMode == 'pickup',
                                onTap: () =>
                                    setState(() => deliveryMode = 'pickup')),
                            const SizedBox(width: 12),
                            _modeChip('Delivery',
                                subtitle: 'Fee will be applied',
                                selected: deliveryMode == 'delivery',
                                onTap: () =>
                                    setState(() => deliveryMode = 'delivery')),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _addressTile(),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _iconText(
                                icon: Icons.local_shipping_outlined,
                                text: 'Estimated Delivery Time'),
                            _iconText(
                                icon: Icons.time_to_leave_rounded,
                                text: '2 - 3 Days'),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _section(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionHeader('Payment Information'),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(AppAssets.chapa),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text('Chappa',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(999)),
                              child: const Text('Default',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _section(
                    child: Column(
                      children: [
                        _priceRow('Sub Total', subTotal),
                        const SizedBox(height: 6),
                        _priceRow('Estimated Delivery Cost', deliveryCost),
                        const Divider(color: Colors.white24, height: 16),
                        _priceRow('Total', total, isBold: true),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16 + MediaQuery.of(context).padding.bottom,
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: items.isEmpty ? null : () {},
                    icon: const Icon(Icons.shopping_bag_outlined,
                        color: Colors.white),
                    label: const Text('Buy',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderItem(int i) {
    final it = items[i];
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(it['image'] as String,
              width: 48, height: 48, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(it['name'] as String,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              Text(it['brand'] as String,
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        _squareButton(
            icon: Icon(Icons.remove),
            onTap: () => _decrement(i),
            color: Colors.white.withOpacity(0.1)),
        const SizedBox(width: 8),
        Text((it['qty'] as int).toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        _squareButton(
            icon: Icon(Icons.add),
            onTap: () => _increment(i),
            color: AppColors.primary),
        const SizedBox(width: 8),
        _squareButton(
            icon: SvgPicture.asset(
              AppAssets.deleteIcon,
              colorFilter:
                  ColorFilter.mode(AppColors.textWhite100, BlendMode.srcIn),
            ),
            
            onTap: () => _remove(i),
            color: const Color(0xFFE05252)),
      ],
    );
  }

  Widget _modeChip(String label,
      {String? subtitle, required bool selected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color:
                selected ? AppColors.primary : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700)),
              if (subtitle != null)
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addressTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: const Color(0xFF442B0F),
                borderRadius: BorderRadius.circular(22)),
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.location_on,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addressLabel,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text(addressText,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          _squareButton(
            icon: SvgPicture.asset(
              AppAssets.locationMap,
              colorFilter:
                  ColorFilter.mode(AppColors.textWhite100, BlendMode.srcIn),
            ),
            onTap: () async {
              final result =
                  await showAddressSelectBottomSheet(context: context);
              if (result != null) {
                setState(() {
                  addressLabel = result['label'] as String;
                  addressText = result['address'] as String;
                });
              }
            },
            color: Colors.white.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, int value, {bool isBold = false}) {
    final style = TextStyle(
        color: Colors.white,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w600);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
            '${value.toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => '${m[1]},')} BIRR',
            style: style),
      ],
    );
  }

  Widget _section({required Widget child}) => Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.all(12),
        child: child,
      );

  Widget _sectionHeader(String title, {Widget? trailing}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          if (trailing != null) trailing,
        ],
      );

  Widget _squareButton(
          {required Widget icon,
          required VoidCallback onTap,
          required Color color}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child: icon),
      );

  Widget _iconText({required IconData icon, required String text}) => Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white70)),
        ],
      );
}
