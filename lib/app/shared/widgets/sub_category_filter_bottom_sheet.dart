import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/config/app_color.dart';

class SubCategoryFilterBottomSheet extends StatefulWidget {
  final List<String> allSubCategories;
  final List<String> selectedSubCategories;
  final void Function(List<String>) onSelectionChanged;

  const SubCategoryFilterBottomSheet({
    Key? key,
    required this.allSubCategories,
    required this.selectedSubCategories,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  State<SubCategoryFilterBottomSheet> createState() => _SubCategoryFilterBottomSheetState();
}

class _SubCategoryFilterBottomSheetState extends State<SubCategoryFilterBottomSheet> {
  late List<String> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedSubCategories);
  }

  void _toggleSelection(String category) {
    setState(() {
      if (selectedItems.contains(category)) {
        selectedItems.remove(category);
      } else {
        selectedItems.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A), // Dark background matching the design
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                const Text(
                  'Sub Categories',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Filter with your selected preference',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Sub category chips
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: widget.allSubCategories.map((category) {
                    final isSelected = selectedItems.contains(category);
                    return _buildSelectableChip(category, isSelected);
                  }).toList(),
                ),
                const SizedBox(height: 32),
                
                // Show selected button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedItems.isNotEmpty ? () {
                      widget.onSelectionChanged(selectedItems);
                      Get.back<void>();
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      selectedItems.isNotEmpty 
                          ? 'Show Selected (${selectedItems.length})'
                          : 'Show Selected (0)',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                // Add bottom padding for safe area
                SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleSelection(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFF2E8B8B) // Teal color for selected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF2E8B8B)
                : Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 12,
                  color: Color(0xFF2E8B8B),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Helper function to show the bottom sheet
void showSubCategoryFilterBottomSheet({
  required BuildContext context,
  required List<String> allSubCategories,
  required List<String> selectedSubCategories,
  required void Function(List<String>) onSelectionChanged,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SubCategoryFilterBottomSheet(
      allSubCategories: allSubCategories,
      selectedSubCategories: selectedSubCategories,
      onSelectionChanged: onSelectionChanged,
    ),
  );
}
