import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/cards/presentation/card_detail_screen.dart';
import '../features/cards/presentation/cards_screen.dart';
import '../features/collection/presentation/collection_screen.dart';
import '../features/grading/presentation/grading_screen.dart';
import '../features/scanner/presentation/scan_screen.dart';

// Auth is temporarily out of the app flow (user decision, 2026-07-13): the app
// opens straight on the cards screen and the backend treats anonymous requests
// as a local default user. The auth feature code stays in lib/features/auth
// for when login returns.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/cards',
    routes: [
      GoRoute(path: '/cards', builder: (_, _) => const CardsScreen()),
      GoRoute(
        path: '/cards/:id',
        builder: (_, state) => CardDetailScreen(cardId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/collection', builder: (_, _) => const CollectionScreen()),
      GoRoute(path: '/scan', builder: (_, _) => const ScanScreen()),
      GoRoute(path: '/grade', builder: (_, _) => const GradingScreen()),
    ],
  );
});
