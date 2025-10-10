import 'package:flutter/material.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _reasonController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _appointmentType;
  
  // Text controller demonstration
  String _displayedPatientName = '';
  String _displayedReason = '';
  String _displayedNotes = '';
  
  final List<String> _appointmentTypes = [
    'General Consultation',
    'Follow-up Visit',
    'Emergency',
    'Vaccination',
    'Health Checkup',
    'Specialist Consultation',
    'Lab Tests',
    'Imaging (X-Ray/MRI)',
    'Dental Care',
    'Physical Therapy',
  ];

  @override
  void dispose() {
    _patientNameController.dispose();
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _capturePatientName() {
    setState(() {
      _displayedPatientName = _patientNameController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Patient name captured: ${_patientNameController.text}'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _captureReason() {
    setState(() {
      _displayedReason = _reasonController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reason captured: ${_reasonController.text}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _captureNotes() {
    setState(() {
      _displayedNotes = _notesController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notes captured: ${_notesController.text}'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an appointment date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      if (_selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an appointment time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final appointmentDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text('Appointment Scheduled'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Appointment details:', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text('Patient: ${_patientNameController.text}'),
                  Text('Type: ${_appointmentType ?? "General Consultation"}'),
                  Text('Date: ${_formatDate(_selectedDate!)}'),
                  Text('Time: ${_selectedTime!.format(context)}'),
                  Text('Reason: ${_reasonController.text}'),
                  if (_notesController.text.isNotEmpty)
                    Text('Notes: ${_notesController.text}'),
                  const SizedBox(height: 12),
                  const Text('Captured Information:', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  if (_displayedPatientName.isNotEmpty)
                    Text('Captured Name: $_displayedPatientName'),
                  if (_displayedReason.isNotEmpty)
                    Text('Captured Reason: $_displayedReason'),
                  if (_displayedNotes.isNotEmpty)
                    Text('Captured Notes: $_displayedNotes'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Booking'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Card
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
                        Icons.event_available,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Book Appointment',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Schedule appointments with date & time pickers and text controllers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Form Card
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Appointment Details',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            
                            // Patient Name with Text Controller
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _patientNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Patient Name',
                                      hintText: 'Enter patient full name',
                                      prefixIcon: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter patient name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _capturePatientName,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  child: const Text('Capture'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // Appointment Type Dropdown
                            DropdownButtonFormField<String>(
                              value: _appointmentType,
                              decoration: InputDecoration(
                                labelText: 'Appointment Type',
                                prefixIcon: const Icon(Icons.medical_services),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              hint: const Text('Select appointment type'),
                              items: _appointmentTypes.map((type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _appointmentType = newValue;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            
                            // Date and Time Pickers
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date & Time Selection',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  // Date Picker
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor),
                                      title: Text(_selectedDate == null 
                                        ? 'Select Appointment Date' 
                                        : 'Date: ${_formatDate(_selectedDate!)}'),
                                      subtitle: _selectedDate == null 
                                        ? const Text('Tap to choose date')
                                        : null,
                                      trailing: const Icon(Icons.arrow_forward_ios),
                                      onTap: _selectDate,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  
                                  // Time Picker
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      leading: Icon(Icons.access_time, color: Theme.of(context).primaryColor),
                                      title: Text(_selectedTime == null 
                                        ? 'Select Appointment Time' 
                                        : 'Time: ${_selectedTime!.format(context)}'),
                                      subtitle: _selectedTime == null 
                                        ? const Text('Tap to choose time')
                                        : null,
                                      trailing: const Icon(Icons.arrow_forward_ios),
                                      onTap: _selectTime,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Reason for Visit with Text Controller
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _reasonController,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      labelText: 'Reason for Visit',
                                      hintText: 'Describe symptoms or reason',
                                      prefixIcon: const Icon(Icons.description),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter reason for visit';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _captureReason,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  child: const Text('Capture'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // Additional Notes with Text Controller
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _notesController,
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      labelText: 'Additional Notes (Optional)',
                                      hintText: 'Any additional information',
                                      prefixIcon: const Icon(Icons.note_alt),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _captureNotes,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  child: const Text('Capture'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            // Captured Text Display
                            if (_displayedPatientName.isNotEmpty || _displayedReason.isNotEmpty || _displayedNotes.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green.shade200),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Captured Information',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (_displayedPatientName.isNotEmpty)
                                      Text('Patient Name: $_displayedPatientName'),
                                    if (_displayedReason.isNotEmpty)
                                      Text('Reason: $_displayedReason'),
                                    if (_displayedNotes.isNotEmpty)
                                      Text('Notes: $_displayedNotes'),
                                  ],
                                ),
                              ),
                            
                            const SizedBox(height: 24),
                            
                            // Submit Button
                            ElevatedButton(
                              onPressed: _submitForm,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Schedule Appointment',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
