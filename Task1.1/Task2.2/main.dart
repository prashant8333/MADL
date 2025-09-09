import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DynamicFormExample(),
          ),
        ),
      ),
    );
  }
}

class DynamicFormExample extends StatefulWidget {
  const DynamicFormExample({super.key});

  @override
  State<DynamicFormExample> createState() => _DynamicFormExampleState();
}

class _DynamicFormExampleState extends State<DynamicFormExample> {
  final List<TextEditingController> _controllers = [];

  // Add a new field
  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  // Remove a field at given index
  void _removeTextField(int index) {
    setState(() {
      _controllers[index].dispose(); // clean up controller
      _controllers.removeAt(index);
    });
  }

  // For debugging, print all entered values
  void _submitForm() {
    for (int i = 0; i < _controllers.length; i++) {
      debugPrint("Field ${i + 1}: ${_controllers[i].text}");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Form submitted ✅")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Dynamic Form Fields",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _controllers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: TextFormField(
                  controller: _controllers[index],
                  decoration: InputDecoration(
                    labelText: "Field ${index + 1}",
                    border: const OutlineInputBorder(),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => _removeTextField(index),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _addTextField,
          icon: const Icon(Icons.add),
          label: const Text("Add Field"),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text("Submit"),
        ),
      ],
    );
  }
}
