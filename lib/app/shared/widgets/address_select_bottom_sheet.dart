import 'dart:ui';
import 'package:flutter/material.dart';

Future<Map<String, String>?> showAddressSelectBottomSheet({
  required BuildContext context,
}) async {
  final List<Map<String, String>> addresses = [
    {'label': 'Home', 'address': 'Addis Abeba, Ethiopia', 'default': 'true'},
    {'label': 'Office', 'address': 'Addis Abeba, Ethiopia'},
    {'label': 'Garaj', 'address': 'Addis Abeba, Ethiopia'},
    {'label': 'Pick Up', 'address': 'I will pick it up myself'},
  ];
  int selected = 0;

  return showModalBottomSheet<Map<String, String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final viewInsets = MediaQuery.of(context).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: viewInsets),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: StatefulBuilder(builder: (context, setState) {
              return Container(
                color: Colors.white.withOpacity(0.08),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        height: 6,
                        margin: const EdgeInsets.only(bottom: 18, top: 6),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                    const Text('Update Address', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24)),
                    const SizedBox(height: 6),
                    const Text('Edit your delivery address to your preferred location.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 16),
                    for (int i = 0; i < addresses.length; i++) ...[
                      _addressRow(
                        addresses[i],
                        i,
                        selected,
                        (v) => setState(() => selected = v),
                      ),
                      const SizedBox(height: 16),
                    ],
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB86B1F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        onPressed: () => Navigator.of(context).pop(addresses[selected]),
                        child: const Text('Change Address', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}

Widget _addressRow(Map<String, String> addr, int index, int selected, ValueChanged<int> onChanged) {
  final isDefault = addr['default'] == 'true';
  return GestureDetector(
    onTap: () => onChanged(index),
    child: Row(
      children: [
        // Concentric location marker
        SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A6A49).withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(color: Color(0xFFFFA726), shape: BoxShape.circle),
              ),
              const Icon(Icons.location_on, color: Colors.white, size: 24),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(addr['label']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                  ),
                  if (isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                      child: const Text('Default', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(addr['address']!, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ),
        // Custom radio look
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 2),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: selected == index ? const Color(0xFFB86B1F) : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}
