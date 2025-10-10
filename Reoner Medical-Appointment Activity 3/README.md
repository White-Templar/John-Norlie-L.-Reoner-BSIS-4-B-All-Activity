# Medical Appointment App

A comprehensive Flutter application for managing medical appointments with various form implementations and medical-themed UI design.

## Features

This app demonstrates all 10 requested requirements:

### **Requirement 1: Simple Username Form**
- **Screen**: Username Form
- **Features**: Basic TextFormField with validation for username entry
- **Validation**: Minimum 3 characters required
- **UI**: Medical-themed design with patient registration context

### **Requirements 2-4: Login Form with Validation**
- **Screen**: Login
- **Features**: Email and password fields with submit button
- **Validation**: 
  - Email must contain "@" symbol
  - Password cannot be empty (minimum 6 characters)
  - Uses GlobalKey<FormState> for form management
- **UI**: Professional login interface with loading states

### **Requirement 5: Mixed Input Types**
- **Screen**: Mixed Forms
- **Features**: 
  - TextField (name, notes)
  - Checkbox (insurance, emergency contact)
  - Switch (notifications)
  - Dropdown (blood type)
- **UI**: Organized sections with medical information context

### **Requirement 6: Registration Form**
- **Screen**: Registration
- **Features**: Name, email, password, and confirm password fields
- **Validation**: 
  - Name minimum 2 characters
  - Valid email format with regex
  - Password strength (8+ chars, uppercase, lowercase, number)
  - Password confirmation matching
- **UI**: Step-by-step registration with success dialog

### **Requirement 7: Role Dropdown**
- **Screen**: Role Selection
- **Features**: Comprehensive dropdown for user roles
- **Roles**: Admin, Doctor, Nurse, Receptionist, Patient, Pharmacist, Lab Technician
- **Additional**: Department and shift selection based on role
- **UI**: Role descriptions and contextual form fields

### **Requirement 8: Date & Time Pickers**
- **Screen**: Date & Time
- **Features**: 
  - Date picker for appointments
  - Time picker for scheduling
  - Optional follow-up date picker
  - Appointment type selection
- **UI**: Medical appointment booking interface with validation

### **Requirement 9: Text Controller Demo**
- **Screen**: Text Controller
- **Features**: 
  - Multiple TextFields with individual controllers
  - Capture buttons to display text after pressing
  - Real-time text capture and display
  - Clear functionality
- **UI**: Medical record entry simulation with categorized display

### **Requirement 10: Local Data Storage**
- **Screen**: Data Storage
- **Features**: 
  - Form saves data to local list
  - Displays submitted inputs below form
  - Patient records with full information
  - Delete individual records
  - Clear all records functionality
- **UI**: Patient database interface with record management

## Medical Theme Design

- **Color Scheme**: Professional medical blue (#2E86AB)
- **Icons**: Medical-specific icons (hospital, stethoscope, medication, etc.)
- **Layout**: Card-based design with gradients and shadows
- **Navigation**: Grid-based home screen with categorized features
- **UX**: Consistent medical appointment workflow

## Project Structure

```
lib/
├── main.dart                          # App entry point with medical theme
├── screens/
│   ├── home_screen.dart              # Main navigation with medical design
│   ├── username_form_screen.dart     # Requirement 1: Simple username form
│   ├── login_screen.dart             # Requirements 2-4: Login with validation
│   ├── mixed_form_screen.dart        # Requirement 5: Mixed input types
│   ├── registration_screen.dart      # Requirement 6: Registration form
│   ├── role_dropdown_screen.dart     # Requirement 7: Role dropdown
│   ├── date_time_picker_screen.dart  # Requirement 8: Date & time pickers
│   ├── text_controller_screen.dart   # Requirement 9: Text controller demo
│   └── data_storage_screen.dart      # Requirement 10: Local data storage
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Medical-Appointment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Running on Different platforms

- **Android**: `flutter run`
- **iOS**: `flutter run` (requires macOS and Xcode)
- **Web**: `flutter run -d chrome`
- **Windows**: `flutter run -d windows`

## Key Features Implemented

### Form Validation
- Email format validation with regex
- Password strength requirements
- Required field validation
- Custom validation messages
- Real-time validation feedback

### State Management
- StatefulWidget for dynamic UI updates
- Form state management with GlobalKey
- Local data persistence in memory
- Controller management and disposal

### UI/UX Design
- Material Design 3 components
- Responsive layout design
- Medical-themed color scheme
- Professional healthcare interface
- Accessibility considerations

### Data Handling
- Form data capture and validation
- Local list storage for patient records
- CRUD operations (Create, Read, Delete)
- Data persistence during app session
- Structured data models

## Technical Implementation

### Form Management
- Uses `GlobalKey<FormState>` for form validation
- Individual `TextEditingController` for each input field
- Proper controller disposal to prevent memory leaks
- Validation functions for different input types

### Medical Context
- Patient registration workflows
- Appointment scheduling interface
- Medical record management
- Healthcare role assignments
- Clinical data entry forms

### Error Handling
- Form validation with user-friendly messages
- Input sanitization and validation
- Loading states for async operations
- Success/error feedback with SnackBars

## Future Enhancements

- Database integration (SQLite/Firebase)
- User authentication and sessions
- Appointment notifications
- Medical record encryption
- Multi-language support
- Offline data synchronization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is created for educational purposes demonstrating Flutter form implementations in a medical appointment context.

## Getting Started: FlutLab - Flutter Online IDE

- How to use FlutLab? Please, view our https://flutlab.io/docs
- Join the discussion and conversation on https://flutlab.io/residents
