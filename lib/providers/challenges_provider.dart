import 'package:flutter/foundation.dart';

class ChallengesProvider with ChangeNotifier {
  bool _isParticipating = false;
  double _progress = 0.0;
  final int _totalDays = 7;
  bool _hasBadge = false;
  DateTime? _challengeStartDate;

  bool get isParticipating => _isParticipating;
  double get progress => _progress;
  int get totalDays => _totalDays;
  bool get hasBadge => _hasBadge;
  DateTime? get challengeStartDate => _challengeStartDate;

  void toggleParticipation() {
    _isParticipating = !_isParticipating;
    if (_isParticipating) {
      _challengeStartDate = DateTime.now();
    } else {
      _progress = 0.0;
      _challengeStartDate = null;
    }
    notifyListeners();
  }

  void updateProgress() {
    if (_isParticipating) {
      _progress = (_progress + (1 / _totalDays)).clamp(0.0, 1.0);
      
      // Award badge when challenge is completed
      if (_progress >= 1.0) {
        _hasBadge = true;
      }
      
      notifyListeners();
    }
  }

  void resetProgress() {
    _progress = 0.0;
    _challengeStartDate = null;
    notifyListeners();
  }

  void resetChallenge() {
    _isParticipating = false;
    _progress = 0.0;
    _challengeStartDate = null;
    _hasBadge = false;
    notifyListeners();
  }

  String get remainingDays {
    if (!_isParticipating || _challengeStartDate == null) return '';
    final daysCompleted = (_progress * _totalDays).floor();
    return '${_totalDays - daysCompleted} days remaining';
  }
} 