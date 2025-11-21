import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:internship_project/services/export_service.dart';
import 'package:internship_project/provider/add_leaders.dart';
import 'package:internship_project/provider/theme_mode_provider.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaders = ref.read(leadersChangeNotifierProvider).leaders;

    Future<void> _exportAndNotify(Future<String> Function() exporter) async {
      try {
        final path = await exporter();
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Exported to: $path')));
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
      }
    }

    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Menu'), automaticallyImplyLeading: false),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Export Leads'),
            onTap: () async {
              // show simple choices
              final choice = await showDialog<String>(
                context: context,
                builder: (ctx) => SimpleDialog(
                  titleTextStyle: Theme.of(context).textTheme.titleLarge,
                  title: const Text(
                    'Export as',
                    style: TextStyle(color: Colors.black),
                  ),
                  children: [
                    SimpleDialogOption(
                      child: const Text(
                        'JSON',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.of(ctx).pop('json'),
                    ),
                    SimpleDialogOption(
                      child: const Text(
                        'CSV',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.of(ctx).pop('csv'),
                    ),
                    SimpleDialogOption(
                      child: const Text(
                        'Text',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.of(ctx).pop('txt'),
                    ),
                    SimpleDialogOption(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(null),
                    ),
                  ],
                ),
              );

              if (choice == null) return;

              if (choice == 'json') {
                await _exportAndNotify(() => ExportService.exportJson(leaders));
              } else if (choice == 'csv') {
                await _exportAndNotify(() => ExportService.exportCsv(leaders));
              } else {
                await _exportAndNotify(() => ExportService.exportText(leaders));
              }
            },
          ),

          // Theme toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Consumer(
              builder: (context, ref2, _) {
                final mode = ref2.watch(themeModeProvider);
                final isDark = mode == ThemeMode.dark;
                return SwitchListTile(
                  title: const Text('Dark mode'),
                  value: isDark,
                  secondary: const Icon(Icons.dark_mode),
                  onChanged: (v) {
                    ref2.read(themeModeProvider.notifier).state = v
                        ? ThemeMode.dark
                        : ThemeMode.light;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
