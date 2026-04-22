import 'package:flutter/material.dart';
import 'package:owner_salon_management/data/services/staff_service.dart';
import 'package:owner_salon_management/data/models/staff_model.dart';
import 'package:owner_salon_management/data/models/service_model.dart';
import 'datetime_selection.dart';

class ProfessionalSelectionScreen extends StatefulWidget {
  final String salonId;
  final String customerName;
  final String customerPhoneNumber;
  final String customerEmail;
  final List<ServiceModel> selectedServices;

  const ProfessionalSelectionScreen({
    super.key,
    required this.salonId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerEmail,
    required this.selectedServices,
  });

  @override
  State<ProfessionalSelectionScreen> createState() =>
      _ProfessionalSelectionScreenState();
}

class _ProfessionalSelectionScreenState
    extends State<ProfessionalSelectionScreen> {
  String _selectedTab = 'All';
  StaffModel? _selectedProfessional;
  List<StaffModel> _professionals = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProfessionals();
  }

  Future<void> _loadProfessionals() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final staff = await StaffService.fetchStaff(widget.salonId);

      setState(() {
        _professionals = staff;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load professionals: $e';
      });
    }
  }

  List<StaffModel> get filteredProfessionals {
    List<StaffModel> filtered = _professionals;

    if (_selectedTab == 'Available Today') {
      filtered = filtered.where((p) => p.isAvailable).toList();
    } else if (_selectedTab == 'Top Rated') {
      // If you have ratings in your model, sort by them
      // For now, just return all professionals
      filtered = List<StaffModel>.from(_professionals);
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Select Professional',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade50,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadProfessionals,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Professionals',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildTabButton('All'),
                          const SizedBox(width: 8),
                          _buildTabButton('Available Today'),
                          const SizedBox(width: 8),
                          _buildTabButton('Top Rated'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        'All Professionals (${filteredProfessionals.length} found)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredProfessionals.isEmpty
                      ? const Center(
                          child: Text(
                            'No professionals available',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: filteredProfessionals.length,
                          itemBuilder: (context, index) {
                            return _buildProfessionalCard(
                              filteredProfessionals[index],
                            );
                          },
                        ),
                ),
                if (_selectedProfessional != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  '${_selectedProfessional!.name} Selected',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '| ${_selectedProfessional!.services.isNotEmpty ? _selectedProfessional!.services.first : "Professional"}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DateTimeSelectionScreen(
                                  salonId: widget.salonId,
                                  customerName: widget.customerName,
                                  customerPhoneNumber:
                                      widget.customerPhoneNumber,
                                  customerEmail: widget.customerEmail,
                                  selectedServices: widget.selectedServices,
                                  selectedProfessional: _selectedProfessional!,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade900,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildTabButton(String text) {
    final isSelected = _selectedTab == text;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTab = text;
            _selectedProfessional = null;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? Colors.blue.shade900
              : Colors.grey.shade50,
          foregroundColor: isSelected ? Colors.white : Colors.grey.shade700,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalCard(StaffModel professional) {
    final isSelected = _selectedProfessional == professional;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue.shade900 : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      professional.services.isNotEmpty
                          ? professional.services.first
                          : 'Professional',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      professional.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          professional.isAvailable
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 14,
                          color: professional.isAvailable
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          professional.isAvailable
                              ? 'Available'
                              : 'Not Available',
                          style: TextStyle(
                            fontSize: 12,
                            color: professional.isAvailable
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  image:
                      professional.photoPath != null && professional.isPhotoUrl
                      ? DecorationImage(
                          image: NetworkImage(professional.photoPath!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: professional.photoPath == null
                    ? Icon(Icons.person, size: 40, color: Colors.grey.shade500)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 90,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_selectedProfessional == professional) {
                      _selectedProfessional = null;
                    } else {
                      _selectedProfessional = professional;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Colors.grey.shade200
                      : Colors.blue.shade900,
                  foregroundColor: isSelected
                      ? Colors.grey.shade700
                      : Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isSelected ? 'Selected' : 'Select',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
