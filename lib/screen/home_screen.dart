import 'package:app2/home/home_bloc.dart';
import 'package:app2/home/home_event.dart';
import 'package:app2/home/home_state.dart';
import 'package:app2/screen/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          body: _screens[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<HomeBloc>().add(PageTapped(index: index));
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  activeIcon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[700],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.home_filled, color: Colors.white)),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.bar_chart),
                  activeIcon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[700],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.bar_chart, color: Colors.white)),
                  label: "barChart"),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.newspaper),
                  activeIcon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[700],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.newspaper, color: Colors.white)),
                  label: "Newspaper"),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.info),
                  activeIcon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[700],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.info, color: Colors.white)),
                  label: "Info"),
            ],
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

class CovidTopSection extends StatelessWidget {
  const CovidTopSection({super.key});

  static const List<String> countries = ['India', 'USA', 'UK'];
  static const Map<String, String> countryFlags = {
    'India': 'assets/india.png',
    'USA': 'assets/flag.png',
    'UK': 'assets/UK.png',
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String selectedCountry = state.selectedCountry;
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.9,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.short_text, color: Colors.white),
                        Icon(Icons.notifications_none, color: Colors.white),
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
                        const SizedBox(height: 30),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            margin: const EdgeInsets.only(left: 150),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                value: selectedCountry,
                                decoration: InputDecoration(
                                  prefix: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      countryFlags[selectedCountry]!,
                                      height: 25,
                                      width: 30,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    context.read<HomeBloc>().add(CountryChanged(country: newValue));
                                  }
                                },
                                items: countries.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                        alignment: Alignment.center, child: Text(value)),
                                  );
                                }).toList(),
                              ),
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
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.call, color: Colors.white),
                            label: const Text("Call Now", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.message, color: Colors.white),
                            label: const Text("Send SMS", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
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
                child: const Column(
                  children: [
                    Text("Prevention", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(30),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image(image: AssetImage('assets/img1.png'), height: 100, width: 100),
                          Text("Avoid Close \nContact", textAlign: TextAlign.center),
                        ],
                      ),
                      Column(
                        children: [
                          Image(image: AssetImage('assets/img2.png'), height: 100, width: 100),
                          Text("Clean your \nhands often", textAlign: TextAlign.center),
                        ],
                      ),
                      Column(
                        children: [
                          Image(image: AssetImage('assets/img3.png'), height: 100, width: 100),
                          Text("Wear a \nface mask", textAlign: TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/img4.png')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
