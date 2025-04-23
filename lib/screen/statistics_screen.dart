import 'package:app2/data/repositories/statistics_repository.dart';
import 'package:app2/form_bloc/data_fetch.dart';
import 'package:app2/statistics_bloc/statistics_bloc.dart';
import 'package:app2/statistics_bloc/statistics_event.dart';
import 'package:app2/statistics_bloc/statistics_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  void _openBottomDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily New Cases',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/barchart.png'),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => StatisticsBloc(
      statisticsRepo: context.read<StatisticRepository>(),
        )..add(StaticPageLoad()),
    child: BlocListener<StatisticsBloc, StatisticsState>(
    listener: (context, state) {
    if (state.formSubmissionStatus is DataFetchedFailed) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to load statistics')),
       );
      }
    },

  child: DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[700],

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.short_text, color: Colors.white),
                          Icon(Icons.notifications_none, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Statistics",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6A52A2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TabBar(
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.white,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(text: "My Country"),
                            Tab(text: "Global"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 360,
                        child: const TabBarView(
                          children: [
                            MyCountryTab(),
                            Center(
                              child: Text(
                                'Global',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Positioned(
                //   bottom: 150,
                //   right: 0,
                //   left: 0,
                //   child: Container(
                //     padding: const EdgeInsets.all(30),
                //     decoration: const BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(50),
                //         topRight: Radius.circular(50),
                //       ),
                //       color: Colors.white,
                //     ),
                //     width: MediaQuery.of(context).size.width,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text(
                //           'Daily New Cases',
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black,
                //           ),
                //         ),
                //         const SizedBox(height: 16),
                //         Container(
                //           width: MediaQuery.of(context).size.width,
                //           height: 200,
                //           decoration: BoxDecoration(
                //             image: const DecorationImage(
                //               image: AssetImage('assets/barchart.png'),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () =>_openBottomDrawer(context),
          child: const Icon(Icons.add),
        ),
      ),
    ),
    ),
);

  }
}
class MyCountryTab extends StatefulWidget {
  const MyCountryTab({super.key});
  @override
  State<MyCountryTab> createState() => _MyCountryTabState();
}

class _MyCountryTabState extends State<MyCountryTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsBloc, StatisticsState>(
      builder: (context, state) {
        final dataFetch = state.fetchedData;
        if (state.formSubmissionStatus is DataFetchedLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (dataFetch == null) {
          return Center(child: Text('No statistics data available'));
        }

        return DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const SizedBox(height: 10),
              const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: "Total"),
                  Tab(text: "Today"),
                  Tab(text: "Yesterday"),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            title: "Affected",
                            color: Colors.orange,
                            value: '${dataFetch.affected}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            title: "Death",
                            color: Colors.red,
                            value: '${dataFetch.death}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            title: "Recovered",
                            color:Colors.green,
                            value: '${dataFetch.recovered}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            title: "Active",
                            color: Colors.blue,
                            value: '${dataFetch.active}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatsCard(
                            title: "Serious",
                            color: Colors.purple,
                            value: '${dataFetch.active}',
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
