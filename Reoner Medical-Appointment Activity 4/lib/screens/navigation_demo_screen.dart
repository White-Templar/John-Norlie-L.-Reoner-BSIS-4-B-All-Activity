import 'package:flutter/material.dart';
import '../widgets/app_navigation.dart';

class NavigationDemoScreen extends StatefulWidget {
  const NavigationDemoScreen({super.key});

  @override
  State<NavigationDemoScreen> createState() => _NavigationDemoScreenState();
}

class _NavigationDemoScreenState extends State<NavigationDemoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _appBarTabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _appBarTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _appBarTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        centerTitle: true,
        bottom: TabBar(
          controller: _appBarTabController,
          tabs: const [
            Tab(icon: Icon(Icons.chat), text: 'Chats'),
            Tab(icon: Icon(Icons.circle), text: 'Status'),
            Tab(icon: Icon(Icons.call), text: 'Calls'),
          ],
        ),
      ),
      drawer: AppNavigation.buildDrawer(context, 'navigation_demo'),
      body: TabBarView(
        controller: _appBarTabController,
        children: [
          _buildChatsTab(),
          _buildStatusTab(),
          _buildCallsTab(),
        ],
      ),
      bottomNavigationBar: AppNavigation.buildBottomNavigationBar(context, 'navigation_demo'),
    );
  }

  Widget _buildChatsTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // TabBar with TabBarView Demo
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    tabs: const [
                      Tab(icon: Icon(Icons.message), text: 'Messages'),
                      Tab(icon: Icon(Icons.group), text: 'Groups'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMessagesView(),
                      _buildGroupsView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation Examples
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Navigation Examples',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _NavigationButton(
                                title: 'Push Navigation',
                                subtitle: 'Navigate with back button',
                                icon: Icons.arrow_forward,
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const _DemoScreen(
                                      title: 'Pushed Screen',
                                      description: 'This screen was pushed. You can go back.',
                                    ),
                                  ),
                                ),
                              ),
                              _NavigationButton(
                                title: 'Push Replacement',
                                subtitle: 'Replace current screen (no back)',
                                icon: Icons.swap_horiz,
                                onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const _DemoScreen(
                                      title: 'Replacement Screen',
                                      description: 'This screen replaced the previous one. No back button.',
                                    ),
                                  ),
                                ),
                              ),
                              _NavigationButton(
                                title: 'Named Route - About',
                                subtitle: 'Navigate using named routes',
                                icon: Icons.info,
                                onPressed: () => Navigator.pushNamed(context, '/about'),
                              ),
                              _NavigationButton(
                                title: 'Named Route - Contact',
                                subtitle: 'Another named route example',
                                icon: Icons.contact_support,
                                onPressed: () => Navigator.pushNamed(context, '/contact'),
                              ),
                              _NavigationButton(
                                title: 'Pop to Root',
                                subtitle: 'Go back to home screen',
                                icon: Icons.home,
                                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/',
                                  (route) => false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 60,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Status Updates',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Share your status with others',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text('${index + 1}'),
                      ),
                      title: Text('Status Update ${index + 1}'),
                      subtitle: Text('${DateTime.now().subtract(Duration(hours: index)).hour}:00'),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallsTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.call,
                      size: 60,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Call History',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Recent calls and contacts',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  final List<String> contactNames = [
                    'Dr. Sarah Johnson',
                    'Mike Chen',
                    'Emily Rodriguez', 
                    'David Wilson',
                    'Lisa Thompson',
                    'James Parker',
                    'Dr. Robert Kim',
                    'Maria Garcia'
                  ];
                  
                  final isIncoming = index % 2 == 0;
                  final contactName = contactNames[index];
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isIncoming ? Colors.green : Colors.red,
                        child: Icon(
                          isIncoming ? Icons.call_received : Icons.call_made,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(contactName),
                      subtitle: Text('${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().month}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling $contactName')),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessagesView() {
    final List<Map<String, String>> messages = [
      {'name': 'Dr. Sarah Johnson', 'message': 'Your appointment is confirmed for tomorrow at 2 PM', 'time': '12:30'},
      {'name': 'Mike Chen', 'message': 'Thanks for the medical report, everything looks good!', 'time': '11:45'},
      {'name': 'Emily Rodriguez', 'message': 'Can we reschedule our meeting to next week?', 'time': '10:20'},
      {'name': 'David Wilson', 'message': 'The lab results are ready for pickup', 'time': '09:15'},
      {'name': 'Lisa Thompson', 'message': 'Don\'t forget about your checkup on Friday', 'time': 'Yesterday'},
      {'name': 'James Parker', 'message': 'Hope you\'re feeling better after the treatment', 'time': 'Yesterday'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(message['name']![0]),
            ),
            title: Text(message['name']!),
            subtitle: Text(message['message']!),
            trailing: Text(message['time']!),
          );
        },
      ),
    );
  }

  Widget _buildGroupsView() {
    final List<Map<String, dynamic>> groups = [
      {'name': 'Medical Team', 'members': 12, 'time': '2:45 PM'},
      {'name': 'Cardiology Department', 'members': 8, 'time': '1:20 PM'},
      {'name': 'Nursing Staff', 'members': 15, 'time': 'Yesterday'},
      {'name': 'Emergency Response', 'members': 6, 'time': 'Yesterday'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: const Icon(Icons.group, color: Colors.white),
            ),
            title: Text(group['name']),
            subtitle: Text('${group['members']} members'),
            trailing: Text(group['time']),
          );
        },
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onPressed;

  const _NavigationButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

class _DemoScreen extends StatelessWidget {
  final String title;
  final String description;

  const _DemoScreen({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFE9ECEF),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.navigation,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (route) => false,
                          ),
                          icon: const Icon(Icons.home),
                          label: const Text('Home'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
