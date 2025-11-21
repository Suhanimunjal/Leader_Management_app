import 'package:flutter/material.dart';

class LeadFilterMenu extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const LeadFilterMenu({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list), // ← IconButton + Dropdown
      onSelected: onFilterSelected,
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'All', child: Text('All')),
        const PopupMenuItem(value: 'New', child: Text('New')),
        const PopupMenuItem(value: 'Contacted', child: Text('Contacted')),
        const PopupMenuItem(value: 'Converted', child: Text('Converted')),
        const PopupMenuItem(value: 'Lost', child: Text('Lost')),
      ],
    );
  }
}
