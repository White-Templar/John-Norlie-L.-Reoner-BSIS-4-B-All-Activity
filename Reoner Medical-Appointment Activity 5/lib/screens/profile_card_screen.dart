import 'package:flutter/material.dart';
import '../widgets/app_navigation.dart';

class ProfileCardScreen extends StatelessWidget {
  const ProfileCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Cards'),
        centerTitle: true,
      ),
      drawer: AppNavigation.buildDrawer(context, 'profile_card'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
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
                child: Row(
                  children: [
                    Icon(
                      Icons.badge,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medical Staff Profiles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Professional profile cards with custom styling'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Profile Cards
              ..._profileData.map((profile) => _ProfileCard(profile: profile)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigation.buildBottomNavigationBar(context, 'profile_card'),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final Map<String, dynamic> profile;

  const _ProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                profile['color'].withOpacity(0.1),
                profile['color'].withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Header
                Row(
                  children: [
                    // Profile Image with Border
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: profile['color'],
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: profile['color'].withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          color: profile['color'].withOpacity(0.1),
                          child: Icon(
                            profile['avatar'],
                            size: 40,
                            color: profile['color'],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    
                    // Profile Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            profile['title'],
                            style: TextStyle(
                              fontSize: 16,
                              color: profile['color'],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            profile['department'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: profile['isOnline'] ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        profile['isOnline'] ? 'Online' : 'Offline',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Contact Info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: profile['color'].withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      _ContactRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: profile['email'],
                        color: profile['color'],
                      ),
                      const SizedBox(height: 12),
                      _ContactRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: profile['phone'],
                        color: profile['color'],
                      ),
                      const SizedBox(height: 12),
                      _ContactRow(
                        icon: Icons.location_on,
                        label: 'Office',
                        value: profile['office'],
                        color: profile['color'],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Specialties
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (profile['specialties'] as List<String>).map((specialty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: profile['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: profile['color'].withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        specialty,
                        style: TextStyle(
                          fontSize: 12,
                          color: profile['color'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Calling ${profile['name']}')),
                          );
                        },
                        icon: const Icon(Icons.call, size: 18),
                        label: const Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: profile['color'],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Messaging ${profile['name']}')),
                          );
                        },
                        icon: const Icon(Icons.message, size: 18),
                        label: const Text('Message'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: profile['color'],
                          side: BorderSide(color: profile['color']),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final List<Map<String, dynamic>> _profileData = [
  {
    'name': 'Dr. Sarah Johnson',
    'title': 'Chief Cardiologist',
    'department': 'Cardiology Department',
    'email': 'sarah.johnson@medicare.com',
    'phone': '+1 (555) 123-4567',
    'office': 'Room 301, Cardiology Wing',
    'avatar': Icons.person,
    'color': Colors.blue,
    'isOnline': true,
    'specialties': ['Heart Surgery', 'Interventional Cardiology', 'Echocardiography'],
  },
  {
    'name': 'Dr. Michael Chen',
    'title': 'Senior Neurologist',
    'department': 'Neurology Department',
    'email': 'michael.chen@medicare.com',
    'phone': '+1 (555) 234-5678',
    'office': 'Room 205, Neurology Wing',
    'avatar': Icons.psychology,
    'color': Colors.green,
    'isOnline': false,
    'specialties': ['Stroke Treatment', 'Epilepsy', 'Movement Disorders'],
  },
  {
    'name': 'Dr. Emily Rodriguez',
    'title': 'Pediatric Specialist',
    'department': 'Pediatrics Department',
    'email': 'emily.rodriguez@medicare.com',
    'phone': '+1 (555) 345-6789',
    'office': 'Room 150, Pediatric Wing',
    'avatar': Icons.child_care,
    'color': Colors.orange,
    'isOnline': true,
    'specialties': ['Child Development', 'Pediatric Emergency', 'Immunizations'],
  },
  {
    'name': 'Dr. Robert Kim',
    'title': 'Orthopedic Surgeon',
    'department': 'Orthopedics Department',
    'email': 'robert.kim@medicare.com',
    'phone': '+1 (555) 456-7890',
    'office': 'Room 401, Surgery Wing',
    'avatar': Icons.healing,
    'color': Colors.purple,
    'isOnline': true,
    'specialties': ['Joint Replacement', 'Sports Medicine', 'Trauma Surgery'],
  },
];
