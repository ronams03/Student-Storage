import 'package:flutter/material.dart';
import 'students_screen.dart';
import 'student_qr_code_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;
  final VoidCallback? onDelete;

  const StudentDetailsScreen({super.key, required this.student, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          const SizedBox(height: 8),
          Center(
            child: CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(student.avatarUrl),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                const SizedBox(height: 4),
                Text(student.course, style: const TextStyle(color: Colors.grey, fontSize: 18)),
                const SizedBox(height: 2),
                Text('ID: ${student.id}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Academic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          InfoRow(label: 'Course', value: student.course),
          InfoRow(label: 'Year', value: student.year),
          const InfoRow(label: 'Enrollment Date', value: 'August 2023'),
          const SizedBox(height: 24),
          const Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 8),
          InfoRow(label: 'Email', value: student.email),
          InfoRow(label: 'Phone', value: student.phone),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StudentQRCodeScreen(student: student),
                    ),
                  );
                },
                child: const Text('Show QR Code'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Student'),
                      content: Text('Are you sure you want to delete ${student.name}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            onDelete?.call();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${student.name} deleted')),
                            );
                          },
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Delete Student', style: TextStyle(color: Colors.red)),
              ),
            ],
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