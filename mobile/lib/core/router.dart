import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/auth_notifier.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/cards/presentation/card_detail_screen.dart';
import '../features/cards/presentation/cards_screen.dart';
import '../features/collection/presentation/collection_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/cards',
    redirect: (context, state) {
      final loggingIn =
          state.matchedLocation == '/login' || state.matchedLocation == '/register';
      return switch (authState) {
        AuthUnknown() => '/splash',
        AuthLoggedOut() => loggingIn ? null : '/login',
        AuthLoggedIn() =>
          (loggingIn || state.matchedLocation == '/splash') ? '/cards' : null,
      };
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
      GoRoute(path: '/cards', builder: (_, _) => const CardsScreen()),
      GoRoute(
        path: '/cards/:id',
        builder: (_, state) => CardDetailScreen(cardId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/collection', builder: (_, _) => const CollectionScreen()),
    ],
  );
});
