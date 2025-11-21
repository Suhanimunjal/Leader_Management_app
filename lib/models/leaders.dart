import 'package:flutter/material.dart';

enum Status { New, Contacted, Converted, Lost }

extension StatusColors on Status {
  Color get color {
    switch (this) {
      case Status.New:
        return Colors.blueAccent; // fresh, new aura
      case Status.Contacted:
        return Colors.orangeAccent; // active, warm
      case Status.Converted:
        return Colors.greenAccent; // success, positive energy
      case Status.Lost:
        return Colors.redAccent; // negative, faded
    }
  }

  String get label {
    switch (this) {
      case Status.New:
        return "New";
      case Status.Contacted:
        return "Contacted";
      case Status.Converted:
        return "Converted";
      case Status.Lost:
        return "Lost";
    }
  }
}

class Leaders {
  Leaders({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.status = Status.New,
    this.notes,
  });

  int? id;
  String? name;
  String? phone;
  String? email;
  Status status;
  String? notes;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'status': status.label,
      'notes': notes,
    };
  }

  static Leaders fromMap(Map<String, Object?> map) {
    return Leaders(
      id: map['id'] as int?,
      name: map['name'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      notes: map['notes'] as String?,
      status: _statusFromLabel(map['status'] as String?),
    );
  }

  static Status _statusFromLabel(String? label) {
    switch (label) {
      case 'Contacted':
        return Status.Contacted;
      case 'Converted':
        return Status.Converted;
      case 'Lost':
        return Status.Lost;
      default:
        return Status.New;
    }
  }
}
