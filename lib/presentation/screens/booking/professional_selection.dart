// professional_selection.dart
import 'package:flutter/material.dart';

import 'appoinment_summary.dart';
import 'datetime_selection.dart';

// Professional Selection Screen
class ProfessionalSelectionScreen extends StatefulWidget {
  final String customerName;
  final String customerPhoneNumber;
  final String customerEmail;
  final List<ServiceItem> selectedServices;

  const ProfessionalSelectionScreen({
    super.key,
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
  String _selectedTab = 'Available Today';
  Professional? _selectedProfessional;

  final List<Professional> _professionals = [
    Professional(
      name: 'Sophia Bennett',
      availability: 'Available Today',
      isAvailableToday: true,
      jobTitle: 'Hair Stylist',
      rating: 4.8,
    ),
    Professional(
      name: 'Ethan Carter',
      availability: 'Available Today',
      isAvailableToday: true,
      jobTitle: 'Barber',
      rating: 4.9,
    ),
    Professional(
      name: 'Olivia Harper',
      availability: 'Available Today',
      isAvailableToday: true,
      jobTitle: 'Nail Technician',
      rating: 4.7,
    ),
    Professional(
      name: 'Liam Foster',
      availability: 'Available Today',
      isAvailableToday: false,
      jobTitle: 'Esthetician',
      rating: 4.6,
    ),
  ];

  List<Professional> get filteredProfessionals {
    if (_selectedTab == 'Available Today') {
      return _professionals.where((p) => p.isAvailableToday).toList();
    } else if (_selectedTab == 'Top Rated') {
      final sorted = List<Professional>.from(_professionals);
      sorted.sort((a, b) => b.rating.compareTo(a.rating));
      return sorted;
    }
    return _professionals;
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
          'Book An Appointment',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Column(
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredProfessionals.length,
              itemBuilder: (context, index) {
                return _buildProfessionalCard(filteredProfessionals[index]);
              },
            ),
          ),
          if (_selectedProfessional != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                          '| ${_selectedProfessional!.jobTitle}',
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
                            customerName: widget.customerName,
                            customerPhoneNumber: widget.customerPhoneNumber,
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
                          horizontal: 20, vertical: 10),
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
            _selectedProfessional = null; // Reset selection on tab change
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.shade900 : Colors.grey.shade50,
          foregroundColor: isSelected ? Colors.white : Colors.grey.shade700,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical:8),
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

  Widget _buildProfessionalCard(Professional professional) {
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
                      professional.jobTitle,
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
                          Icons.star,
                          size: 14,
                          color: Colors.amber.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${professional.rating}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          professional.availability,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade800,
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
                ),
                child: Icon(
                  Icons.image_outlined,
                  size: 80,
                  color: Colors.grey.shade500,
                ),
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
                  backgroundColor:
                  isSelected ? Colors.grey.shade200 : Colors.blue.shade900,
                  foregroundColor:
                  isSelected ? Colors.grey.shade700 : Colors.white,
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