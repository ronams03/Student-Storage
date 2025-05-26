import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'students_screen.dart';
import 'courses_screen.dart';
import 'settings_screen.dart';
import 'course_details_screen.dart';
import 'student_qr_code_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String role; // 'admin' or 'student'
  final String? phone;
  final String? course;
  final String? year;
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.phone,
    this.course,
    this.year,
  });
}

void main() {
  runApp(const MyApp());
}

class _ScreenState {
  static const login = 'login';
  static const register = 'register';
  static const admin = 'admin';
  static const student = 'student';
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> users = [
    User(name: 'Admin', email: 'admin@admin.com', password: 'admin', role: 'admin', phone: '+1 (555) 123-0000'),
    User(name: 'Student', email: 'student@student.com', password: 'student', role: 'student', phone: '+1 (555) 123-0009', course: 'Computer Science', year: '2nd Year'),
  ];
  User? loggedInUser;
  String screen = _ScreenState.login;

  Future<bool> _login(String role, String email, String password) async {
    final user = users.firstWhere(
      (u) => u.email == email && u.role == role && u.password == password,
      orElse: () => User(name: '', email: '', password: '', role: ''),
    );
    if (user.email.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('loggedInEmail', user.email);
      await prefs.setString('loggedInRole', user.role);
      setState(() {
        loggedInUser = user;
        screen = user.role == 'admin' ? _ScreenState.admin : _ScreenState.student;
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _register(User user) async {
    if (users.any((u) => u.email == user.email)) {
      return false;
    }
    setState(() {
      users.add(user);
      screen = _ScreenState.login;
    });
    return true;
  }

  void _logout() {
    setState(() {
      loggedInUser = null;
      screen = _ScreenState.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (screen == _ScreenState.login) {
      body = LoginScreen(
        onLogin: (role, email, password) => _login(role, email, password),
        onRegister: () => setState(() => screen = _ScreenState.register),
      );
    } else if (screen == _ScreenState.register) {
      List<String> courses = [
        'Computer Science',
        'Mathematics',
        'Physics',
        'Biology',
        'Chemistry',
        'History',
        'English Literature',
        'Economics',
      ];
      body = RegisterScreen(
        onRegister: (user) { return _register(user); },
        courses: courses,
        onBack: () => setState(() => screen = _ScreenState.login),
      );
    } else if (screen == _ScreenState.admin) {
      body = MainNavigation(onLogout: _logout);
    } else {
      body = StudentDashboard(user: loggedInUser!, onLogout: _logout);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD6E6F6),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            side: const BorderSide(color: Color(0xFFD1D5DB)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ),
      home: body,
    );
  }
}

class MainNavigation extends StatefulWidget {
  final VoidCallback onLogout;
  const MainNavigation({super.key, required this.onLogout});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  List<Student> students = [
    Student('Ethan Harper', 'Computer Science', '2nd Year', 'https://i.imgur.com/BoN9kdC.png', '202300123', 'ethan.harper@example.com', '+1 (555) 123-0001'),
    Student('Olivia Bennett', 'Mathematics', '2nd Year', 'https://i.imgur.com/1bX5QH6.png', '202300124', 'olivia.bennett@example.com', '+1 (555) 123-0002'),
    Student('Noah Carter', 'Physics', '2nd Year', 'https://i.imgur.com/BoN9kdC.png', '202300125', 'noah.carter@example.com', '+1 (555) 123-0003'),
    Student('Ava Mitchell', 'Biology', '2nd Year', 'https://i.imgur.com/1bX5QH6.png', '202300126', 'ava.mitchell@example.com', '+1 (555) 123-0004'),
    Student('Liam Foster', 'Chemistry', '2nd Year', 'https://i.imgur.com/BoN9kdC.png', '202300127', 'liam.foster@example.com', '+1 (555) 123-0005'),
    Student('Isabella Hayes', 'History', '2nd Year', 'https://i.imgur.com/1bX5QH6.png', '202300128', 'isabella.hayes@example.com', '+1 (555) 123-0006'),
    Student('Jackson Reed', 'English Literature', '2nd Year', 'https://i.imgur.com/BoN9kdC.png', '202300129', 'jackson.reed@example.com', '+1 (555) 123-0007'),
    Student('Sophia Morgan', 'Economics', '2nd Year', 'https://i.imgur.com/1bX5QH6.png', '202300130', 'sophia.morgan@example.com', '+1 (555) 123-0008'),
  ];

  List<String> courses = [
    'Computer Science',
    'Mathematics',
    'Physics',
    'Biology',
    'Chemistry',
    'History',
    'English Literature',
    'Economics',
  ];

  void addStudent(Student student) {
    setState(() {
      students.add(student);
      if (!courses.contains(student.course)) {
        courses.add(student.course);
      }
    });
  }

  void addCourse(String course) {
    setState(() {
      if (!courses.contains(course)) {
        courses.add(course);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(students: students, courses: courses, showAppBar: false),
      StudentsScreen(students: students, courses: courses, showAppBar: false),
      CoursesScreen(students: students, courses: courses, onAddCourse: addCourse, showAppBar: false),
      const SettingsScreen(showAppBar: false),
    ];
    final titles = ['Home', 'Students', 'Courses', 'Settings'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;
  const StudentDashboard({super.key, required this.user, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          const SizedBox(height: 8),
          Center(
            child: CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage('https://i.imgur.com/BoN9kdC.png'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
        child: Column(
              children: [
                Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                const SizedBox(height: 4),
                Text(user.course ?? '', style: const TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(height: 2),
                Text(user.email, style: const TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Academic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          InfoRow(label: 'Course', value: user.course ?? '-'),
          InfoRow(label: 'Year', value: user.year ?? '-'),
          const InfoRow(label: 'Enrollment Date', value: 'August 2023'),
          const SizedBox(height: 24),
          const Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          InfoRow(label: 'Email', value: user.email),
          InfoRow(label: 'Phone', value: user.phone ?? '-'),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StudentQRCodeScreen(
                      student: Student(
                        user.name,
                        user.course ?? '-',
                        user.year ?? '-',
                        'https://i.imgur.com/BoN9kdC.png',
                        user.email,
                        user.email,
                        user.phone ?? '-',
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Show QR Code'),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
            ),
            Expanded(
              child: Text(value, style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
        const Divider(height: 24),
      ],
    );
  }
}