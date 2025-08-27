import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/auth_background.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final TextEditingController _searchController = TextEditingController();
  // Dummy address list for demonstration
  List<Map<String, dynamic>> addressList = [
    // Uncomment the below to test the empty state
    //
    // If you want to test the empty state, set this to []
    {
      'label': 'Home',
      'address': 'Addis Abeba, Ethiopia',
      'isDefault': true,
    },
    {
      'label': 'Office',
      'address': 'Addis Abeba, Ethiopia',
      'isDefault': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: GeneralAppBar(
          title: 'Address',
          showBackButton: true,
          trailing: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFB86B1F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white, size: 24),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: _AddressBottomSheet(),
                  ),
                );
              },
            ),
          ),
        ),
        body: AuthBackground(
        padding: 0,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2B1A0F),
                      Color(0xFF18100B),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      if (addressList.isNotEmpty) ...[
                        const Text(
                          'Manage up to 5 saved addresses. Edit, remove, or set one as your default for quick checkout.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    
                      const SizedBox(height: 24),
                      if (addressList.isEmpty) ...[
                        const Spacer(),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 180,
                                child: Image.asset(
                                  AppAssets.noLocation,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 32),
                              const Text(
                                'No location added!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Please add your location first so we can\nsend your orders safely to you.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                width: 180,
                                height: 48,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: _AddressBottomSheet(),
                  ),
                );
                                  },
                                  icon: SvgPicture.asset(
                            AppAssets.location,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                                  label: const Text(
                                    'Add Location',
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
                        ),
                        const Spacer(),
                      ]
                        // Show address list UI
          
                        else ...[
                        // Show address list UI
          
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Locations',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${addressList.length}/5',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              for (int i = 0; i < addressList.length; i++) ...[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: _AddressTile(
                                    label: addressList[i]['label'] as String,
                                    address: addressList[i]['address'] as String,
                                    isDefault:
                                        addressList[i]['isDefault'] as bool,
                                    isSelected:
                                        i == 0, // Only first is selected for demo
                                  ),
                                ),
                                if (i != addressList.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Divider(
                                      color: Colors.white.withOpacity(0.12),
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                        const Spacer(),
                       
                      ],
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// Bottom sheet for Add/Edit Address
class _AddressBottomSheet extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? initialData;
  const _AddressBottomSheet({
    this.isEdit = false,
    this.initialData,
    Key? key,
  }) : super(key: key);

  @override
  State<_AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<_AddressBottomSheet> {
  late TextEditingController searchController;
  late TextEditingController nameController;
  late TextEditingController countryController;
  late TextEditingController cityController;
  late TextEditingController kebeleController;
  late TextEditingController woredaController;
  late TextEditingController postalController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.initialData?['label'] as String? ?? '');
    nameController = TextEditingController(text: widget.initialData?['label'] as String? ?? '');
    countryController = TextEditingController(text: widget.initialData?['country'] as String? ?? '');
    cityController = TextEditingController(text: widget.initialData?['city'] as String? ?? '');
    kebeleController = TextEditingController(text: widget.initialData?['street'] as String? ?? '');
    woredaController = TextEditingController(text: widget.initialData?['street'] as String? ?? '');
    postalController = TextEditingController(text: widget.initialData?['postal'] as String? ?? '');
  }

  @override
  void dispose() {
    searchController.dispose();
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    kebeleController.dispose();
    woredaController.dispose();
    postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        color: AppColors.transparent.withOpacity(0.3),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        border: const Border(
          top: BorderSide(
        color: Colors.white24, // or any color you prefer
        width: 1.5,
          ),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              widget.isEdit ? 'Update Address' : 'Add New Address',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.isEdit
                  ? 'Edit your delivery address to your preferred location.'
                  : 'Add your preferred location for delivery.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 18),

            AppTextField(
                          controller: searchController,
                          hintText: 'Search your location',
                          backgroundColor: AppColors.transparent,
                          useDarkTextField: false,
                          borderColor: AppColors.textWhite100,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 12.sp,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              AppAssets.service,
                              colorFilter: ColorFilter.mode(
                                  AppColors.textWhite100.withOpacity(0.4),
                                  BlendMode.srcIn),
                            ),
                          )),
            const SizedBox(height: 20),

            AppTextField(
              controller: nameController,
              hintText: 'Address Name',
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            
              
            ),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8),
              child: Text(
                'e.g. Home, Garage, Work',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),

            AppTextField(
              controller: countryController,
              hintText: 'Country',
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(height: 8),

            AppTextField(
              controller: cityController,
              hintText: 'City',
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(height: 8),

            AppTextField(
              controller: kebeleController,
              hintText: 'Street',
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(height: 8), AppTextField(
              controller: woredaController,
              hintText: 'Street',
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(height: 8),

            AppTextField(
              controller: postalController,
              hintText: 'Postal Code',
              keyboardType: TextInputType.number,
               backgroundColor: AppColors.transparent,
              useDarkTextField: false,
              borderColor: AppColors.textWhite100,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(height: 18),
          
             AppButton(
              text: widget.isEdit ? 'Update Address' : 'Save Address',
              onPressed: () {},
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              borderRadius: 8,
              height: 40.h,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
            ),
          ),
        ),
      );
}



// Address tile widget for the list
class _AddressTile extends StatelessWidget {
  final String label;
  final String address;
  final bool isDefault;
  final bool isSelected;
  const _AddressTile({
    required this.label,
    required this.address,
    required this.isDefault,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF442B0F),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA726),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.location_on,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (isDefault)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor:
                    Colors.white, // outline color when not selected
                radioTheme: RadioThemeData(
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return const Color(0xFFB86B1F); // orange dot
                      }
                      return Colors.white; // outline color
                    },
                  ),
                ),
              ),
              child: Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (_) {},
                activeColor: const Color(0xFFB86B1F), // orange dot
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      );
}
