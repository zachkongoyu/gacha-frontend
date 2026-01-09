import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/banners_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/detail_viewer_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  runApp(
    const ProviderScope(
      child: GachaApp(),
    ),
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/banners',
    routes: [
      GoRoute(
        path: '/banners',
        name: 'banners',
        builder: (context, state) => const BannersScreen(),
      ),
      GoRoute(
        path: '/inventory',
        name: 'inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/detail/:itemId',
        name: 'detail',
        builder: (context, state) {
          final itemId = state.pathParameters['itemId'] ?? '';
          return DetailViewerScreen(itemId: itemId);
        },
      ),
    ],
  );
});

class GachaApp extends ConsumerWidget {
  const GachaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Gacha App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
