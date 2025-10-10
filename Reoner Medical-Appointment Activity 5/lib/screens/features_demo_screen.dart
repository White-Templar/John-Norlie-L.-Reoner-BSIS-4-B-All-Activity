import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/app_navigation.dart';

class FeaturesDemoScreen extends StatefulWidget {
  const FeaturesDemoScreen({super.key});

  @override
  State<FeaturesDemoScreen> createState() => _FeaturesDemoScreenState();
}

class _FeaturesDemoScreenState extends State<FeaturesDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features Demo'),
        centerTitle: true,
      ),
      drawer: AppNavigation.buildDrawer(context, 'features_demo'),
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
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'All Features Implemented',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Complete implementation of all 19 requested features',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Provider Features
              _buildFeatureSection(
                'Provider State Management',
                Icons.code,
                Colors.blue,
                [
                  _FeatureItem(
                    title: 'Shopping Cart with Provider',
                    description: 'Add/remove items, quantity management',
                    status: 'Implemented',
                    route: '/shopping_cart',
                  ),
                  _FeatureItem(
                    title: 'ChangeNotifier with Provider',
                    description: 'UI updates when data changes',
                    status: 'Implemented',
                    route: '/shopping_cart',
                  ),
                  _FeatureItem(
                    title: 'context.read() vs context.watch()',
                    description: 'Demonstrated in Theme Demo',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Theme Switcher with Provider',
                    description: 'Dark/Light mode toggle',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Todo List with Provider',
                    description: 'Task management with state',
                    status: 'Implemented',
                    route: '/todo_list',
                  ),
                ],
              ),
              
              // Media Features
              _buildFeatureSection(
                'Media & Assets',
                Icons.photo_library,
                Colors.green,
                [
                  _FeatureItem(
                    title: 'Image.asset() Display',
                    description: 'Local images from assets',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Image.network() Display',
                    description: 'Images from internet',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Circular Border Images',
                    description: 'BoxDecoration with borders',
                    status: 'Implemented',
                    route: '/profile_card',
                  ),
                  _FeatureItem(
                    title: 'GridView Image Gallery',
                    description: 'Asset images in grid layout',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Video Player (video_player)',
                    description: 'Basic video playback',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Enhanced Video (chewie)',
                    description: 'Video player with controls',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Audio Player (audioplayers)',
                    description: 'Audio clip playback',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                ],
              ),
              
              // UI Features
              _buildFeatureSection(
                'UI & Styling',
                Icons.palette,
                Colors.orange,
                [
                  _FeatureItem(
                    title: 'Dynamic Material Icons',
                    description: 'Color and size changes',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Extended Material Icons',
                    description: 'Rich set of Material Design icons',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Custom Fonts (Roboto, Poppins)',
                    description: 'Added via pubspec.yaml',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Two Different Text Styles',
                    description: 'Multiple font families',
                    status: 'Implemented',
                    route: '/theme_demo',
                  ),
                  _FeatureItem(
                    title: 'Profile Card Design',
                    description: 'Image, icons, styled text',
                    status: 'Implemented',
                    route: '/profile_card',
                  ),
                ],
              ),
              
              // Advanced Features
              _buildFeatureSection(
                'Advanced Features',
                Icons.build,
                Colors.purple,
                [
                  _FeatureItem(
                    title: 'Gallery/Carousel App',
                    description: 'Image carousel from assets',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                  _FeatureItem(
                    title: 'Video + Audio Player App',
                    description: 'Play, pause, stop controls',
                    status: 'Implemented',
                    route: '/media_gallery',
                  ),
                ],
              ),
              
              // Provider State Display
              _buildProviderStateCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavigation.buildBottomNavigationBar(context, 'features_demo'),
    );
  }

  Widget _buildFeatureSection(
    String title,
    IconData icon,
    Color color,
    List<_FeatureItem> features,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: color),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...features.map((feature) => _buildFeatureRow(feature, color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(_FeatureItem feature, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: feature.route != null
            ? () => Navigator.pushNamed(context, feature.route!)
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      feature.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  feature.status,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (feature.route != null)
                const Icon(Icons.arrow_forward_ios, size: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProviderStateCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, size: 30, color: Colors.teal),
                const SizedBox(width: 12),
                const Text(
                  'Live Provider State',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Theme State
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return _buildStateRow(
                  'Theme Mode',
                  themeProvider.isDarkMode ? 'Dark' : 'Light',
                  Icons.palette,
                );
              },
            ),
            
            // Cart State
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return _buildStateRow(
                  'Cart Items',
                  '${cartProvider.itemCount} items (\$${cartProvider.totalAmount.toStringAsFixed(2)})',
                  Icons.shopping_cart,
                );
              },
            ),
            
            // Todo State
            Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return _buildStateRow(
                  'Todo Tasks',
                  '${todoProvider.totalTodos} total (${todoProvider.pendingCount} pending)',
                  Icons.task_alt,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateRow(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final String description;
  final String status;
  final String? route;

  _FeatureItem({
    required this.title,
    required this.description,
    required this.status,
    this.route,
  });
}
