import 'package:flutter/material.dart';
import 'students_screen.dart';

class StudentQRCodeScreen extends StatelessWidget {
  final Student student;

  const StudentQRCodeScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student QR Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 8),
          Text(
            'Scan to Access ${student.name}\'s Record',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Use this QR code to quickly access and manage student information. Keep it secure and readily available.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            height: 260,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Image.network(
                'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=StudentID:${student.id}',
                width: 180,
                height: 180,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Download functionality not implemented')),
                    );
                  },
                  child: const Text('Download', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Print functionality not implemented')),
                    );
                  },
                  child: const Text('Print', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}