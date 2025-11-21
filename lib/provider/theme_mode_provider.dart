import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Holds the current [ThemeMode] for the app.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
