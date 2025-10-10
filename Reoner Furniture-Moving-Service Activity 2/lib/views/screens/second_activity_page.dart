import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/service.dart';

class SecondActivityPage extends StatefulWidget {
  final bool cupertino;
  const SecondActivityPage({super.key, this.cupertino = false});

  @override
  State<SecondActivityPage> createState() => _SecondActivityPageState();
}

class ServiceCategory {
  final String name;
  final IconData icon;
  final String description;

  const ServiceCategory({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class _SecondActivityPageState extends State<SecondActivityPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<MovingServiceItem> _selectedServices = [];

  final List<ServiceCategory> _categories = const [
    ServiceCategory(
      name: 'Residential',
      icon: Icons.home,
      description: 'Home moving services',
    ),
    ServiceCategory(
      name: 'Commercial',
      icon: Icons.business,
      description: 'Office relocation',
    ),
    ServiceCategory(
      name: 'Storage',
      icon: Icons.inventory_2,
      description: 'Secure storage solutions',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final list = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 1. Row with equal spacing
        _sectionTitle('Service Types'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _categories
              .map((category) => Column(
                    children: [
                      Icon(category.icon),
                      Text(category.name),
                    ],
                  ))
              .toList(),
        ),
        const SizedBox(height: 24),

        // Available Services with Wrap
        _sectionTitle('Available Services'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: demoServices
              .map((service) => _buildServiceCard(service))
              .toList(),
        ),
        const SizedBox(height: 24),

        // 2. Centered Column with buttons
        _sectionTitle('Quick Actions'),
        SizedBox(
          height: 120,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calculate),
                  label: const Text('Get Quote'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.support_agent),
                  label: const Text('Contact Support'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 3. Container styling + Moving Details Form
        _sectionTitle('Moving Details'),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pickup Address',
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter pickup address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Delivery Address',
                    icon: Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter delivery address';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 4. Profile cards layout
        _sectionTitle('Moving Specialist'),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.brown,
                  child:
                      Icon(Icons.local_shipping, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Professional Moving Team',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text('Available 24/7'),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(Icons.star,
                              size: 16, color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 5. Expanded layout for schedule
        _sectionTitle('Schedule Moving'),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: const Text('Date'),
                  subtitle: Text(
                    '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: const Text('Time'),
                  subtitle: Text(_selectedTime.format(context)),
                  trailing: const Icon(Icons.access_time),
                  onTap: () => _selectTime(context),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // 6. Navigation bar with process steps
        _sectionTitle('Moving Process'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Process steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      Icon(Icons.inventory_2),
                      Text('Pack'),
                    ],
                  ),
                  Icon(Icons.arrow_forward),
                  Column(
                    children: [
                      Icon(Icons.local_shipping),
                      Text('Move'),
                    ],
                  ),
                  Icon(Icons.arrow_forward),
                  Column(
                    children: [
                      Icon(Icons.home),
                      Text('Unpack'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 7. Stack layout with image and FAB
        _sectionTitle('Premium Services'),
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.brown.shade800.withOpacity(0.7),
                          Colors.brown.shade600.withOpacity(0.5),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 40, color: Colors.white),
                          Text(
                            'Premium Moving Package',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  backgroundColor: Colors.brown,
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 8. Flexible in Column
        _sectionTitle('Service Coverage'),
        SizedBox(
          height: 150,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade100,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: const Center(child: Text('Local Moving')),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.brown.shade200,
                    borderRadius:
                        const BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: const Center(child: Text('Interstate Moving')),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 9. Chat bubble
        _sectionTitle('Customer Reviews'),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Text(
              '⭐️⭐️⭐️⭐️⭐️ Excellent service! The team was professional and careful with our furniture.',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // 10. Grid-like layout and Price Estimation
        _sectionTitle('Price Estimation'),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildPriceCard(
                    title: 'Selected Services',
                    content: '${_selectedServices.length} items',
                    icon: Icons.list_alt,
                  ),
                ),
                Expanded(
                  child: _buildPriceCard(
                    title: 'Estimated Hours',
                    content: '4-6 hours',
                    icon: Icons.timer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildPriceCard(
                    title: 'Base Rate',
                    content: '\$150/hour',
                    icon: Icons.attach_money,
                  ),
                ),
                Expanded(
                  child: _buildPriceCard(
                    title: 'Total Estimate',
                    content: '\$600-900',
                    icon: Icons.calculate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Booking submitted!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Book Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );

    if (widget.cupertino) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.brown.shade100,
                child: const Text(
                  'JR',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Norlie Reoner',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Verified Customer',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
        child: list,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.brown.shade100,
              child: const Text(
                'JR',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'John Norlie Reoner',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Verified Customer',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(Icons.verified, size: 14, color: Colors.blue),
          ],
        ),
      ),
      body: list,
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildServiceCard(MovingServiceItem service) {
    final isSelected = _selectedServices.contains(service);

    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected ? Colors.brown.shade100 : null,
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedServices.remove(service);
            } else {
              _selectedServices.add(service);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                service.iconEmoji,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 8),
              Text(
                service.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                service.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Colors.brown),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
