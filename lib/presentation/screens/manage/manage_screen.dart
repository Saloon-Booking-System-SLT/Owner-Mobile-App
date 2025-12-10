import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/manage/add_service_screen.dart';
import '../../../data/models/service_model.dart';
import '../../../data/models/staff_model.dart';
import '../../widgets/home/bottom_nav_bar.dart';
import '../../widgets/manage/service_card.dart';
import '../../widgets/manage/staff_card.dart';
import 'add_staff_screen.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  bool isServicesTab = true;

  final List<ServiceModel> services = [
    ServiceModel(
      name: 'Hair Cut',
      category: 'Hair Services',
      description: 'Professional haircut with styling',
      price: 3500,
      duration: 60,
      gender: 'Both',
      imageUrl:
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400',
    ),
    ServiceModel(
      name: 'Hair Cut',
      category: 'Hair Services',
      description: 'Professional haircut with styling',
      price: 3500,
      duration: 60,
      gender: 'Both',
      imageUrl:
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400',
    ),
    ServiceModel(
      name: 'Hair Cut',
      category: 'Hair Services',
      description: 'Professional haircut with styling',
      price: 3500,
      duration: 60,
      gender: 'Both',
      imageUrl:
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400',
    ),
    ServiceModel(
      name: 'Hair Cut',
      category: 'Hair Services',
      description: 'Professional haircut with styling',
      price: 3500,
      duration: 60,
      gender: 'Both',
      imageUrl:
      'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?w=400',
    ),
  ];

  final List<StaffModel> staff = [
    StaffModel(
      name: 'Sarah Johnson',
      gender: 'Female',
      isAvailable: true,
      services: ['Hair Cut', 'Hair Color', 'Hair Styling'],
      availability: 'Monday, Tuesday, Wednesday, Thursday, Friday',
      workingHours: '9:00 AM - 6:00 PM',
      photo: null,
      photoPath:
      'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400',
    ),
    StaffModel(
      name: 'John Williams',
      gender: 'Male',
      isAvailable: false,
      services: ['Hair Cut', 'Beard Trim'],
      availability: 'Monday, Wednesday, Friday',
      workingHours: '10:00 AM - 7:00 PM',
      photo: null,
      photoPath:
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    ),
    StaffModel(
      name: 'John Williams',
      gender: 'Male',
      isAvailable: false,
      services: ['Hair Cut', 'Beard Trim'],
      availability: 'Monday, Wednesday, Friday',
      workingHours: '10:00 AM - 7:00 PM',
      photo: null,
      photoPath:
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    ),
    StaffModel(
      name: 'John Williams',
      gender: 'Male',
      isAvailable: false,
      services: ['Hair Cut', 'Beard Trim'],
      availability: 'Monday, Wednesday, Friday',
      workingHours: '10:00 AM - 7:00 PM',
      photo: null,
      photoPath:
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title:const Text(
          'Manage',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF1A1A1A),
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTabButton(
                          icon: Icons.business_center_outlined,
                          label: 'Services',
                          isSelected: isServicesTab,
                          onTap: () => setState(() => isServicesTab = true),
                        ),
                      ),
                      Expanded(
                        child: _buildTabButton(
                          icon: Icons.people_outline,
                          label: 'Staff',
                          isSelected: !isServicesTab,
                          onTap: () => setState(() => isServicesTab = false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: isServicesTab
                        ? 'Search services...'
                        : 'Search professionals...',
                    hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF9E9E9E),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (isServicesTab) {
                        // Show Add Service Dialog
                        final newService = await showDialog<ServiceModel>(
                          context: context,
                          builder: (context) => const AddServiceScreen(),
                        );

                        // Add the new service to the list if returned
                        if (newService != null) {
                          setState(() {
                            services.add(newService);
                          });
                        }
                      } else {
                        // Navigate to Add Staff Screen
                        final serviceNames = services.map((s) => s.name).toList();
                        final newStaff = await Navigator.push<StaffModel>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddStaffScreen(availableServices: serviceNames),
                          ),
                        );

                        // Add the new staff to the list if returned
                        if (newStaff != null) {
                          setState(() {
                            staff.add(newStaff);
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: Text(
                      isServicesTab ? 'Add Service' : 'Add Professional',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: isServicesTab
                    ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return ServiceCard(service: services[index]);
                  },
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: staff.length,
                  itemBuilder: (context, index) {
                    return StaffCard(staff: staff[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}

Widget _buildTabButton({
  required IconData icon,
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade300 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? const Color(0xFF1A1A1A)
                : const Color(0xFF5C5C5C),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFF757575),
            ),
          ),
        ],
      ),
    ),
  );
}
