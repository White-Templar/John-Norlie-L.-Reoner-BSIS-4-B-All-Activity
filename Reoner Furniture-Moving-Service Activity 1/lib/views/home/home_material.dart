import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../models/service.dart';
import '../../services/fake_services.dart';
import '../../widgets/primary_button.dart';
import '../screens/counter_page.dart';
import '../screens/hello_page.dart';

class HomeMaterial extends StatefulWidget {
  final VoidCallback onTogglePlatform;
  const HomeMaterial({super.key, required this.onTogglePlatform});

  @override
  State<HomeMaterial> createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  int currentIndex = 0;
  final _repo = const MovingServicesRepository();

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeDashboard(services: _repo.fetchAll()),
      const HelloPage(),
      const CounterPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Furniture Moving Service'),
        actions: [
          IconButton(
            onPressed: widget.onTogglePlatform,
            tooltip: 'Switch to Cupertino',
            icon: const Icon(Icons.phone_iphone),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () => setState(() => currentIndex = 0),
            ),
            ListTile(
              leading: const Icon(Icons.hail),
              title: const Text('Hello'),
              onTap: () => setState(() => currentIndex = 1),
            ),
            ListTile(
              leading: const Icon(Icons.exposure_plus_1),
              title: const Text('Counter'),
              onTap: () => setState(() => currentIndex = 2),
            ),
          ],
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.hail), label: 'Hello'),
          BottomNavigationBarItem(icon: Icon(Icons.exposure_plus_1), label: 'Counter'),
        ],
      ),
    );
  }
}
class _HomeDashboard extends StatelessWidget {
  final List<MovingServiceItem> services;
  const _HomeDashboard({required this.services});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.brown.shade700,
                Colors.brown.shade400,
              ]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stress-Free Furniture Moving',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We pack, load, transport and unpack.\nBook in minutes!',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                PrimaryButton(label: 'Get a Quote', onPressed: () {}),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Our Services',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: services.length,
              itemBuilder: (context, index) {
                final s = services[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.iconEmoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 8),
                        Text(s.name, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(s.description),
                        const SizedBox(height: 8),
                        PrimaryButton(label: 'Book', onPressed: () {}),
                      ],
                    ),
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

