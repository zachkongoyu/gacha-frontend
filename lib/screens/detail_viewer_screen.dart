import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class DetailViewerScreen extends ConsumerWidget {
  final String itemId;

  const DetailViewerScreen({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample GLB model URL (using a public test model)
    const modelUrl = 'https://modelviewer.dev/shared-assets/models/Astronaut.glb';

    // Stub item details
    final itemDetails = {
      '1': {'name': 'Sword of Light', 'rarity': 'SSR', 'description': 'A legendary sword that glows with divine light.'},
      '2': {'name': 'Magic Staff', 'rarity': 'SR', 'description': 'A powerful staff imbued with arcane energy.'},
      '3': {'name': 'Ancient Shield', 'rarity': 'SR', 'description': 'A shield that has protected heroes for centuries.'},
      '4': {'name': 'Iron Helmet', 'rarity': 'R', 'description': 'A sturdy helmet made of iron.'},
      '5': {'name': 'Leather Boots', 'rarity': 'R', 'description': 'Comfortable boots for long journeys.'},
      '6': {'name': 'Health Potion', 'rarity': 'N', 'description': 'Restores a small amount of health.'},
    };

    final item = itemDetails[itemId] ?? {
      'name': 'Unknown Item',
      'rarity': 'N',
      'description': 'No description available.',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(item['name'] as String),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/inventory');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3D Model Viewer
            Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ModelViewer(
                  src: modelUrl,
                  alt: '3D model of ${item['name']}',
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
            ),
            // Item Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'] as String,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      _RarityBadge(rarity: item['rarity'] as String),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['description'] as String,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('AR view coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.view_in_ar),
                        label: const Text('View in AR'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Share feature coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RarityBadge extends StatelessWidget {
  final String rarity;

  const _RarityBadge({required this.rarity});

  Color _getRarityColor() {
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: _getRarityColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        rarity,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
