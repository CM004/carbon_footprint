import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/challenges_provider.dart';
import '../providers/user_provider.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showingBadgeDialog = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showBadgeAwardDialog(BuildContext context) {
    if (_showingBadgeDialog) return;
    _showingBadgeDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.workspace_premium, color: Colors.amber, size: 32),
            SizedBox(width: 8),
            Text('Congratulations!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'You\'ve completed the No-Plastic Challenge!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Icon(
              Icons.emoji_events,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'You\'ve earned the "Plastic-Free Hero" badge!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Update completed challenges in UserProvider
              Provider.of<UserProvider>(context, listen: false)
                  .addCompletedChallenge('No-Plastic Challenge');
              // Reset the challenge after claiming the badge
              Provider.of<ChallengesProvider>(context, listen: false)
                  .resetChallenge();
              Navigator.of(context).pop();
            },
            child: const Text('Claim Badge'),
          ),
        ],
      ),
    ).then((_) => _showingBadgeDialog = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Challenges'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Consumer2<ChallengesProvider, UserProvider>(
        builder: (context, challengesProvider, userProvider, child) {
          // Check if badge should be awarded
          if (challengesProvider.hasBadge && !_showingBadgeDialog) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showBadgeAwardDialog(context);
            });
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                size: 48,
                                color: Colors.blue,
                              ),
                              if (challengesProvider.hasBadge) ...[
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.workspace_premium,
                                  size: 32,
                                  color: Colors.amber,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No-Plastic Challenge',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Avoid single-use plastics for 7 days and make a difference!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Switch.adaptive(
                            value: challengesProvider.isParticipating,
                            onChanged: (value) {
                              challengesProvider.toggleParticipation();
                            },
                          ),
                          if (challengesProvider.isParticipating) ...[
                            const SizedBox(height: 24),
                            Text(
                              challengesProvider.remainingDays,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (challengesProvider.isParticipating) ...[
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Progress',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                if (challengesProvider.hasBadge)
                                  const Tooltip(
                                    message: 'Plastic-Free Hero Badge Earned!',
                                    child: Icon(
                                      Icons.workspace_premium,
                                      color: Colors.amber,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            LinearProgressIndicator(
                              value: challengesProvider.progress,
                              backgroundColor: Colors.grey[200],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                              minHeight: 10,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${(challengesProvider.progress * 100).toInt()}% Complete',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                challengesProvider.updateProgress();
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Log Progress'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Tips',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            _buildTipItem(
                              icon: Icons.shopping_bag,
                              tip: 'Carry a reusable shopping bag',
                            ),
                            _buildTipItem(
                              icon: Icons.water_drop,
                              tip: 'Use a reusable water bottle',
                            ),
                            _buildTipItem(
                              icon: Icons.restaurant,
                              tip: 'Avoid plastic cutlery when eating out',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTipItem({required IconData icon, required String tip}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
} 