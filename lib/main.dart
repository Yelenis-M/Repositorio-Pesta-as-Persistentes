import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

// Widget raíz que inicializa la aplicación con GoRouter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pestañas Persistentes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter, // Aquí conectamos tu appRouter
      debugShowCheckedModeBanner: false,
    );
  }
}

// TU CÓDIGO: Configuración de rutas
final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [                                
        StatefulShellBranch(routes: [            // Pestaña 1: Inicio
          GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [            // Pestaña 2: Favoritos
          GoRoute(path: '/favorites', builder: (_, _) => const FavoritesScreen()),
        ]),
      ],
    ),
  ],
);

// TU CÓDIGO: Estructura base con la barra de navegación
class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,                     // Muestra la pestaña activa
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,   // Pestaña resaltada
        onDestinationSelected: (i) => navigationShell.goBranch(
          i,                                           // Cambia a la rama seleccionada
          initialLocation: i == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoritos'),
        ],
      ),
    );
  }
}

// --- PANTALLAS FALTANTES ---

// Pantalla de Inicio
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: const Center(
        child: Text(
          'Estás en la pestaña Inicio',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Pantalla de Favoritos
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const Center(
        child: Text(
          'Estás en la pestaña Favoritos',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}