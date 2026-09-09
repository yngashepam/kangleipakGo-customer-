import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, int> _cart = {};
  final TextEditingController _search = TextEditingController();
  String? _category;
  int _tab = 0;

  int get cartCount => _cart.values.fold(0, (a, b) => a + b);

  List<Product> get filteredProducts => products.where((p) {
        final q = _search.text.toLowerCase();
        return (_category == null || p.category == _category) &&
            (q.isEmpty || p.name.toLowerCase().contains(q));
      }).toList();

  void _add(Product p) {
    setState(() => _cart[p.id] = (_cart[p.id] ?? 0) + 1);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${p.name} added to cart'),
      duration: const Duration(milliseconds: 700),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header()),
            SliverToBoxAdapter(child: _searchBox()),
            SliverToBoxAdapter(child: _deliveryBox()),
            SliverToBoxAdapter(child: _banner()),
            SliverToBoxAdapter(child: _sectionTitle('Shop by category', 'View all')),
            SliverToBoxAdapter(child: _categories()),
            SliverToBoxAdapter(child: _sectionTitle('Popular products', 'View all')),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _productCard(filteredProducts[i]),
                  childCount: filteredProducts.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .68,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          const NavigationDestination(icon: Icon(Icons.grid_view_outlined), label: 'Categories'),
          NavigationDestination(icon: Badge(isLabelVisible: cartCount > 0, label: Text('$cartCount'), child: const Icon(Icons.shopping_cart_outlined)), label: 'Cart'),
          const NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Orders'),
          const NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }

  Widget _header() => Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        child: Row(children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(color: const Color(0xFFE8F3EA), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.shopping_basket_outlined, color: Color(0xFF176B3A), size: 28),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: 'Kangleipak', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF123D29))),
              TextSpan(text: 'Go', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF36A852))),
            ])),
            Text('Local needs • Delivered', style: TextStyle(fontSize: 11, color: Color(0xFF557064))),
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded, size: 28)),
          const CircleAvatar(backgroundColor: Color(0xFFE8F3EA), child: Icon(Icons.person_outline, color: Color(0xFF176B3A))),
        ]),
      );

  Widget _searchBox() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: TextField(
          controller: _search,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search products, brands and more...',
            prefixIcon: const Icon(Icons.search, size: 28),
            suffixIcon: _search.text.isEmpty ? null : IconButton(onPressed: () { _search.clear(); setState(() {}); }, icon: const Icon(Icons.close)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      );

  Widget _deliveryBox() => Container(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Row(children: [
          const Icon(Icons.location_on, color: Color(0xFF176B3A), size: 30),
          const SizedBox(width: 10),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Deliver to', style: TextStyle(fontSize: 12, color: Colors.grey)), Text('795001', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFEAF6E9), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.check_circle, color: Color(0xFF2F9E44), size: 20), SizedBox(width: 5), Text('Service available', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))])),
        ]),
      );

  Widget _banner() => Container(
        height: 175,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF123D29), Color(0xFF3A9B55)]),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('YOUR LOCAL MARKET', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
          const SizedBox(height: 7),
          const Text('Everything you need,\nright at your doorstep.', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800, height: 1.1)),
          const Spacer(),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF176B3A), shape: const StadiumBorder()), child: const Text('Shop Now')),
        ]),
      );

  Widget _sectionTitle(String title, String action) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
        child: Row(children: [Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)), const Spacer(), Text(action, style: const TextStyle(color: Color(0xFF176B3A), fontWeight: FontWeight.w600))]),
      );

  Widget _categories() => SizedBox(
        height: 112,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) {
            final c = categories[i];
            final selected = _category == c.$1;
            return GestureDetector(
              onTap: () => setState(() => _category = selected ? null : c.$1),
              child: Container(width: 88, padding: const EdgeInsets.all(9), decoration: BoxDecoration(color: selected ? const Color(0xFFDDF2E2) : Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: selected ? const Color(0xFF2F9E44) : Colors.transparent)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(c.$2, style: const TextStyle(fontSize: 30)), const SizedBox(height: 6), Text(c.$1, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))])),
            );
          },
        ),
      );

  Widget _productCard(Product p) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE6ECE7))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 58)))),
          Text(p.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          Text(p.unit, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 5),
          Text('₹${p.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          SizedBox(width: double.infinity, height: 38, child: ElevatedButton.icon(onPressed: () => _add(p), icon: const Icon(Icons.add_shopping_cart, size: 17), label: const Text('Add'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF176B3A), foregroundColor: Colors.white, shape: const StadiumBorder()))),
        ]),
      );
}
