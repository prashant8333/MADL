import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Step Form Demo',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _currentStep = 1; // move to step 2
      });
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
    );
  }

  // Step 1: Email + Password
  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Step 1: Account Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: "Email"),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return "Email is required";
            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (!emailRegex.hasMatch(value)) return "Enter a valid email";
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) return "Password is required";
            if (value.length < 6) return "Password must be at least 6 characters";
            return null;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _nextStep,
          child: const Text("Next"),
        ),
      ],
    );
  }

  // Step 2: Name + Phone
  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Step 2: Personal Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: "Name"),
          validator: (value) {
            if (value == null || value.isEmpty) return "Name is required";
            return null;
          },
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: "Phone Number"),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) return "Phone number is required";
            if (value.length < 10) return "Enter a valid phone number";
            return null;
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
