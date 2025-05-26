import 'package:flutter/material.dart';
import 'students_screen.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseName;
  final List<Student> students;
  const CourseDetailsScreen({super.key, required this.courseName, required this.students});

  @override
  Widget build(BuildContext context) {
    final courseStudents = students.where((s) => s.course == courseName).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: courseStudents.length,
        itemBuilder: (context, index) {
          final student = courseStudents[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(student.avatarUrl),
                radius: 24,
              ),
              title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: Text(student.year, style: const TextStyle(color: Colors.grey, fontSize: 15)),
            ),
          );
        },
      ),
    );
  }
} 