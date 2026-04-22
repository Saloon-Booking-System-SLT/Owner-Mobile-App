import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/manage/add_service_screen.dart';
import '../../../data/models/service_model.dart';
import '../../../data/models/staff_model.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/services_service.dart';
import '../../../data/services/staff_service.dart';
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
  bool isLoading = true;
  String? errorMessage;
  List<ServiceModel> services = [];
  List<StaffModel> staff = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchServices();
    _fetchStaff();
  }

  Future<void> _fetchServices() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final profile = await AuthService.getOwnerProfile();
      final salonId = profile['salon'] != null 
          ? profile['salon']['id'] 
          : profile['_id'];

      if (salonId == null) throw Exception('Salon ID not found');

      final fetchedServices = await ServicesService.fetchServices(salonId);
      
      setState(() {
        services = fetchedServices;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Fetch Services Error: $e');
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _fetchStaff() async {
    try {
      final profile = await AuthService.getOwnerProfile();
      final salonId = profile['salon'] != null 
          ? profile['salon']['id'] 
          : profile['_id'];

      if (salonId == null) return;

      final fetchedStaff = await StaffService.fetchStaff(salonId);
      
      setState(() {
        staff = fetchedStaff;
      });
    } catch (e) {
      debugPrint('Fetch Staff Error: $e');
    }
  }

  Future<void> _editStaff(StaffModel existingStaff) async {
    final serviceNames = services.map((s) => s.name).toList();
    final result = await Navigator.push<StaffModel>(
      context,
      MaterialPageRoute(
        builder: (context) => AddStaffScreen(
          availableServices: serviceNames,
          existingStaff: existingStaff,
        ),
      ),
    );

    if (result != null) {
      _fetchStaff();
    }
  }

  Future<void> _editService(ServiceModel service) async {
    final result = await showDialog<ServiceModel>(
      context: context,
      builder: (context) => AddServiceScreen(existingService: service),
    );

    if (result != null) {
      _fetchServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Manage',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
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
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
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
                      vertical: 12,
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
                          _fetchServices(); // Better to re-fetch to get consistent state
                        }
                      } else {
                        // Navigate to Add Staff Screen
                        final serviceNames = services
                            .map((s) => s.name)
                            .toList();
                        final newStaff = await Navigator.push<StaffModel>(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddStaffScreen(availableServices: serviceNames),
                          ),
                        );

                        // Add the new staff to the list if returned
                        if (newStaff != null) {
                          _fetchStaff();
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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Error: $errorMessage',
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    _fetchServices();
                                    _fetchStaff();
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : isServicesTab
                            ? _buildServicesList()
                            : _buildStaffList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesList() {
    final filteredServices = services
        .where((s) => s.name.toLowerCase().contains(searchQuery))
        .toList();

    if (filteredServices.isEmpty) {
      return const Center(child: Text('No services found'));
    }

    return RefreshIndicator(
      onRefresh: _fetchServices,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredServices.length,
        itemBuilder: (context, index) {
          final service = filteredServices[index];
          return ServiceCard(
            service: service,
            onEdit: () => _editService(service),
            onDelete: () async {
              try {
                await ServicesService.deleteService(service.id!);
                _fetchServices();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildStaffList() {
    final filteredStaff = staff
        .where((s) => s.name.toLowerCase().contains(searchQuery))
        .toList();

    if (filteredStaff.isEmpty) {
      return const Center(child: Text('No professionals found'));
    }

    return RefreshIndicator(
      onRefresh: _fetchStaff,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filteredStaff.length,
        itemBuilder: (context, index) {
          final staffMember = filteredStaff[index];
          return StaffCard(
            staff: staffMember,
            onEdit: () => _editStaff(staffMember),
            onDelete: () async {
              try {
                await StaffService.deleteStaff(staffMember.id!);
                _fetchStaff();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Delete failed: $e')),
                );
              }
            },
          );
        },
      ),
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
        border: isSelected
            ? const Border(
                bottom: BorderSide(color: Color(0xFF0066CC), width: 3),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: isSelected
                ? const Color(0xFF0066CC)
                : const Color(0xFF5C5C5C),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF0066CC)
                  : const Color(0xFF757575),
            ),
          ),
        ],
      ),
    ),
  );
}
