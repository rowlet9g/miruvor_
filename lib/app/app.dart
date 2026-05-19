import 'package:flutter/material.dart';
import 'package:miruvor/app/theme.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/store/miruvor_scope.dart';
import 'package:miruvor/core/store/miruvor_store.dart';
import 'package:miruvor/features/home/presentation/home_shell.dart';

class MiruvorApp extends StatefulWidget {
  const MiruvorApp({
    this.store,
    super.key,
  });

  final MiruvorStore? store;

  @override
  State<MiruvorApp> createState() => _MiruvorAppState();
}

class _MiruvorAppState extends State<MiruvorApp> {
  late final MiruvorStore _store;
  late final bool _ownsStore;

  @override
  void initState() {
    super.initState();
    _ownsStore = widget.store == null;
    _store = widget.store ?? MiruvorStore(database: AppDatabase());
  }

  @override
  void dispose() {
    if (_ownsStore) {
      _store.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MiruvorScope(
      store: _store,
      child: MaterialApp(
        title: 'Miruvor',
        debugShowCheckedModeBanner: false,
        theme: buildMiruvorTheme(),
        home: const HomeShell(),
      ),
    );
  }
}
