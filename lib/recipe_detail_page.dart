
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/favorites_provider.dart';
import 'package:myapp/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late List<bool> _ingredientChecked;

  double get _progressPercentage {
    if (widget.recipe.ingredients.isEmpty) return 0.0;
    final checkedCount = _ingredientChecked.where((item) => item).length;
    return (checkedCount / _ingredientChecked.length) * 100;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _ingredientChecked = List<bool>.filled(widget.recipe.ingredients.length, false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(widget.recipe);

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              floating: false,
              backgroundColor: innerBoxIsScrolled ? Colors.white : Colors.transparent,
              elevation: innerBoxIsScrolled ? 2.0 : 0.0,
              foregroundColor: innerBoxIsScrolled ? const Color(0xFFFF6B00) : Colors.white,
              title: innerBoxIsScrolled
                  ? Text(widget.recipe.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  : null,
              actions: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: innerBoxIsScrolled ? const Color(0xFFFF6B00) : Colors.white,
                    shadows: !innerBoxIsScrolled ? [const Shadow(color: Colors.black45, blurRadius: 4)] : null,
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54],
                          stops: [0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
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
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildIngredientsTab(),
            _buildStepsTab(),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk konten header (Judul & Info)
  Widget _buildHeaderContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.recipe.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, height: 1.2),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 16.0,
            children: [
              _buildInfoColumn(Icons.star, widget.recipe.rating.toString(), 'Rating'),
              _buildInfoColumn(Icons.timer, '${widget.recipe.cookingTime} min', 'Waktu'),
              _buildInfoColumn(Icons.people_outline, '${widget.recipe.servings} orang', 'Porsi'),
              _buildInfoColumn(Icons.whatshot, widget.recipe.difficulty, 'Kesulitan'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsTab() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        _buildHeaderContent(), // Memanggil header di dalam tab
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bahan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              '${_progressPercentage.toStringAsFixed(0)}% siap',
              style: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...List.generate(widget.recipe.ingredients.length, (index) {
          final ingredient = widget.recipe.ingredients[index];
          final isChecked = _ingredientChecked[index];
          return Card(
            elevation: 0,
            color: isChecked ? Colors.orange.shade50 : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isChecked ? const Color(0xFFFF6B00) : Colors.grey.shade200,
                width: 1.5,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  _ingredientChecked[index] = !isChecked;
                });
              },
              leading: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _ingredientChecked[index] = value ?? false;
                  });
                },
                activeColor: const Color(0xFFFF6B00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: Colors.grey.shade400, width: 2),
              ),
              title: Text(
                ingredient,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isChecked ? FontWeight.normal : FontWeight.w500,
                  decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.black54,
                  decorationThickness: 1.5,
                  color: isChecked ? Colors.grey[600] : Colors.black87,
                ),
              ),
              trailing: isChecked
                  ? Icon(Icons.check_circle, color: const Color(0xFFFF6B00))
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStepsTab() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        _buildHeaderContent(), // Memanggil header di dalam tab
        ...List.generate(widget.recipe.steps.length, (index) {
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
        }),
      ],
    );
  }

  Widget _buildInfoColumn(IconData icon, String value, String label) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 4) - 20,
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
