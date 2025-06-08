import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/quiz_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/quiz_provider.dart';
import 'providers/challenges_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ChallengesProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return MaterialApp(
            title: 'Eco Footprint',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.green,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: userProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = const [
    QuizScreen(),
    ChallengesScreen(),
    TipsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the selected index based on profile completion
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _selectedIndex = userProvider.isProfileComplete ? 0 : 3;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        // Ensure profile tab is selected when profile is incomplete
        if (!userProvider.isProfileComplete && _selectedIndex != 3) {
          _selectedIndex = 3;
        }

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              if (!userProvider.isProfileComplete && index != 3) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please complete your profile first!'),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.quiz),
                label: 'Quiz',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events),
                label: 'Challenges',
              ),
              NavigationDestination(
                icon: Icon(Icons.tips_and_updates),
                label: 'Tips',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
