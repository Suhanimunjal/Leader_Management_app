import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internship_project/screens/add_lead.dart';
import 'package:internship_project/models/leaders.dart';
import 'package:internship_project/provider/add_leaders.dart';
import 'package:internship_project/screens/details_screen.dart';
import 'package:internship_project/widgets/main_drawer.dart';
import 'package:internship_project/widgets/search.dart';
import 'package:internship_project/widgets/filter_screen.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  ConsumerState<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends ConsumerState<StartingScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _query = '';
  String currentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Leaders> _filterLeads(List<Leaders> leaders, String query) {
    // First filter by text query
    List<Leaders> result;
    if (query.isEmpty) {
      result = List<Leaders>.from(leaders);
    } else {
      final q = query.toLowerCase();
      result = leaders.where((l) {
        final name = (l.name ?? '').toLowerCase();
        final phone = (l.phone ?? '').toLowerCase();
        final email = (l.email ?? '').toLowerCase();
        return name.contains(q) || phone.contains(q) || email.contains(q);
      }).toList();
    }

    // Then apply status filter if any
    if (currentFilter != 'All') {
      result = result.where((l) => l.status.label == currentFilter).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final leadersProvider = ref.watch(leadersChangeNotifierProvider);
    final List<Leaders> leaders = leadersProvider.leaders;
    final List<Leaders> filteredLeads = _filterLeads(leaders, _query);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: AppBarSearchTitle(
          isSearching: _isSearching,
          controller: _searchController,
          onChanged: (v) => setState(() => _query = v),
        ),

        actions: [
          // Add button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddLeadScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),

          LeadFilterMenu(
            selectedFilter: currentFilter,
            onFilterSelected: (value) {
              setState(() {
                currentFilter = value;
              });
            },
          ),
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                      _query = '';
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
        ],
      ),

      body: Column(
        children: [
          if (!_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Tap search icon to find leads quickly',
                    style: TextStyle(color: Color.fromARGB(255, 10, 0, 0)),
                  ),
                ],
              ),
            ),

          Expanded(
            child: filteredLeads.isEmpty
                ? Center(
                    child: Text(
                      _query.isEmpty
                          ? 'No leads found.'
                          : 'No results for "$_query"',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredLeads.length,
                    itemBuilder: (context, index) {
                      final leader = filteredLeads[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: ListTile(
                          title: Text(leader.name ?? ''),

                          subtitle: Text(
                            (leader.email != null && leader.email!.isNotEmpty)
                                ? leader.email!
                                : (leader.phone ?? ''),
                          ),
                          trailing: Container(
                            width: 68,
                            height: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: leader.status.color,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              leader.status.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(leader: leader),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
