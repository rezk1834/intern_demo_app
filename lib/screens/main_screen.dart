import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../repositories/item_repository.dart';
import 'detail_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ItemRepository _itemRepository = ItemRepository();
  List<Item> _items = [];
  List<Item> _filteredItems = [];
  bool _isLoading = true;
  bool _hasMoreItems = true;
  int _currentPage = 1;
  final int _itemsPerPage = 20;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    if (!_hasMoreItems) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final items = await _itemRepository.fetchItems(page: _currentPage, limit: _itemsPerPage);
      setState(() {
        _currentPage++;
        if (items.isEmpty) {
          _hasMoreItems = false;
        }
        _items.addAll(items);
        _filteredItems = _applySearchFilter(_items);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load items')),
      );
    }
  }

  List<Item> _applySearchFilter(List<Item> items) {
    if (_searchQuery.isEmpty) {
      return items;
    }
    return items.where((item) => item.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).primaryColor, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                    _filteredItems = _applySearchFilter(_items);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search items...',
                  prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                    _fetchItems();
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: _filteredItems.length + (_hasMoreItems ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _filteredItems.length) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final item = _filteredItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(item: item),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: NetworkImage(
                                'https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png',
                              ),
                            ),
                            title: Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Details about ${item.title}",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
