import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AppointmentFilters extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const AppointmentFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: _buildFilterTab('All')),
          const SizedBox(width: 8),
          Expanded(child: _buildFilterTab('Completed')),
          const SizedBox(width: 8),
          Expanded(child: _buildFilterTab('Confirmed')),
          const SizedBox(width: 8),
          Expanded(child: _buildFilterTab('Cancel')),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => onFilterChanged(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
            width: 1.5,
          ),
          // boxShadow: isSelected
          //     ? [
          //   // BoxShadow(
          //   //   color: AppColors.primaryBlue.withOpacity(0.4),
          //   //   blurRadius: 12,
          //   //   offset: const Offset(0, 4),
          //   // )
          // ]
          //     : [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.05),
          //     blurRadius: 8,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class ProfessionalDropdown extends StatelessWidget {
  final String selectedProfessional;
  final List<String> professionals;
  final Function(String) onChanged;

  const ProfessionalDropdown({
    super.key,
    required this.selectedProfessional,
    required this.professionals,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedProfessional,
          isExpanded: true,
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryBlue, size: 18),
          ),
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.darkText,
            fontWeight: FontWeight.w600,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: professionals.map((String professional) {
            return DropdownMenuItem<String>(
              value: professional,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.person_outline_rounded,
                        size: 14, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      professional,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}