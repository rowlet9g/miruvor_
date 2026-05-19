import 'package:flutter/material.dart';

class AddWinePage extends StatelessWidget {
  const AddWinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Wine')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.add_a_photo_outlined, size: 36),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: '이름')),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: '생산자')),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: '빈티지'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          const TextField(decoration: InputDecoration(labelText: '포도 품종')),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: '구매 가격'),
            keyboardType: TextInputType.number,
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
