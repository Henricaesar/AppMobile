import 'package:flutter/material.dart';
import 'package:inventory/services/api_services.dart';
import 'package:inventory/widgets/loading_indicator.dart';
import 'package:inventory/models/item.dart';
import 'package:inventory/widgets/item_card.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Item>> _items;

  @override
  void initState() {
    super.initState();
    _items = ApiService().getItems();
  }

  void _refreshItems() {
    setState(() {
      _items = ApiService().getItems();
    });
  }

  void _navigateToAddEditScreen(Item? item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditScreen(item: item)),
    );
    if (result == true) {
      _refreshItems();
    }
  }

  void _deleteItem(int id) async {
    await ApiService().deleteItem(id);
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Senjata Kita'),
        backgroundColor: Colors.blue, // Ubah warna latar belakang appbar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Item>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingIndicator();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No items found'));
            } else {
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ItemCard(
                          item: item,
                          onEdit: () => _navigateToAddEditScreen(item),
                          onDelete: () => _deleteItem(item.id),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(null),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Ubah warna background tombol tambah
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Letakkan tombol tambah di tengah
    );
  }
}
