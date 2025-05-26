import 'package:flutter/material.dart';
import 'add_student_screen.dart';
import 'students_screen.dart';
import 'courses_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Student> students;
  final List<String> courses;
  final bool showAppBar;
  const HomeScreen({super.key, required this.students, required this.courses, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Home'),
      ) : null,
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage('https://i.imgur.com/1bX5QH6.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome Back,',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    Text(
                      'Admin',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6D9EEB), Color(0xFFD6E6F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QuickActionButton(
                        icon: Icons.person_add_alt_1,
                        label: 'Add Student',
                        color: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => AddStudentScreen(courseChoices: courses)),
                          );
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.people_outline,
                        label: 'View Students',
                        color: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => StudentsScreen(students: students, courses: courses)),
                          );
                        },
                      ),
                      _QuickActionButton(
                        icon: Icons.menu_book_outlined,
                        label: 'Courses',
                        color: Colors.white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => CoursesScreen(students: students, courses: courses, onAddCourse: (_){})),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Highlights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _HighlightCard(
              icon: Icons.school,
              title: '120 Students',
              subtitle: 'Currently Enrolled',
              color: const Color(0xFF6D9EEB),
            ),
            const SizedBox(height: 16),
            _HighlightCard(
              icon: Icons.check_circle_outline,
              title: '98% Attendance',
              subtitle: 'This Month',
              color: const Color(0xFF81C784),
            ),
            const SizedBox(height: 16),
            _HighlightCard(
              icon: Icons.star_border,
              title: 'Top Performer: Olivia Bennett',
              subtitle: 'Mathematics',
              color: const Color(0xFFFFD600),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _HighlightCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
}