import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jourdayapp/journal_entry.dart';
import 'dart:convert';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> _saveEntry() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both title and content')),
      );
      return;
    }

    final entry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      content: contentController.text,
      date: DateTime.now(),
    );

    final prefs = await SharedPreferences.getInstance();
    final entries = prefs.getStringList('journal_entries') ?? [];
    entries.add(jsonEncode(entry.toJson()));
    await prefs.setStringList('journal_entries', entries);

    titleController.clear();
    contentController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Entry saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Title',
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: TextField(
              controller: contentController,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write your story...',
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveEntry,
            child: Text('Save Entry'),
          ),
        ],
      ),
    );
  }
}
