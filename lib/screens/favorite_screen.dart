import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'product_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('products').listenable(),
        builder: (context, box, child) {
          if (box.length == 0) {
            return const Center(
              child: Text("You don't have any favorite product 💔"),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final p = box.getAt(index);
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(data: p),
                    ),
                  );
                },
                minVerticalPadding: 24,
                leading: Image.network(p['image'], width: 64),
                title: Text(
                  p['title'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await box.deleteAt(index);
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.deepOrange,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
