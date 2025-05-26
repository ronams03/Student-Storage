import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_student_screen.dart';
import 'student_details_screen.dart';

class Student {
  final String name;
  final String course;
  final String year;
  final String avatarUrl;
  final String id;
  final String email;
  final String phone;

  Student(this.name, this.course, this.year, this.avatarUrl, this.id, this.email, this.phone);

  Map<String, dynamic> toJson() => {
        'name': name,
        'course': course,
        'year': year,
        'avatarUrl': avatarUrl,
        'id': id,
        'email': email,
        'phone': phone,
      };

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        json['name'],
        json['course'],
        json['year'],
        json['avatarUrl'],
        json['id'],
        json['email'],
        json['phone'],
      );
}

class StudentsScreen extends StatefulWidget {
  final List<Student> students;
  final List<String> courses;
  final bool showAppBar;
  const StudentsScreen({super.key, required this.students, required this.courses, this.showAppBar = true});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late List<Student> filteredStudents;
  final TextEditingController _searchController = TextEditingController();
  String activeFilter = 'Name';
  static const String _studentsKey = 'students';

  @override
  void initState() {
    super.initState();
    filteredStudents = widget.students;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredStudents = widget.students.where((student) {
        String fieldToSearch;
        if (activeFilter == 'Name') {
          fieldToSearch = student.name;
        } else if (activeFilter == 'Course') {
          fieldToSearch = student.course;
        } else {
          fieldToSearch = student.year;
        }
        return fieldToSearch.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      activeFilter = filter;
    });
    _applyFilters();
  }

  Future<void> _addStudent() async {
    final newStudent = await Navigator.of(context).push<Student>(
      MaterialPageRoute(builder: (_) => AddStudentScreen(courseChoices: widget.courses)),
    );
    if (newStudent != null) {
      setState(() {
        widget.students.add(newStudent);
      });
      await _saveStudents();
      _applyFilters();
    }
  }

  void _onStudentDeleted(String studentId) {
    setState(() {
      widget.students.removeWhere((student) => student.id == studentId);
    });
    _saveStudents();
    _applyFilters();
  }

  Future<void> _saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentsJson = jsonEncode(widget.students.map((student) => student.toJson()).toList());
    await prefs.setString(_studentsKey, studentsJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Students', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addStudent,
          ),
        ],
      ) : null,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search students',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF5F6FA),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                FilterChipWidget(
                  label: 'Name',
                  selected: activeFilter == 'Name',
                  onTap: () => _onFilterSelected('Name'),
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Course',
                  selected: activeFilter == 'Course',
                  onTap: () => _onFilterSelected('Course'),
                ),
                const SizedBox(width: 8),
                FilterChipWidget(
                  label: 'Year',
                  selected: activeFilter == 'Year',
                  onTap: () => _onFilterSelected('Year'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student.avatarUrl),
                    radius: 28,
                  ),
                  title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  subtitle: Text(student.course, style: const TextStyle(color: Colors.grey, fontSize: 15)),
                  trailing: Text(student.year, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StudentDetailsScreen(
                          student: student,
                          onDelete: () => _onStudentDeleted(student.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const FilterChipWidget({super.key, required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFD6E6F6) : const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
      ),
    );
  }
}