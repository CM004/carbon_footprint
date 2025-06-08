// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:eco_footprint/main.dart';
import 'package:eco_footprint/providers/quiz_provider.dart';
import 'package:eco_footprint/providers/challenges_provider.dart';
import 'package:eco_footprint/providers/user_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
          ChangeNotifierProvider(create: (_) => ChallengesProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('Quiz'), findsOneWidget);
    expect(find.text('Challenges'), findsOneWidget);
    expect(find.text('Tips'), findsOneWidget);
  });

  testWidgets('Quiz navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Get the first question
    final quizProvider = QuizProvider();
    final firstQuestion = quizProvider.questions[0];

    // Verify that the first question is displayed
    expect(find.text(firstQuestion.question), findsOneWidget);

    // Find and tap the first option
    await tester.tap(find.text(firstQuestion.options[0]));
    await tester.pumpAndSettle();

    // Verify that we've moved to the next question
    expect(find.text(firstQuestion.question), findsNothing);
    expect(find.text(quizProvider.questions[1].question), findsOneWidget);
  });

  testWidgets('Bottom navigation works correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify we start on the Quiz screen
    expect(find.text('Eco Footprint Quiz'), findsOneWidget);

    // Navigate to Challenges screen
    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle();

    // Verify we're on the Challenges screen
    expect(find.text('Eco Challenges'), findsOneWidget);

    // Navigate to Tips screen
    await tester.tap(find.byIcon(Icons.tips_and_updates));
    await tester.pumpAndSettle();

    // Verify we're on the Tips screen
    expect(find.text('Eco Tips'), findsOneWidget);
  });

  testWidgets('Challenge participation can be toggled', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Navigate to Challenges screen
    await tester.tap(find.byIcon(Icons.emoji_events));
    await tester.pumpAndSettle();

    // Find and tap the challenge toggle
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();

    // Verify that the progress section is now visible
    expect(find.text('Your Progress'), findsOneWidget);
  });

  group('Quiz Provider Tests', () {
    test('Quiz score calculation is correct', () {
      final provider = QuizProvider();
      
      // Answer all questions with the most eco-friendly option (0 points)
      for (var _ in provider.questions) {
        provider.answerQuestion(0);
      }

      expect(provider.totalScore, 0);
      expect(provider.isCompleted, true);
    });

    test('Quiz feedback is appropriate', () {
      final provider = QuizProvider();
      
      // Answer all questions with the most eco-friendly option
      for (var _ in provider.questions) {
        provider.answerQuestion(0);
      }

      expect(provider.getFeedback(), contains('Excellent'));
    });
  });
}
