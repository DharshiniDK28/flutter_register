import 'package:app2/home/home_bloc.dart';
import 'package:app2/home/home_event.dart';
import 'package:app2/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          drawer: const AppDrawer(), // Added drawer
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('mobileView'),
                builder: (_) => Column(
                  children: [
                    Expanded(child: _screens[state.currentIndex]),
                    BottomNavigationBar(
                      currentIndex: state.currentIndex,
                      selectedItemColor: Colors.deepPurple,
                      unselectedItemColor: Colors.grey,
                      onTap: (idx) => context.read<HomeBloc>().add(PageTapped(index: idx)),
                      items: const [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Bar Chart"),
                        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
                        BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
                      ],
                    ),
                  ],
                ),
              ),
              Breakpoints.mediumAndUp: SlotLayout.from(
                key: const Key('tabletView'),
                builder: (_) => Row(
                  children: [
                    NavigationRail(
                      selectedIndex: state.currentIndex,
                      onDestinationSelected: (idx) => context.read<HomeBloc>().add(PageTapped(index: idx)),
                      labelType: NavigationRailLabelType.selected,
                      destinations: const [
                        NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                        NavigationRailDestination(icon: Icon(Icons.bar_chart), label: Text('Bar Chart')),
                        NavigationRailDestination(icon: Icon(Icons.newspaper), label: Text('News')),
                        NavigationRailDestination(icon: Icon(Icons.info), label: Text('Info')),
                      ],
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(child: _screens[state.currentIndex]),
                  ],
                ),
              ),
            },
          ),
        );
      },
    );
  }

  List<Widget> get _screens => const [
    CovidTopSection(),
    StatisticsScreen(),
    Center(child: Text("Newspaper")),
    Center(child: Text("Info")),
  ];
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class CovidTopSection extends StatelessWidget {
  const CovidTopSection({super.key});

  static const List<String> countries = ['IND', 'USA', 'UK'];
  static const Map<String, String> countryFlags = {
    'IND': 'assets/india.png',
    'USA': 'assets/flag.png',
    'UK': 'assets/UK.png',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final selectedCountry = state.selectedCountry;
        final screenWidth = MediaQuery.of(context).size.width;
        final containerHeight = screenWidth < 600 ? screenWidth * 0.9 : screenWidth * 0.5;

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: containerHeight,
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.short_text, color: Colors.white),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        const Icon(Icons.notifications_none, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Covid-19",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: screenWidth < 600 ? 140 : 180,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              value: selectedCountry,
                              isExpanded: true,
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                              ),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  context.read<HomeBloc>().add(CountryChanged(country: newValue));
                                }
                              },
                              items: countries.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        countryFlags[country]!,
                                        height: 20,
                                        width: 25,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(country),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Are you feeling sick?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "If you feel sick with any of covid-19 symptoms\nplease call or SMS us immediately for help!",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: screenWidth < 600 ? 50 : 60,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.call, color: Colors.white),
                              label: Text(
                                "Call Now",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth < 600 ? 16 : 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: screenWidth < 600 ? 50 : 60,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.message, color: Colors.white),
                              label: Text(
                                "Send SMS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth < 600 ? 16 : 18,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
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

              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: const Text(
                  "Prevention",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              if (screenWidth < 600) ...[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: const [
                      PreventionItem(imagePath: 'assets/img1.png', label: 'Avoid Close\nContact'),
                      SizedBox(width: 20),
                      PreventionItem(imagePath: 'assets/img2.png', label: 'Clean your\nhands often'),
                      SizedBox(width: 20),
                      PreventionItem(imagePath: 'assets/img3.png', label: 'Wear a\nface mask'),
                    ],
                  ),
                ),
              ] else ...[
                Center(
                  child: SizedBox(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        PreventionItem(imagePath: 'assets/img1.png', label: 'Avoid Close\nContact'),
                        PreventionItem(imagePath: 'assets/img2.png', label: 'Clean your\nhands often'),
                        PreventionItem(imagePath: 'assets/img3.png', label: 'Wear a\nface mask'),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),
              Container(
                width: screenWidth * 0.9,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PreventionItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const PreventionItem({
    required this.imagePath,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
      ],
    );
  }
}
