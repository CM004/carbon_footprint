class QuizQuestion {
  final String question;
  final List<String> options;
  final List<int> scores;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.scores,
  });

  static List<QuizQuestion> sampleQuestions = [
    QuizQuestion(
      question: 'How do you usually commute to work/school?',
      options: [
        'Walk/Bicycle',
        'Public Transport',
        'Carpool',
        'Personal Car',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'How often do you eat meat?',
      options: [
        'Never (Vegan/Vegetarian)',
        '1-2 times per week',
        '3-5 times per week',
        'Daily',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'How do you manage your household waste?',
      options: [
        'Strict recycling and composting',
        'Regular recycling',
        'Occasional recycling',
        'No recycling',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'What is your primary source of shopping?',
      options: [
        'Local markets and second-hand',
        'Mix of local and chain stores',
        'Mainly chain stores',
        'Mainly online shopping',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'How often do you buy new clothes?',
      options: [
        'Once a year or less',
        'A few times a year',
        'Monthly',
        'Weekly',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'How do you handle plastic waste?',
      options: [
        'Avoid single-use plastics',
        'Recycle consistently',
        'Sometimes recycle',
        'Toss in trash',
      ],
      scores: [0, 2, 4, 6],
    ),
    QuizQuestion(
      question: 'How long are your daily showers?',
      options: [
        'Less than 5 minutes',
        '5-10 minutes',
        '10-15 minutes',
        'More than 15 minutes',
      ],
      scores: [0, 2, 4, 6],
    ),
  ];
} 