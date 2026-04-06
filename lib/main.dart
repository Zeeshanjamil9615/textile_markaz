import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textile_markaz/app/theme/app_theme.dart';
import 'package:textile_markaz/screens/category_grid_screen.dart';
import 'package:textile_markaz/screens/home_search_screen.dart';
import 'package:textile_markaz/screens/mode_choice_screen.dart';
import 'package:textile_markaz/screens/post_ad_screen.dart';
import 'package:textile_markaz/screens/results_screen.dart';
import 'package:textile_markaz/controllers/textile_search_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TextileSearchController(), permanent: true);
  runApp(const TextileMarkazApp());
}


class TextileMarkazApp extends StatelessWidget {
  const TextileMarkazApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Textile Markaz',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: HomeSearchScreen.routeName,
      routes: {
        HomeSearchScreen.routeName: (_) => const HomeSearchScreen(),
        ResultsScreen.routeName: (_) => const ResultsScreen(),
        ModeChoiceScreen.routeName: (_) => const ModeChoiceScreen(),
        CategoryGridScreen.routeName: (_) => const CategoryGridScreen(),
        PostAdScreen.routeName: (_) => const PostAdScreen(),
      },
    );
  }
}
