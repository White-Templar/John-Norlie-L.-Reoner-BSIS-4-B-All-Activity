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
            leading: const Icon(Icons.contacts),
            title: const Text('Contacts'),
            selected: currentPage == 'navigation_demo',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'navigation_demo') {
                Navigator.pushNamed(context, '/navigation_demo');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            selected: currentPage == 'profile',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'profile') {
                Navigator.pushNamed(context, '/profile');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            selected: currentPage == 'settings',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'settings') {
                Navigator.pushNamed(context, '/settings');
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Shopping Cart'),
            selected: currentPage == 'shopping_cart',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'shopping_cart') {
                Navigator.pushNamed(context, '/shopping_cart');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.task_alt),
            title: const Text('Todo List'),
            selected: currentPage == 'todo_list',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'todo_list') {
                Navigator.pushNamed(context, '/todo_list');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Media Gallery'),
            selected: currentPage == 'media_gallery',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'media_gallery') {
                Navigator.pushNamed(context, '/media_gallery');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme Demo'),
            selected: currentPage == 'theme_demo',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'theme_demo') {
                Navigator.pushNamed(context, '/theme_demo');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.badge),
            title: const Text('Profile Cards'),
            selected: currentPage == 'profile_card',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'profile_card') {
                Navigator.pushNamed(context, '/profile_card');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Features Demo'),
            selected: currentPage == 'features_demo',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'features_demo') {
                Navigator.pushNamed(context, '/features_demo');
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            selected: currentPage == 'about',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'about') {
                Navigator.pushNamed(context, '/about');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('Contact'),
            selected: currentPage == 'contact',
            onTap: () {
              Navigator.pop(context);
              if (currentPage != 'contact') {
                Navigator.pushNamed(context, '/contact');
              }
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
      case 'navigation_demo':
        currentIndex = 2;
        break;
      case 'profile':
        currentIndex = 3;
        break;
      case 'settings':
        currentIndex = 4;
        break;
      default:
        // For other pages, highlight home
        currentIndex = 0;
        break;
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12,
      unselectedFontSize: 10,
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
            if (currentPage != 'navigation_demo') {
              Navigator.pushNamed(context, '/navigation_demo');
            }
            break;
          case 3:
            if (currentPage != 'profile') {
              Navigator.pushNamed(context, '/profile');
            }
            break;
          case 4:
            if (currentPage != 'settings') {
              Navigator.pushNamed(context, '/settings');
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
          label: 'Medical',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contacts),
          label: 'Contact',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
