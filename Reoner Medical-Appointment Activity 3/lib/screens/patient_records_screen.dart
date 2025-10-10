import 'package:flutter/material.dart';

class PatientRecord {
  final String id;
  final String name;
  final String age;
  final String gender;
  final String bloodType;
  final String phone;
  final String email;
  final String address;
  final String emergencyContact;
  final String medicalHistory;
  final DateTime createdAt;

  PatientRecord({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.phone,
    required this.email,
    required this.address,
    required this.emergencyContact,
    required this.medicalHistory,
    required this.createdAt,
  });
}

class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({super.key});

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _medicalHistoryController = TextEditingController();
  
  String _selectedGender = 'Male';
  String _selectedBloodType = 'A+';
  
  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  
  List<PatientRecord> _patientRecords = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _emergencyContactController.dispose();
    _medicalHistoryController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1));

      final newRecord = PatientRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        age: _ageController.text,
        gender: _selectedGender,
        bloodType: _selectedBloodType,
        phone: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        emergencyContact: _emergencyContactController.text,
        medicalHistory: _medicalHistoryController.text,
        createdAt: DateTime.now(),
      );

      setState(() {
        _patientRecords.insert(0, newRecord);
        _isLoading = false;
      });

      _clearForm();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Patient record for ${newRecord.name} saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _clearForm() {
    _nameController.clear();
    _ageController.clear();
    _phoneController.clear();
    _emailController.clear();
    _addressController.clear();
    _emergencyContactController.clear();
    _medicalHistoryController.clear();
    setState(() {
      _selectedGender = 'Male';
      _selectedBloodType = 'A+';
    });
  }

  void _deleteRecord(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text('Are you sure you want to delete this patient record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _patientRecords.removeWhere((record) => record.id == id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Patient record deleted'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showRecordDetails(PatientRecord record) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.person, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Expanded(child: Text(record.name, overflow: TextOverflow.ellipsis)),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Age', '${record.age} years'),
                _buildDetailRow('Gender', record.gender),
                _buildDetailRow('Blood Type', record.bloodType),
                _buildDetailRow('Phone', record.phone),
                _buildDetailRow('Email', record.email),
                _buildDetailRow('Address', record.address),
                _buildDetailRow('Emergency Contact', record.emergencyContact),
                if (record.medicalHistory.isNotEmpty)
                  _buildDetailRow('Medical History', record.medicalHistory),
                _buildDetailRow('Created', _formatDateTime(record.createdAt)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Records'),
        centerTitle: true,
        actions: [
          if (_patientRecords.isNotEmpty)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Clear All Records'),
                      content: Text('Are you sure you want to delete all ${_patientRecords.length} patient records?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _patientRecords.clear();
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All records cleared'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          child: const Text('Delete All'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear All Records',
            ),
        ],
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
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_shared,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patient Database',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            'Manage patient records with local data storage',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Form and Records in Tabs
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        // Tab Bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Theme.of(context).primaryColor,
                            tabs: [
                              Tab(
                                icon: const Icon(Icons.person_add),
                                text: 'Add Patient',
                              ),
                              Tab(
                                icon: const Icon(Icons.list_alt),
                                text: 'Records (${_patientRecords.length})',
                              ),
                            ],
                          ),
                        ),
                        
                        // Tab Views
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TabBarView(
                              children: [
                                // Add Patient Tab
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Form(
                                    key: _formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          // Name and Age Row
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: TextFormField(
                                                  controller: _nameController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Full Name',
                                                    prefixIcon: const Icon(Icons.person),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _ageController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Age',
                                                    prefixIcon: const Icon(Icons.cake),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          
                                          // Gender and Blood Type Row
                                          Row(
                                            children: [
                                              Expanded(
                                                child: DropdownButtonFormField<String>(
                                                  value: _selectedGender,
                                                  decoration: InputDecoration(
                                                    labelText: 'Gender',
                                                    prefixIcon: const Icon(Icons.wc),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  items: _genders.map((gender) {
                                                    return DropdownMenuItem<String>(
                                                      value: gender,
                                                      child: Text(gender),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      _selectedGender = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: DropdownButtonFormField<String>(
                                                  value: _selectedBloodType,
                                                  decoration: InputDecoration(
                                                    labelText: 'Blood Type',
                                                    prefixIcon: const Icon(Icons.bloodtype),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  items: _bloodTypes.map((bloodType) {
                                                    return DropdownMenuItem<String>(
                                                      value: bloodType,
                                                      child: Text(bloodType),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      _selectedBloodType = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          
                                          // Phone and Email Row
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _phoneController,
                                                  keyboardType: TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    labelText: 'Phone',
                                                    prefixIcon: const Icon(Icons.phone),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _emailController,
                                                  keyboardType: TextInputType.emailAddress,
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    prefixIcon: const Icon(Icons.email),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Required';
                                                    }
                                                    if (!value.contains('@')) {
                                                      return 'Invalid email';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          
                                          // Address Field
                                          TextFormField(
                                            controller: _addressController,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              labelText: 'Address',
                                              prefixIcon: const Icon(Icons.home),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter address';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          
                                          // Emergency Contact
                                          TextFormField(
                                            controller: _emergencyContactController,
                                            decoration: InputDecoration(
                                              labelText: 'Emergency Contact',
                                              prefixIcon: const Icon(Icons.emergency),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Required';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 16),
                                          
                                          // Medical History
                                          TextFormField(
                                            controller: _medicalHistoryController,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              labelText: 'Medical History (Optional)',
                                              hintText: 'Previous conditions, allergies, medications...',
                                              prefixIcon: const Icon(Icons.medical_information),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          
                                          // Submit and Clear Buttons
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: _isLoading ? null : _submitForm,
                                                  style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: _isLoading
                                                      ? const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                          ),
                                                        )
                                                      : const Text(
                                                          'Save Record',
                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: _clearForm,
                                                  style: OutlinedButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Clear Form',
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                                
                                // Records List Tab
                                _patientRecords.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.folder_open,
                                              size: 64,
                                              color: Colors.grey[400],
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              'No patient records yet',
                                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Add a patient record to see it here',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        padding: const EdgeInsets.all(16),
                                        itemCount: _patientRecords.length,
                                        itemBuilder: (context, index) {
                                          final record = _patientRecords[index];
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.grey[200]!),
                                            ),
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.all(16),
                                              leading: CircleAvatar(
                                                backgroundColor: Theme.of(context).primaryColor,
                                                child: Text(
                                                  record.name.substring(0, 1).toUpperCase(),
                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              title: Text(
                                                record.name,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '${record.age} years • ${record.gender} • ${record.bloodType}',
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Phone: ${record.phone}',
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Added: ${_formatDateTime(record.createdAt)}',
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              trailing: PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.visibility, color: Colors.blue),
                                                        SizedBox(width: 8),
                                                        Text('View Details'),
                                                      ],
                                                    ),
                                                    onTap: () => _showRecordDetails(record),
                                                  ),
                                                  PopupMenuItem(
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.delete, color: Colors.red),
                                                        SizedBox(width: 8),
                                                        Text('Delete'),
                                                      ],
                                                    ),
                                                    onTap: () => _deleteRecord(record.id),
                                                  ),
                                                ],
                                              ),
                                              isThreeLine: true,
                                              onTap: () => _showRecordDetails(record),
                                            ),
                                          );
                                        },
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
