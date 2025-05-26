import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final Future<bool> Function(String role, String email, String password) onLogin;
  final VoidCallback onRegister;
  const LoginScreen({super.key, required this.onLogin, required this.onRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'admin';
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 24).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await widget.onLogin(selectedRole, emailController.text.trim(), passwordController.text.trim());
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials or role.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _animation.value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF6D9EEB), Color(0xFFD6E6F6)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.2),
                                  blurRadius: 32,
                                  offset: Offset(0, 16),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.school, size: 64, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text('Welcome Back!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Login to your account', style: TextStyle(fontSize: 16, color: Colors.grey)),
                        const SizedBox(height: 32),
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
                                  onPressed: _login,
                                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account?"),
                                  TextButton(
                                    onPressed: widget.onRegister,
                                    child: const Text('Register'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Developed by Namoc',
                  style: TextStyle(color: Colors.grey, fontSize: 14, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 