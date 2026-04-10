import 'package:flutter/material.dart';

void main() {
  runApp(const GarageHubApp());
}

class GarageHubApp extends StatelessWidget {
  const GarageHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VehicleMarket',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101010),
        primaryColor: const Color(0xFFFFC400),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC400),
          brightness: Brightness.dark,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: const GarageHubHomePage(),
    );
  }
}

class GarageHubHomePage extends StatefulWidget {
  const GarageHubHomePage({super.key});

  @override
  State<GarageHubHomePage> createState() => _GarageHubHomePageState();
}

class _GarageHubHomePageState extends State<GarageHubHomePage> {
  int selectedIndex = 0;
  String selectedBrand = 'All Brands';
  String selectedModel = 'Any Model';
  String selectedYear = '2020 - 2024';
  String selectedPrice = '\$50k - \$100k';

  final List<String> brands = ['All Brands', 'Audi', 'BMW', 'Tesla', 'Toyota'];
  final List<String> models = ['Any Model', 'X5', 'Model S', 'Corolla', 'A4'];
  final List<String> years = ['2020 - 2024', '2016 - 2019', '2010 - 2015'];
  final List<String> prices = ['\$50k - \$100k', '\$0k - \$50k', '\$100k+'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0D0D0D), Color(0xFF141414)],
                  ),
                ),
              ),
            ),
            Positioned(
              right: -40,
              top: 80,
              child: Opacity(
                opacity: 0.08,
                child: Text(
                  'VM',
                  style: TextStyle(
                    fontSize: 220,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade600,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Builder(
                        builder: (context) {
                          return IconButton(
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          );
                        },
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'VEHICLEMARKET',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                          color: Colors.yellow,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 520),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.yellow.shade700.withOpacity(0.5),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.45),
                              blurRadius: 28,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Quick Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Find your next car in seconds',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    'BRAND',
                                    selectedBrand,
                                    brands,
                                    (value) {
                                      setState(() => selectedBrand = value!);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: _buildField(
                                    'MODEL',
                                    selectedModel,
                                    models,
                                    (value) {
                                      setState(() => selectedModel = value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    'YEAR',
                                    selectedYear,
                                    years,
                                    (value) {
                                      setState(() => selectedYear = value!);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: _buildField(
                                    'PRICE RANGE',
                                    selectedPrice,
                                    prices,
                                    (value) {
                                      setState(() => selectedPrice = value!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFC400),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.search, size: 22),
                              label: const Text('SEARCH INVENTORY'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: const Color(0xFF0F0F0F),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(Icons.home, 'HOME', 0),
              _buildNavItem(Icons.search, 'SEARCH', 1),
              _buildNavItem(Icons.add, 'SELL', 2),
              _buildNavItem(Icons.message, 'MESSAGES', 3),
              _buildNavItem(Icons.favorite_border, 'FAVORITES', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.home, 'HOME', 0),
            _buildNavItem(Icons.search, 'SEARCH', 1),
            _buildNavItem(Icons.add, 'SELL', 2),
            _buildNavItem(Icons.message, 'MESSAGES', 3),
            _buildNavItem(Icons.favorite_border, 'FAVORITES', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool active = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: active
            ? BoxDecoration(
                color: const Color(0xFFFFC400),
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? Colors.black : Colors.white70, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.black : Colors.white70,
                fontSize: 10,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String currentValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentValue,
                isExpanded: true,
                dropdownColor: const Color(0xFF1B1B1B),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                items: options.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF111111),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Marketplace',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, thickness: 1),
            _buildDrawerItem(Icons.home_filled, 'Home'),
            _buildDrawerItem(Icons.search, 'Search'),
            _buildDrawerItem(Icons.star_border, 'Favorites'),
            _buildDrawerItem(Icons.settings_outlined, 'Settings'),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade700,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: const Text('Contact Sales'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {},
    );
  }
}
