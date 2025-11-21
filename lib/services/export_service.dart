import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/leaders.dart';

class ExportService {
  static Future<String> _basePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<String> exportJson(List<Leaders> leads) async {
    final base = await _basePath();
    final safe = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File('$base/leads_export_$safe.json');
    final list = leads.map((l) => l.toMap()).toList();
    await file.writeAsString(jsonEncode(list));
    return file.path;
  }

  static Future<String> exportCsv(List<Leaders> leads) async {
    final base = await _basePath();
    final safe = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File('$base/leads_export_$safe.csv');
    final sb = StringBuffer();
    sb.writeln('id,name,phone,email,status,notes');
    for (final l in leads) {
      String esc(String? s) => s == null ? '' : '"${s.replaceAll('"', '""')}"';
      sb.writeln(
        '${l.id ?? ''},${esc(l.name)},${esc(l.phone)},${esc(l.email)},${esc(l.status.label)},${esc(l.notes)}',
      );
    }
    await file.writeAsString(sb.toString());
    return file.path;
  }

  static Future<String> exportText(List<Leaders> leads) async {
    final base = await _basePath();
    final safe = DateTime.now().toIso8601String().replaceAll(':', '-');
    final file = File('$base/leads_export_$safe.txt');
    final sb = StringBuffer();
    for (final l in leads) {
      sb.writeln('Name: ${l.name ?? ''}');
      sb.writeln('Phone: ${l.phone ?? ''}');
      sb.writeln('Email: ${l.email ?? ''}');
      sb.writeln('Status: ${l.status.label}');
      sb.writeln('Notes: ${l.notes ?? ''}');
      sb.writeln('-----');
    }
    await file.writeAsString(sb.toString());
    return file.path;
  }
}
