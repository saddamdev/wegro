import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic data;
  const ProductDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data['image']),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Rating: ${data['rating']['rate'].toString()}',
                  style: const TextStyle(color: Colors.orange, fontSize: 16),
                ),
                Text(
                  'Sold: ${data['rating']['count'].toString()}',
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                ),
                Text(
                  'Price: ${data['price'].toString()}',
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              data['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${data['category']}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                data['description'],
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final box = Hive.box('products');
                box.put(data['id'], data);
                const snackBar =
                    SnackBar(content: Text('Saved as favorite 💖'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 18),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const StadiumBorder(),
              ),
              child: const Text('Save as Favorite'),
            ),
          ],
        ),
      ),
    );
  }
}
