import 'package:flutter/material.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {
  final Future<bool> Function(User user) onRegister;
  final List<String> courses;
  final VoidCallback onBack;
  const RegisterScreen({super.key, required this.onRegister, required this.courses, required this.onBack});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedRole = 'admin';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  String? selectedCourse;

  @override
  void initState() {
    super.initState();
    if (widget.courses.isNotEmpty) {
      selectedCourse = widget.courses.first;
    }
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: selectedRole,
        phone: phoneController.text.trim(),
        course: selectedRole == 'student' ? selectedCourse : null,
        year: selectedRole == 'student' ? yearController.text.trim() : null,
      );
      bool success = await widget.onRegister(user);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already registered.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Register', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: const Text('Admin'),
                        selected: selectedRole == 'admin',
                        onSelected: (v) => setState(() => selectedRole = 'admin'),
                        selectedColor: const Color(0xFF6D9EEB),
                        labelStyle: TextStyle(color: selectedRole == 'admin' ? Colors.white : Colors.black),
                      ),
                      const SizedBox(width: 16),
                      ChoiceChip(
                        label: const Text('Student'),
                        selected: selectedRole == 'student',
                        onSelected: (v) => setState(() => selectedRole = 'student'),
                        selectedColor: const Color(0xFF6D9EEB),
                        labelStyle: TextStyle(color: selectedRole == 'student' ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Full Name',
                            filled: true,
                            fillColor: Color(0xFFF5F6FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Color(0xFFF5F6FA),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Enter phone' : null,
                        ),
                        const SizedBox(height: 16),
                        if (selectedRole == 'student') ...[
                          DropdownButtonFormField<String>(
                            value: selectedCourse,
                            items: widget.courses.map((course) {
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
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Select a course' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: yearController,
                            decoration: const InputDecoration(
                              hintText: 'Year of Study',
                              filled: true,
                              fillColor: Color(0xFFF5F6FA),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Enter year' : null,
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Color(0xFFF5F6FA),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Enter password' : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6D9EEB),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            onPressed: _register,
                            child: const Text('Register', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            onPressed: widget.onBack,
                            child: const Text('Back to Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 