import 'package:flutter/material.dart';

class AppNavigation {
  static Widget buildDrawer(BuildContext context, String currentPage) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.local_hospital,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'MediCare',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Medical Appointment System',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: currentPage == 'home',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'home') {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.medical_services),
            title: const Text('Appointments & Records'),
            selected: currentPage == 'appointment',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'appointment') {
                Navigator.pushNamed(context, '/appointment');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login & Roles'),
            selected: currentPage == 'login',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'login') {
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Registration'),
            selected: currentPage == 'registration',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'registration') {
                Navigator.pushNamed(context, '/registration');
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help documentation coming soon!')),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget buildBottomNavigationBar(BuildContext context, String currentPage) {
    int currentIndex = 0;
    switch (currentPage) {
      case 'home':
        currentIndex = 0;
        break;
      case 'appointment':
        currentIndex = 1;
        break;
      case 'login':
        currentIndex = 2;
        break;
      case 'registration':
        currentIndex = 3;
        break;
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            if (currentPage != 'home') {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
            break;
          case 1:
            if (currentPage != 'appointment') {
              Navigator.pushNamed(context, '/appointment');
            }
            break;
          case 2:
            if (currentPage != 'login') {
              Navigator.pushNamed(context, '/login');
            }
            break;
          case 3:
            if (currentPage != 'registration') {
              Navigator.pushNamed(context, '/registration');
            }
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Register',
        ),
      ],
    );
  }
}
