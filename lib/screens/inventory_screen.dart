import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stub inventory items
    final inventoryItems = [
      {'id': '1', 'name': 'Sword of Light', 'rarity': 'SSR'},
      {'id': '2', 'name': 'Magic Staff', 'rarity': 'SR'},
      {'id': '3', 'name': 'Ancient Shield', 'rarity': 'SR'},
      {'id': '4', 'name': 'Iron Helmet', 'rarity': 'R'},
      {'id': '5', 'name': 'Leather Boots', 'rarity': 'R'},
      {'id': '6', 'name': 'Health Potion', 'rarity': 'N'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/banners');
          },
        ),
      ),
      body: inventoryItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your inventory is empty',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: inventoryItems.length,
              itemBuilder: (context, index) {
                final item = inventoryItems[index];
                return _InventoryItemCard(
                  item: item,
                  onTap: () {
                    context.go('/detail/${item['id']}');
                  },
                );
              },
            ),
    );
  }
}

class _InventoryItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;

  const _InventoryItemCard({
    required this.item,
    required this.onTap,
  });

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'SSR':
        return Colors.amber;
      case 'SR':
        return Colors.purple;
      case 'R':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rarityColor = _getRarityColor(item['rarity'] as String);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: rarityColor,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: rarityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.category,
                  size: 48,
                  color: rarityColor,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item['name'] as String,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: rarityColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item['rarity'] as String,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
