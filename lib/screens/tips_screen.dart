import 'package:flutter/material.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<Map<String, dynamic>> _tips = [
    {
      'title': 'Refuse First',
      'description': 'Before you reuse or recycle, ask if you need it at all.',
      'icon': Icons.not_interested,
      'color': Colors.purple,
    },
    {
      'title': 'Save Water',
      'description': 'Cut 2 minutes from your daily shower to save 10L/day.',
      'icon': Icons.water_drop_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'Meatless Mondays',
      'description': 'Meatless Mondays can reduce your carbon footprint by 8%.',
      'icon': Icons.restaurant_menu,
      'color': Colors.orange,
    },
    {
      'title': 'Reduce Energy',
      'description': 'Turn off lights when leaving a room and unplug electronics when not in use.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
    },
    {
      'title': 'Reduce Waste',
      'description': 'Use reusable bags, containers, and water bottles to minimize waste.',
      'icon': Icons.delete_outline,
      'color': Colors.green,
    },
    {
      'title': 'Sustainable Transport',
      'description': 'Walk, cycle, or use public transport whenever possible.',
      'icon': Icons.directions_bike_outlined,
      'color': Colors.teal,
    },
    {
      'title': 'Plant Trees',
      'description': 'Participate in local tree planting initiatives or start your own garden.',
      'icon': Icons.park_outlined,
      'color': Colors.lightGreen,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Tips'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Swipe for More Tips',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _tips.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(value) * 400,
                        width: Curves.easeInOut.transform(value) * 350,
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            _tips[index]['color'].withAlpha(75),
                            _tips[index]['color'].withAlpha(25),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _tips[index]['icon'],
                              size: 80,
                              color: _tips[index]['color'],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              _tips[index]['title'],
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _tips[index]['description'],
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _tips.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
} 