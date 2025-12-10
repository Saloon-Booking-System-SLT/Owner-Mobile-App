import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class Employee {
  final String role;
  final String name;
  final String availability;

  Employee({required this.role, required this.name, required this.availability});
}

class ManageEmployeesScreen extends StatelessWidget {
  const ManageEmployeesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Employee> employees = [
      Employee(
        role: 'Hair Stylist',
        name: 'Sophia Bennett',
        availability: 'Service Availability - Female',
      ),
      Employee(role: 'Barber', name: 'Ethan Carter', availability: 'Service Availability - Male'),
      Employee(
        role: 'Nail Technician',
        name: 'Olivia Harper',
        availability: 'Service Availability - Both',
      ),
      Employee(
        role: 'Hair Stylist',
        name: 'Sophia Bennett',
        availability: 'Service Availability - Female',
      ),
      Employee(role: 'Barber', name: 'Ethan Carter', availability: 'Service Availability - Male'),
      Employee(
        role: 'Nail Technician',
        name: 'Olivia Harper',
        availability: 'Service Availability - Both',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.black, size: 26),
          ),
        ),
        titleSpacing: 0,
        title: const Text(
          'Manage Employees',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: employees.length,
        separatorBuilder: (context, index) => const SizedBox(height: 0),
        itemBuilder: (context, index) {
          return EmployeeCard(employee: employees[index], onEdit: () {}, onDelete: () {});
        },
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeCard({
    Key? key,
    required this.employee,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF0F4FF)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE1E8F5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.dashboardText,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employee.availability,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.dashboardText,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    ActionButton(label: 'Edit', onPressed: onEdit),
                    const SizedBox(width: 12),
                    ActionButton(label: 'Delete', onPressed: onDelete),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE1E8F5), width: 2),
            ),
            child: Icon(Icons.person_outline, color: Colors.grey[600], size: 30),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDelete = label == 'Delete';
    return Material(
      color: isDelete ? AppColors.statusRed.withOpacity(0.1) : const Color(0xFFE8F2FF),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isDelete
                      ? AppColors.statusRed.withOpacity(0.3)
                      : const Color(0xFF0D5EAC).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isDelete ? AppColors.statusRed : const Color(0xFF0D5EAC),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}
