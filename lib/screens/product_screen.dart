import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:product/screens/product_detail_screen.dart';
import '../provider/theme_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List productList = [];

  Future<void> getData() async {
    final url = Uri.parse('https://fakestoreapi.com/products');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() => productList = data);
    } else {
      // ignore: avoid_print
      print(res.statusCode);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              provider.toggleTheme();
            },
            icon: provider.theme == ThemeData.dark()
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: productList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: productList.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final p = productList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(data: p),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: provider.theme == ThemeData.dark()
                          ? Colors.grey.shade900
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2,
                          offset: Offset(0, 1), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(p['image']),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Price: ${p['price'].toString()}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
