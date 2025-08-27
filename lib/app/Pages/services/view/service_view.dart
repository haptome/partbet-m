import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/Pages/main/controllers/nav_controller.dart';

import 'package:get/get.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../controller/services_controller.dart';
import '../../../shared/widgets/services_filter_bottom_sheet.dart';


class ServicesView extends GetView<NavController> {
  ServicesView({
    super.key,

  }) : super();
  
 final TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    Get.put(ServicesController(), permanent: true);
    return _ServicesViewBody(searchController: searchController);
  }
}

class _ServicesViewBody extends StatefulWidget {
  final TextEditingController searchController;
  const _ServicesViewBody({required this.searchController});
  @override
  State<_ServicesViewBody> createState() => _ServicesViewBodyState();
}

class _ServicesViewBodyState extends State<_ServicesViewBody> {
  bool showMapView = true;

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Services',
        showBackButton: false,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.notification,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () => Get.toNamed<void>('/notifications'),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.cart,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () => Get.toNamed<void>('/cart'),
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 17,
                      height: 17,
                      child: Center(
                        child: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                AppTextField(
                          controller: widget.searchController,
                          hintText: 'Search by name,service and location',
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
                const SizedBox(height: 18),
                // Find Service Locations title and filter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Service Locations',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Find service location',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => showMapView = true),
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: showMapView ? Color(0xFFFFA726) : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppAssets.service,
                                colorFilter: ColorFilter.mode(
                                    AppColors.textWhite100,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => showMapView = false),
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              color: !showMapView ? Color(0xFFFFA726) : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                AppAssets.list,
                                colorFilter: ColorFilter.mode(
                                    AppColors.textWhite100,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 38,
                          width: 58,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              showServicesFilterBottomSheet(
                                context: context,
                                initialFilters: const {},
                                onApply: (filters) {},
                              );
                            },
                            child: Center(
                              child: Text(
                                                        'Filter',
                                                        style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                if (showMapView) ...[
                  // Map View Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.65,
                      color: Colors.white,
                      child: Image.network(
                        'https://miro.medium.com/v2/resize:fit:817/1*S0tSYTQJ6Gm_PKq39Pkx0g.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ] else ...[
                  // Service Card List
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ServiceCard(
                          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2g0gpBRhvOmGtWyoJTfDXciIB0qXCpHmC1rSteYYm2tPrltc1GPSgZ_6c6h0SYJP5R-k&usqp=CAU',
                          name: 'Jemo Auto Tech',
                          address: '22 Mazoria, Addis Ababa',
                          isOpen: true,
                          tags: ['General', 'Oil Change'],
                          onCall: () {},
                          onWhatsApp: () {},
                          onView: () {},
                        ),
                        const SizedBox(height: 18),
                        ServiceCard(
                          image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2g0gpBRhvOmGtWyoJTfDXciIB0qXCpHmC1rSteYYm2tPrltc1GPSgZ_6c6h0SYJP5R-k&usqp=CAU',
                          name: 'Jemo Auto Tech',
                          address: '22 Mazoria, Addis Ababa',
                          isOpen: false,
                          tags: ['General', 'Oil Change'],
                          onCall: () {},
                          onWhatsApp: () {},
                          onView: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
}

class ServiceCard extends StatelessWidget {
  final String image;
  final String name;
  final String address;
  final bool isOpen;
  final List<String> tags;
  final VoidCallback onCall;
  final VoidCallback onWhatsApp;
  final VoidCallback onView;

  const ServiceCard({
    required this.image,
    required this.name,
    required this.address,
    required this.isOpen,
    required this.tags,
    required this.onCall,
    required this.onWhatsApp,
    required this.onView,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      // Navigate to service detail view with service data
      Get.toNamed(
        AppRoutes.SERVICE_DETAILS,
        arguments: {
          'name': name,
          'image': image,
          'address': address,
          'isOpen': isOpen,
          'tags': tags,
        },
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
              child: Image.network(
                image,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      decoration: BoxDecoration(
                        color: isOpen ? const Color(0xFF21C362).withOpacity(0.3) : const Color(0xFFFF3B30).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isOpen ? const Color(0xFF21C362) : const Color(0xFFFF3B30),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isOpen ? const Color(0xFF21C362) : const Color(0xFFFF3B30),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isOpen ? 'Open' : 'Closed',
                            style:  TextStyle(
                              color: isOpen ? const Color(0xFF21C362) : const Color(0xFFFF3B30),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                     SvgPicture.asset(
                              AppAssets.service,
                              colorFilter: ColorFilter.mode(
                                  AppColors.textWhite100,
                                  BlendMode.srcIn),
                            ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white70, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Mon–Sat, 8:00 AM – 6:00 PM',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: tags.map((tag) => Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: tag == 'General' ? Color(0xFFB86B1F) : Color(0xFFFFA726),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB86B1F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: onCall,
                        icon:SvgPicture.asset(
                              AppAssets.call,
                              colorFilter: ColorFilter.mode(
                                  AppColors.textWhite100,
                                  BlendMode.srcIn),
                            ),
                        label: const Text('Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: onWhatsApp,
                        icon: SvgPicture.asset(
                              AppAssets.whatsapp,
                              colorFilter: ColorFilter.mode(
                                  AppColors.textWhite100,
                                  BlendMode.srcIn),
                            ),
                        label: const Text('WhatsApp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.08),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: onView,
                        icon: SvgPicture.asset(
                              AppAssets.view,
                              colorFilter: ColorFilter.mode(
                                  AppColors.textWhite100,
                                  BlendMode.srcIn),
                            ),
                        label: const Text('View', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

