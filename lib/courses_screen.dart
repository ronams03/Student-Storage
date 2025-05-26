import 'package:flutter/material.dart';
import 'students_screen.dart';
import 'course_details_screen.dart';

class CoursesScreen extends StatelessWidget {
  final List<Student> students;
  final List<String> courses;
  final void Function(String) onAddCourse;
  final bool showAppBar;
  const CoursesScreen({super.key, required this.students, required this.courses, required this.onAddCourse, this.showAppBar = true});

  void _showAddCourseDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Course'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Course name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty && !courses.contains(name)) {
                onAddCourse(name);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Courses', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)),
      ) : null,
      backgroundColor: const Color(0xFFF5F6FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final courseName = courses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFD6E6F6),
                child: Text(courseName.isNotEmpty ? courseName[0] : '', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              title: Text(courseName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CourseDetailsScreen(courseName: courseName, students: students),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCourseDialog(context),
        backgroundColor: const Color(0xFFD6E6F6),
        child: const Icon(Icons.add, color: Colors.black),
        tooltip: 'Add Course',
      ),
    );
  }
}