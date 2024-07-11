<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventory/models/item.dart';


class ApiService {
  final String apiUrl = "http://10.0.2.2/crud_api/api.php"; // Sesuaikan dengan URL API Anda
=======
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:inventory/models/item.dart';

class ApiService {
  final String apiUrl = "API"; // URL API
>>>>>>> f339b0bd9b49d784d7662b1ad17cfdc99e1af99b

  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> createItem(Item item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<void> updateItem(Item item) async {
    final response = await http.put(
<<<<<<< HEAD
      Uri.parse("$apiUrl?id=${item.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode != 200) {
=======
      Uri.parse("$apiUrl/${item.id}"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode != 204) {
      print('Item updated successfully');}
      else{
>>>>>>> f339b0bd9b49d784d7662b1ad17cfdc99e1af99b
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
<<<<<<< HEAD
      Uri.parse("$apiUrl?id=$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 200) {
=======
      Uri.parse("$apiUrl/$id"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode != 204) {
>>>>>>> f339b0bd9b49d784d7662b1ad17cfdc99e1af99b
      throw Exception('Failed to delete item');
    }
  }
}
