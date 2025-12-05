import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jourdayapp/journal_entry.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<JournalEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList('journal_entries') ?? [];
    setState(() {
      _entries = entriesJson
          .map((json) => JournalEntry.fromJson(jsonDecode(json)))
          .toList();
      _entries.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 32),
        Text(
          formattedDate,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.blueGrey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'JourDay helps you record your daily journey in a simple way. You can write about your day, save it offline, and open it anytime. This app is perfect for those who like to quickly and neatly record moments, emotions, or plans for the week.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16, height: 1.7),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        if (_entries.isEmpty)
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 64,
                  color: Colors.blueGrey[800],
                ),
                const SizedBox(height: 16),
                Text(
                  'There are no entries yet.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        else
          ..._entries.map(
            (entry) => Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  entry.title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM d, yyyy').format(entry.date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.content.length > 100
                          ? '${entry.content.substring(0, 100)}...'
                          : entry.content,
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(entry.title),
                      content: SingleChildScrollView(
                        child: Text(entry.content),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
