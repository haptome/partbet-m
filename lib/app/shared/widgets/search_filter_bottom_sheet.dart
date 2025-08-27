import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'app_dropdown.dart';
import 'app_text_field.dart';
import 'filter_chip_widget.dart';
import '../../core/config/app_color.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  final Map<String, dynamic>? initialFilters;
  final void Function(Map<String, dynamic>) onApply;

  const SearchFilterBottomSheet({
    Key? key,
    this.initialFilters,
    required this.onApply,
  }) : super(key: key);

  @override
  State<SearchFilterBottomSheet> createState() => _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  String? selectedCarMake;
  String? selectedCarModel;
  bool yearRange = false;
  int? selectedYear;
  int? yearFrom;
  int? yearTo;
  String? minPrice;
  String? maxPrice;
  String? selectedBrand;
  String? sortBy = 'Relevance';
  String selectedCondition = 'Used';

  final List<String> carMakes = ['Toyota', 'Hyundai', 'Ford', 'Honda', 'Vitz', 'Dzire'];
  final List<String> carModels = ['Corolla', 'Accent', 'Focus', 'Civic', 'Vitz', 'Dzire'];
  final List<int> years = [2001, 2002, 2003, 2004, 2005, 2009, 2010, 2011];
  final List<String> brands = ['Toyota', 'Hyundai', 'Ford', 'Honda', 'Vitz', 'Dzire'];
  final List<String> sortOptions = ['Relevance', 'Price: Low to High', 'Price: High to Low', 'Newest'];
  final List<String> conditions = ['Brand New', 'Used', 'Refurbished'];

  // Cupertino-like vertical wheel (used for range From/To)
  Widget _buildYearWheel({
    required int? selected,
    required ValueChanged<int> onSelected,
  }) {
    final int initialIndex = selected != null && years.contains(selected)
        ? years.indexOf(selected)
        : 0;

    const double itemExtent = 36;
    const double wheelHeight = 180;

    return Container(
      height: wheelHeight,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 0.8),
      ),
      child: Stack(
        children: [
          CupertinoPicker(
            backgroundColor: Colors.transparent,
            scrollController: FixedExtentScrollController(initialItem: initialIndex),
            itemExtent: itemExtent,
            magnification: 1.08,
            useMagnifier: true,
            squeeze: 1.0,
            selectionOverlay: Container(
              margin: const EdgeInsets.symmetric(
                vertical: (wheelHeight - itemExtent) / 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            onSelectedItemChanged: (int index) {
              final year = years[index];
              onSelected(year);
            },
            children: [
              for (final y in years)
                Center(
                  child: Text(
                    y.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          // Top/bottom fade
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.35),
                  ],
                  stops: const [0.0, 0.15, 0.85, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cupertino-like HORIZONTAL wheel for single-year selection
  Widget _buildYearWheelHorizontal({
    required int? selected,
    required ValueChanged<int> onSelected,
  }) {
    final int initialIndex = selected != null && years.contains(selected)
        ? years.indexOf(selected)
        : 0;
    const double itemExtent = 64; // item width
    const double wheelHeight = 56;

    return Container(
      height: wheelHeight,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 0.8),
      ),
      child: Stack(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: initialIndex),
              backgroundColor: Colors.transparent,
              itemExtent: itemExtent,
              magnification: 1.08,
              useMagnifier: true,
              squeeze: 1.0,
              selectionOverlay: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: (itemExtent - wheelHeight) / 2 < 0 ? 0 : (itemExtent - wheelHeight) / 2,
                ),
                color: Colors.white.withOpacity(0.08),
              ),
              onSelectedItemChanged: (int index) {
                final year = years[index];
                onSelected(year);
              },
              children: [
                for (final y in years)
                  RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child: Text(
                        y.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Left/right fade
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.35),
                  ],
                  stops: const [0.0, 0.15, 0.85, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearPill({
    required int year,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minWidth: 64, minHeight: 36),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.white.withOpacity(0.25),
            width: selected ? 1.6 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
          gradient: selected
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE58E2A), // lighter top
                    Color(0xFFCC6F0C), // deeper bottom
                  ],
                )
              : null,
        ),
        child: Text(
          year.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialFilters != null) {
      selectedCarMake = widget.initialFilters!['carMake'] as String?;
      selectedCarModel = widget.initialFilters!['carModel'] as String?;
      yearRange = widget.initialFilters!['yearRange'] as bool? ?? false;
      selectedYear = widget.initialFilters!['year'] as int?;
      yearFrom = widget.initialFilters!['yearFrom'] as int?;
      yearTo = widget.initialFilters!['yearTo'] as int?;
      minPrice = widget.initialFilters!['minPrice'] as String?;
      maxPrice = widget.initialFilters!['maxPrice'] as String?;
      selectedBrand = widget.initialFilters!['brand'] as String?;
      sortBy = widget.initialFilters!['sortBy'] as String? ?? 'Relevance';
      selectedCondition = widget.initialFilters!['condition'] as String? ?? 'Used';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    // Target 3/4 height; when keyboard shows, shrink so a tap on the dimmed
    // barrier is still possible to close the sheet.
    double targetHeight = screenHeight * 0.75;
    final available = screenHeight - keyboard - 16; // 16px safety gap
    if (targetHeight > available) targetHeight = available.clamp(200.0, screenHeight);
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 67,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const Text(
                    'Filter By',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Filter with your selected preference',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppDropdown<String>(
                    label: 'Select Car Make',
                    items: carMakes,
                    value: selectedCarMake,
                    hintText: 'Select car',
                    onChanged: (val) => setState(() => selectedCarMake = val),
                    useDarkDropDown: false,
                    borderColor: AppColors.textWhite100,
                  ),
                  const SizedBox(height: 16),
                  AppDropdown<String>(
                    label: 'Car Model',
                    items: carModels,
                    value: selectedCarModel,
                    hintText: 'Select car model',
                    onChanged: (val) => setState(() => selectedCarModel = val),
                    useDarkDropDown: false,
                    borderColor: AppColors.textWhite100,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Text('Car Model', style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text('Range', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Switch(
                    value: yearRange,
                    onChanged: (val) => setState(() {
                      yearRange = val;
                      if (yearRange) {
                        selectedYear = null;
                        yearFrom ??= years.first;
                        yearTo ??= years.last;
                        if (yearTo! < yearFrom!) {
                          yearTo = yearFrom;
                        }
                      } else {
                        yearFrom = null;
                        yearTo = null;
                        selectedYear ??= years.first;
                      }
                    }),
                    activeColor: AppColors.primary,
                  ),
                  if (!yearRange) ...[
                    _buildYearWheelHorizontal(
                      selected: selectedYear,
                      onSelected: (y) => setState(() => selectedYear = y),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('From', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 8),
                              _buildYearWheel(
                                selected: yearFrom,
                                onSelected: (y) => setState(() {
                                  yearFrom = y;
                                  if (yearTo != null && yearTo! < yearFrom!) {
                                    yearTo = yearFrom;
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('To', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 8),
                              _buildYearWheel(
                                selected: yearTo,
                                onSelected: (y) => setState(() {
                                  yearTo = y;
                                  if (yearFrom != null && yearTo! < yearFrom!) {
                                    yearFrom = yearTo;
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: TextEditingController(text: minPrice),
                          hintText: 'Min',
                          keyboardType: TextInputType.number,
                          backgroundColor: AppColors.transparent,
                          useDarkTextField: false,
                          borderColor: AppColors.textWhite100,
                          onChanged: (String? val) => minPrice = val,
                          readOnly: false,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          controller: TextEditingController(text: maxPrice),
                          hintText: 'Max',
                          keyboardType: TextInputType.number,
                          backgroundColor: AppColors.transparent,
                          useDarkTextField: false,
                          borderColor: AppColors.textWhite100,
                          onChanged: (String? val) => maxPrice = val,
                          readOnly: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppDropdown<String>(
                    label: 'Brand',
                    items: brands,
                    value: selectedBrand,
                    hintText: 'Select brand',
                    onChanged: (String? val) => setState(() => selectedBrand = val),
                    useDarkDropDown: false,
                    borderColor: AppColors.textWhite100,
                  ),
                  const SizedBox(height: 16),
                  AppDropdown<String>(
                    label: 'Sort By',
                    items: sortOptions,
                    value: sortBy,
                    hintText: 'Relevance',
                    onChanged: (String? val) => setState(() => sortBy = val),
                    useDarkDropDown: false,
                    borderColor: AppColors.textWhite100,
                  ),
                  const SizedBox(height: 16),
                  const Text('Condition', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 8),
                  Row(
                    children: conditions.map((cond) {
                      final isSelected = selectedCondition == cond;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChipWidget(
                          label: cond,
                          isSelected: isSelected,
                          selectedColor: const Color(0xFF2E8B8B),
                          onTap: () => setState(() => selectedCondition = cond),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Get.back<void>(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final Map<String, dynamic> filters = {
                              'carMake': selectedCarMake,
                              'carModel': selectedCarModel,
                              'minPrice': minPrice,
                              'maxPrice': maxPrice,
                              'brand': selectedBrand,
                              'sortBy': sortBy,
                              'condition': selectedCondition,
                            };
                            if (yearRange) {
                              filters['yearRange'] = true;
                              filters['yearFrom'] = yearFrom;
                              filters['yearTo'] = yearTo;
                            } else {
                              filters['yearRange'] = false;
                              filters['year'] = selectedYear;
                            }
                            widget.onApply(filters);
                            Get.back<void>();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
                ],
              ),
            ),
          ),
        ),
      ),)
    );
  }
}

void showSearchFilterBottomSheet({
  required BuildContext context,
  Map<String, dynamic>? initialFilters,
  required void Function(Map<String, dynamic>) onApply,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SearchFilterBottomSheet(
      initialFilters: initialFilters,
      onApply: onApply,
    ),
  );
}
