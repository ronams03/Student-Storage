import 'package:flutter/material.dart';
import 'students_screen.dart';

class AddStudentScreen extends StatefulWidget {
  final List<String> courseChoices;
  const AddStudentScreen({super.key, required this.courseChoices});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String? selectedCourse;

  @override
  void initState() {
    super.initState();
    if (widget.courseChoices.isNotEmpty) {
      selectedCourse = widget.courseChoices.first;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    yearController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && selectedCourse != null) {
      final newStudent = Student(
        nameController.text.trim(),
        selectedCourse!,
        yearController.text.trim(),
        'https://i.imgur.com/BoN9kdC.png', // Placeholder avatar
        DateTime.now().millisecondsSinceEpoch.toString(),
        emailController.text.trim(),
        phoneController.text.trim(),
      );
      Navigator.of(context).pop(newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('Add Student', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Full Name',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCourse,
                items: widget.courseChoices.map((course) {
                  return DropdownMenuItem<String>(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCourse = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Course',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Select a course' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Identification Number',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter ID' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: yearController,
                decoration: const InputDecoration(
                  hintText: 'Year of Study',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter year' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                  filled: true,
                  fillColor: Color(0xFFF5F6FA),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Enter phone' : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6E6F6),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                  onPressed: _submit,
                  child: const Text('Add Student', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}