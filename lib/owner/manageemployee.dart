import 'package:flutter/material.dart';



class Employee {
  final String role;
  final String name;
  final String availability;

  Employee({
    required this.role,
    required this.name,
    required this.availability,
  });
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
      Employee(
        role: 'Barber',
        name: 'Ethan Carter',
        availability: 'Service Availability - Male',
      ),
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
      Employee(
        role: 'Barber',
        name: 'Ethan Carter',
        availability: 'Service Availability - Male',
      ),
      Employee(
        role: 'Nail Technician',
        name: 'Olivia Harper',
        availability: 'Service Availability - Both',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Manage Employees',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: employees.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        itemBuilder: (context, index) {
          return EmployeeCard(
            employee: employees[index],
            onEdit: () {},
            onDelete: () {},
          );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.role,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employee.availability,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ActionButton(
                      label: 'Edit',
                      onPressed: onEdit,
                    ),
                    const SizedBox(width: 12),
                    ActionButton(
                      label: 'Delete',
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: Colors.grey.shade100,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}