import 'package:flutter/material.dart';

class OrderSummarySection extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final VoidCallback? onChanged; // optional signal after increment/decrement/remove
  final void Function(int index)? onIncrement;
  final void Function(int index)? onDecrement;
  final void Function(int index)? onRemove;
  final String? title;
  final Widget? trailing;

  const OrderSummarySection({
    super.key,
    required this.items,
    this.onChanged,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,
    this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!, style: const TextStyle(color: Colors.white70)),
                if (trailing != null) trailing!,
              ],
            ),
          if (title != null) const SizedBox(height: 6),
          ...List.generate(items.length, (i) {
            final it = items[i];
            return Column(
              children: [
                _itemRow(
                  context,
                  name: (it['name'] ?? '').toString(),
                  brand: (it['brand'] ?? '').toString(),
                  image: (it['image'] ?? '').toString(),
                  qty: (it['qty'] ?? 1) as int,
                  onInc: onIncrement == null ? null : () => onIncrement!(i),
                  onDec: onDecrement == null ? null : () => onDecrement!(i),
                  onDel: onRemove == null ? null : () => onRemove!(i),
                ),
                if (i != items.length - 1)
                  const Divider(color: Colors.white24, height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _itemRow(
    BuildContext context, {
    required String name,
    required String brand,
    required String image,
    required int qty,
    VoidCallback? onInc,
    VoidCallback? onDec,
    VoidCallback? onDel,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(image, width: 48, height: 48, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              Text(brand, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        // Match cart behavior: if qty == 1, show delete instead of decrement
        qty > 1
            ? _squareButton(icon: Icons.remove, onTap: onDec, color: Colors.white.withOpacity(0.1))
            : _squareButton(icon: Icons.delete_outline, onTap: onDel, color: const Color(0xFFE05252)),
        const SizedBox(width: 8),
        Text(qty.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        _squareButton(icon: Icons.add, onTap: onInc, color: const Color(0xFFB86B1F)),
      ],
    );
  }

  Widget _squareButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}


