import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/favorites_provider.dart';
import 'package:myapp/recipe_model.dart';

// Mengubah state menjadi TickerProviderStateMixin untuk TabController
class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final TabController _tabController;
  bool _isAppBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this); // Inisialisasi TabController
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients && _scrollController.offset > 200 && !_isAppBarCollapsed) {
      setState(() {
        _isAppBarCollapsed = true;
      });
    } else if (_scrollController.hasClients && _scrollController.offset <= 200 && _isAppBarCollapsed) {
      setState(() {
        _isAppBarCollapsed = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose(); // Jangan lupa dispose TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(widget.recipe);

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang utama putih
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: _isAppBarCollapsed ? Colors.white : Colors.transparent,
            elevation: _isAppBarCollapsed ? 2.0 : 0.0,
            foregroundColor: _isAppBarCollapsed ? const Color(0xFFFF6B00) : Colors.white,
            title: _isAppBarCollapsed
                ? Text(widget.recipe.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                : null,
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isAppBarCollapsed ? const Color(0xFFFF6B00) : Colors.white,
                  shadows: !_isAppBarCollapsed ? [const Shadow(color: Colors.black45, blurRadius: 4)] : null,
                ),
                onPressed: () {
                  favoritesProvider.toggleFavorite(widget.recipe);
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFF47A46),
                        child: const Center(child: Icon(Icons.restaurant_menu, color: Colors.white, size: 50)),
                      );
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                        stops: [0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Konten utama dalam desain "sheet"
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, height: 1.2),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween, // Distribusi merata
                      runSpacing: 16.0,
                      children: [
                        _buildInfoColumn(Icons.star, widget.recipe.rating.toString(), 'Rating'),
                        _buildInfoColumn(Icons.timer, '${widget.recipe.cookingTime} min', 'Waktu'),
                        _buildInfoColumn(Icons.people_outline, '${widget.recipe.servings} orang', 'Porsi'),
                        _buildInfoColumn(Icons.whatshot, widget.recipe.difficulty, 'Kesulitan'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // === TAB BAR ===
                    TabBar(
                      controller: _tabController,
                      labelColor: const Color(0xFFFF6B00),
                      unselectedLabelColor: Colors.grey[600],
                      indicatorColor: const Color(0xFFFF6B00),
                      indicatorWeight: 3.0,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      tabs: const [
                        Tab(text: 'Bahan-bahan'),
                        Tab(text: 'Langkah-langkah'),
                      ],
                    ),
                    // === KONTEN TAB ===
                    SizedBox(
                      height: 400, // Beri tinggi tetap untuk konten tab
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // --- Konten Tab Bahan ---
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            itemCount: widget.recipe.ingredients.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check, color: Color(0xFFFF6B00), size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(widget.recipe.ingredients[index], style: const TextStyle(fontSize: 16))),
                                  ],
                                ),
                              );
                            },
                          ),
                          // --- Konten Tab Langkah ---
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            itemCount: widget.recipe.steps.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFFFF6B00),
                                      radius: 14,
                                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(widget.recipe.steps[index], style: const TextStyle(fontSize: 16, height: 1.4))),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String value, String label) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 4) - 20, // Lebar dinamis
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFFF6B00), size: 28),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
        ],
      ),
    );
  }
}
