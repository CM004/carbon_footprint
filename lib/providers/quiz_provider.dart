import 'package:flutter/foundation.dart';
import '../models/quiz_question.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _totalScore = 0;
  final List<int> _answers = [];
  bool _isCompleted = false;

  List<QuizQuestion> get questions => QuizQuestion.sampleQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalScore => _totalScore;
  bool get isCompleted => _isCompleted;
  List<int> get answers => _answers;

  void answerQuestion(int score) {
    _answers.add(score);
    _totalScore += score;
    
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _isCompleted = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _totalScore = 0;
    _answers.clear();
    _isCompleted = false;
    notifyListeners();
  }

  String getCategory() {
    final maxPossibleScore = questions.length * 6;
    final percentage = (_totalScore / maxPossibleScore) * 100;

    if (percentage < 30) {
      return '🌿 Low Footprint (Eco-Warrior)';
    } else if (percentage < 60) {
      return '🍃 Moderate Footprint (Eco-Learner)';
    } else {
      return '🌪 High Footprint (Eco-Beginner)';
    }
  }

  String getFeedback() {
    final maxPossibleScore = questions.length * 6;
    final percentage = (_totalScore / maxPossibleScore) * 100;

    if (percentage < 30) {
      return 'Excellent! Your carbon footprint is very low! Keep up the great work in protecting our planet!';
    } else if (percentage < 60) {
      return 'Good effort! Your carbon footprint is moderate. There\'s room for improvement, but you\'re on the right track!';
    } else {
      return 'Your carbon footprint is high. Here are some tips to reduce it: consider using public transport, reducing meat consumption, and recycling more.';
    }
  }
} 