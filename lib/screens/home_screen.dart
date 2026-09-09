import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, int> _cart = {};
  String _query = '';
  String? _category;

  int get cartCount => _cart.values.fold(0, (a, b) => a + b);

  List<Product> get filteredProducts => products.where((p) {
    final categoryMatch = _category == null || p.category == _category;
    final queryMatch = p.name.toLowerCase().contains(_query.toLowerCase());
    return categoryMatch && queryMatch;
  }).toList();

  void _add(Product product) {
    setState(() => _cart[product.id] = (_cart[product.id] ?? 0) + 1);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} added to cart'), duration: const Duration(milliseconds: 700)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('KangleipakGo', style: TextStyle(fontWeight: FontWeight.w800)),
            Text('Delivering in 795001', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Badge(
              label: Text('$cartCount'),
              isLabelVisible: cartCount > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 8),
                          Expanded(child: Text('Now delivering in Imphal — PIN 795001')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SearchBar(
                      hintText: 'Search groceries, snacks, cosmetics…',
                      leading: const Icon(Icons.search),
                      onChanged: (value) => setState(() => _query = value),
                    ),
                    const SizedBox(height: 20),
                    const Text('Shop by category', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 92,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final item = categories[index];
                          final selected = _category == item.$1;
                          return ChoiceChip(
                            selected: selected,
                            label: SizedBox(
                              width: 76,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item.$2, style: const TextStyle(fontSize: 28)),
                                  const SizedBox(height: 4),
                                  Text(item.$1, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            onSelected: (_) => setState(() => _category = selected ? null : item.$1),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Expanded(child: Text('Popular products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800))),
                        if (_category != null)
                          TextButton(onPressed: () => setState(() => _category = null), child: const Text('Clear')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverGrid.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 260,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) => ProductCard(product: filteredProducts[index], onAdd: () => _add(filteredProducts[index])),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.grid_view_outlined), label: 'Categories'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}
