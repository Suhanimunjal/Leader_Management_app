//make a provider for Leaders

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:internship_project/models/leaders.dart';
import 'package:internship_project/repository/leader_repo.dart';

class LeadersProvider with ChangeNotifier {
  final List<Leaders> _leaders = [];
  final LeaderRepository _repo;

  LeadersProvider([LeaderRepository? repo])
    : _repo = repo ?? LeaderRepository() {
    _loadFromDb();
  }

  List<Leaders> get leaders => List.unmodifiable(_leaders);

  void addLeader(Leaders leader) {
    _createAndAdd(leader);
  }

  Future<void> _createAndAdd(Leaders leader) async {
    final id = await _repo.insert(leader);
    leader.id = id;
    _leaders.insert(0, leader);
    notifyListeners();
  }

  void removeLeader(Leaders leader) {
    if (leader.id != null) {
      _repo.delete(leader.id!).then((_) {
        _leaders.removeWhere((l) => l.id == leader.id);
        notifyListeners();
      });
    } else {
      _leaders.remove(leader);
      notifyListeners();
    }
  }

  /// Replace an existing leader instance with an updated one.
  void updateLeader(Leaders oldLeader, Leaders updatedLeader) {
    final idx = _leaders.indexWhere((l) => l.id == oldLeader.id);
    if (idx >= 0) {
      updatedLeader.id = oldLeader.id;
      _leaders[idx] = updatedLeader;
      _repo.update(updatedLeader);
      notifyListeners();
    }
  }

  Future<void> _loadFromDb() async {
    final rows = await _repo.getAll();
    _leaders.clear();
    _leaders.addAll(rows);
    notifyListeners();
  }
}

/// Riverpod provider exposing the ChangeNotifier so UI can read/update leaders.
final leadersChangeNotifierProvider = ChangeNotifierProvider<LeadersProvider>((
  ref,
) {
  return LeadersProvider();
});
