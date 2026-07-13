import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/router.dart';
import 'core/storage/token_storage.dart';
import 'core/theme.dart';
import 'features/cards/data/cards_repository.dart';
import 'features/collection/data/collection_local_store.dart';
import 'features/collection/data/collection_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>(TokenStorage.boxName);
  await Hive.openBox<String>(CardsRepository.cacheBoxName);
  final localStore = await CollectionLocalStore.open();

  runApp(
    ProviderScope(
      overrides: [collectionLocalStoreProvider.overrideWithValue(localStore)],
      child: const PokedexApp(),
    ),
  );
}

class PokedexApp extends ConsumerWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'PokeDex TCG Pro',
      theme: appTheme,
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
