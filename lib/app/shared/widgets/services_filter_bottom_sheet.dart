import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/config/app_color.dart';
import 'app_dropdown.dart';
import 'app_text_field.dart';

class ServicesFilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final void Function(Map<String, dynamic>) onApply;

  const ServicesFilterBottomSheet({
    super.key,
    this.initialFilters,
    required this.onApply,
  });

  @override
  State<ServicesFilterBottomSheet> createState() => _ServicesFilterBottomSheetState();
}

class _ServicesFilterBottomSheetState extends State<ServicesFilterBottomSheet> {
  final List<String> serviceTypes = ['General', 'Oil Change', 'Battery', 'Tires'];
  String? selectedServiceType;
  DateTime? selectedDate;
  String quickChoice = '';
  TimeOfDay? selectedTime;

  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    selectedServiceType = widget.initialFilters?['serviceType'] as String?;
    final millis = widget.initialFilters?['date'] as int?;
    selectedDate = millis != null ? DateTime.fromMillisecondsSinceEpoch(millis) : null;
    quickChoice = widget.initialFilters?['quick'] as String? ?? '';
    _dateController = TextEditingController(text: _formatDate(selectedDate));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? d) {
    if (d == null) return '';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 0)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: Colors.black,
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: const Color(0xFF1F1F1F),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = _formatDate(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    double targetHeight = screenHeight * 0.6;

    return SizedBox(
      height: targetHeight,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.transparent.withOpacity(0.3),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: const Border(
            top: BorderSide(color: Colors.white24, width: 1.5),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              color: Colors.white.withOpacity(0.08),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 67,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Text(
                    'Filter By',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Filter with your selected preference',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  AppDropdown<String>(
                    label: 'Service Type',
                    items: serviceTypes,
                    value: selectedServiceType,
                    hintText: 'Select service type',
                    onChanged: (val) => setState(() => selectedServiceType = val),
                    useDarkDropDown: false,
                    borderColor: AppColors.textWhite100,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _dateController,
                    label: 'Working Days',
                    hintText: 'Select Date',
                    readOnly: true,
                    onTap: _pickDate,
                    backgroundColor: AppColors.transparent,
                    useDarkTextField: false,
                    borderColor: AppColors.textWhite100,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(Icons.calendar_today_outlined, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _quickChip('Open Now'),
                      _quickChip('Open Today'),
                      _quickChip('Open Until Late'),
                      _timeChip(),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back<void>(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            widget.onApply({
                              'serviceType': selectedServiceType,
                              'date': selectedDate?.millisecondsSinceEpoch,
                              'quick': quickChoice,
                              'time': selectedTime?.format(context),
                            });
                            Get.back<void>();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Apply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickChip(String label) {
    final isSelected = quickChoice == label;
    return GestureDetector(
      onTap: () => setState(() => quickChoice = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E8B8B) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _timeChip() {
    return GestureDetector(
      onTap: () async {
        final now = TimeOfDay.now();
        final picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? now,
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: const TimePickerThemeData(
                dialHandColor: AppColors.primary,
              ),
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) setState(() => selectedTime = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text('Choose Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

void showServicesFilterBottomSheet({
  required BuildContext context,
  Map<String, dynamic>? initialFilters,
  required void Function(Map<String, dynamic>) onApply,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ServicesFilterBottomSheet(
      initialFilters: initialFilters,
      onApply: onApply,
    ),
  );
}
