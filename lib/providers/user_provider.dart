import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _name = '';
  String _ageGroup = '18-24';
  String _region = 'Urban';
  int _totalScore = 0;
  final List<String> _completedChallenges = [];
  bool _isProfileComplete = false;
  bool _isDarkMode = false;

  String get name => _name;
  String get ageGroup => _ageGroup;
  String get region => _region;
  int get totalScore => _totalScore;
  List<String> get completedChallenges => List.unmodifiable(_completedChallenges);
  bool get isProfileComplete => _isProfileComplete;
  bool get isDarkMode => _isDarkMode;

  void updateName(String newName) {
    _name = newName;
    _checkProfileComplete();
    notifyListeners();
  }

  void updateProfile({required String ageGroup, required String region}) {
    _ageGroup = ageGroup;
    _region = region;
    _checkProfileComplete();
    notifyListeners();
  }

  void _checkProfileComplete() {
    _isProfileComplete = _name.isNotEmpty && _ageGroup.isNotEmpty && _region.isNotEmpty;
  }

  void updateScore(int score) {
    _totalScore = score;
    notifyListeners();
  }

  void addCompletedChallenge(String challengeName) {
    if (!_completedChallenges.contains(challengeName)) {
      _completedChallenges.add(challengeName);
      notifyListeners();
    }
  }

  void resetProgress() {
    _totalScore = 0;
    _completedChallenges.clear();
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
} 