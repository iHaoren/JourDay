import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jourdayapp/home_page.dart';
import 'package:jourdayapp/write_page.dart';
// import 'package:jourdayapp/journal_entry.dart';
// import 'package:jourdayapp/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0; // menyimpan tab

  // list page/halaman
  final List<Widget> _pages = [HomePage(), WritePage()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal Day App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'JourDay',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        // for icon floating button
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.draw, color: Colors.deepOrange),
          onPressed: () {},
        ),

        // for navigation
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(icon: Icon(Icons.edit), label: 'Write'),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
