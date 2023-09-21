import 'package:flutter/material.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'core/injection_container.dart';
import 'features/daily_news/presentation/pages/home/daily_news.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      home: const DailyNews(),
    );
  }
}
