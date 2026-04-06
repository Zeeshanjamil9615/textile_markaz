import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/controllers/textile_search_controller.dart';
import 'package:textile_markaz/data/dummy/dummy_data.dart';
import 'package:textile_markaz/screens/mode_choice_screen.dart';
import 'package:textile_markaz/screens/results_screen.dart';
import 'package:textile_markaz/widgets/filter_dropdown.dart';

class HomeSearchScreen extends StatelessWidget {
  static const routeName = '/';

  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<TextileSearchController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
            backgroundColor: const Color(0xFF112037),
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF112037), Color(0xFF0B1A2B)],
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 56, 16, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buy & Sell Textile',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Search by category, ad type & city',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Obx(
                    () => Column(
                      children: [
                        FilterDropdown(
                          label: 'Select Category',
                          value: c.selectedCategory.value,
                          items: categories,
                          onChanged: (v) => c.selectedCategory.value = v,
                        ),
                        const SizedBox(height: 10),
                        FilterDropdown(
                          label: 'Select Ad Type',
                          value: c.selectedAdType.value,
                          items: const ['Buyers Post', 'Sellers Post'],
                          onChanged: (v) =>
                              c.selectedAdType.value = v ?? 'Buyers Post',
                        ),
                        const SizedBox(height: 10),
                        FilterDropdown(
                          label: 'Select City',
                          value: c.selectedCity.value,
                          items: cities,
                          onChanged: (v) => c.selectedCity.value = v,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFFBB1943),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final results = c.search();
                              Navigator.of(context).pushNamed(
                                ResultsScreen.routeName,
                                arguments: results,
                              );
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Search'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                'Quick actions',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const ModeChoiceScreen(),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
