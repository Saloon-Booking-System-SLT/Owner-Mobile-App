import 'package:flutter/material.dart';

class SalonTypeDropdown extends StatefulWidget {
  final String? selectedSalonType;
  final ValueChanged<String?> onChanged;
  final List<String> salonTypes;

  const SalonTypeDropdown({
    super.key,
    required this.selectedSalonType,
    required this.onChanged,
    required this.salonTypes,
  });

  @override
  State<SalonTypeDropdown> createState() => _SalonTypeDropdownState();
}

class _SalonTypeDropdownState extends State<SalonTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Salon Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedSalonType,
              hint: const Text(
                'Select Salon type Ex: Unisex',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black38,
              ),
              items: widget.salonTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
