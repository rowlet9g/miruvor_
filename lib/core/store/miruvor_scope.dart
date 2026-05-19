import 'package:flutter/widgets.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

class MiruvorScope extends InheritedNotifier<MiruvorStore> {
  const MiruvorScope({
    required MiruvorStore store,
    required super.child,
    super.key,
  }) : super(notifier: store);

  static MiruvorStore of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MiruvorScope>();
    assert(scope != null, 'MiruvorScope was not found in the widget tree.');
    return scope!.notifier!;
  }
}
