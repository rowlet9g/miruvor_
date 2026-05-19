import 'package:flutter/material.dart';
import 'package:miruvor/core/sample/sample_data.dart';
import 'package:miruvor/core/utils/formatters.dart';

class TastingNotesPage extends StatelessWidget {
  const TastingNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: sampleTastingNotes.length + 1,
      separatorBuilder: (_, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('테이스팅 노트 추가'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const _AddTastingNotePage(),
                ),
              );
            },
          );
        }

        final note = sampleTastingNotes[index - 1];
        final wine = sampleWines.firstWhere((wine) => wine.id == note.wineId);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${wine.name} ${wine.displayVintage}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text('${formatDate(note.tastedAt)} · ${note.rating} / 5.0'),
                const SizedBox(height: 12),
                if (note.aroma != null) Text('Aroma: ${note.aroma}'),
                if (note.palate != null) ...[
                  const SizedBox(height: 6),
                  Text('Palate: ${note.palate}'),
                ],
                if (note.pairing != null) ...[
                  const SizedBox(height: 6),
                  Text('Pairing: ${note.pairing}'),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddTastingNotePage extends StatelessWidget {
  const _AddTastingNotePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Tasting Note')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.add_a_photo_outlined, size: 34),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: '와인')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: '페어링 음식')),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: '향'),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: '맛'),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: '메모'),
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            icon: const Icon(Icons.save_outlined),
            label: const Text('저장'),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('로컬 저장소 연결 예정')));
            },
          ),
        ],
      ),
    );
  }
}
