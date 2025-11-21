import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_project/models/leaders.dart';
import 'package:internship_project/provider/add_leaders.dart';


class AddLeadScreen extends ConsumerStatefulWidget {
  const AddLeadScreen({super.key});

  @override
  ConsumerState<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends ConsumerState<AddLeadScreen> {
  var newLeadName = '';
  var newLeadContact = '';
  var notes = '';
  var formkey = GlobalKey<FormState>();
  var isChosen = 'email';

  @override
  Widget build(BuildContext context) {

    void saveForm() {
      final isValid = formkey.currentState?.validate() ?? false;
      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fix the errors in the form.')),
        );
        return;
      }

      formkey.currentState!.save();

      if (newLeadContact.isEmpty || newLeadName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please provide required fields.')),
        );
        return;
      }

      final newLead = Leaders(
        name: newLeadName,
        phone: isChosen == 'phone' ? newLeadContact : null,
        email: isChosen == 'email' ? newLeadContact : null,
        notes: notes,
      );

      // ignore: avoid_print
      print('Lead Name: $newLeadName');
      // ignore: avoid_print
      print('Contact Info: $newLeadContact');
      // ignore: avoid_print
      print('Notes: $notes');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Lead saved successfully.')));

      ref.read(leadersChangeNotifierProvider).addLeader(newLead);
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Lead')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Lead Name',
                  hintText: '(Required)',
                  hintStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSaved: (newValue) => newLeadName = newValue!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a lead name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(value: 'email', child: Text('Email')),
                  DropdownMenuItem(value: 'phone', child: Text('Phone')),
                ],
                // ignore: deprecated_member_use
                value: isChosen,
                onChanged: (value) {
                  setState(() {
                    isChosen = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Preferred Contact Method',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 10),

              if (isChosen == 'email')
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: '(Required)',
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onSaved: (newValue) => newLeadContact = newValue!.trim(),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!v.contains('@')) {
                      return 'Please enter a valid email address';
                    }

                    final existing = ref
                        .read(leadersChangeNotifierProvider)
                        .leaders;
                    final lower = v.toLowerCase();
                    final exists = existing.any(
                      (l) => l.email != null && l.email!.toLowerCase() == lower,
                    );
                    if (exists) {
                      return 'An account with this email already exists';
                    }

                    return null;
                  },
                ),
              if (isChosen == 'phone')
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '(Required)',
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.phone,

                  onSaved: (newValue) => newLeadContact = newValue!.trim(),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Please enter a phone number';
                    }

                    String digits(String s) => s.replaceAll(RegExp(r'\D'), '');
                    final inputDigits = digits(v);

                    final existing = ref
                        .read(leadersChangeNotifierProvider)
                        .leaders;
                    final exists = existing.any((l) {
                      if (l.phone == null) return false;
                      return digits(l.phone!) == inputDigits;
                    });
                    if (exists) {
                      return 'An account with this phone number already exists';
                    }

                    return null;
                  },
                ),
              SizedBox(height: 10),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Notes',
                  //reducing the size of the hint text
                  hintText: '(Optional)',
                  hintStyle: TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onSaved: (newValue) => notes = newValue!,
                validator: (value) {
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: saveForm, child: Text('Save Lead')),
            ],
          ),
        ),
      ),
    );
  }
}
