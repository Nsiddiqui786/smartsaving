import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class StorageService {
  static const _userKey = 'smart_saving_user';
  static const _tokenKey = 'smart_saving_token';
  static const _trackedProductsKey = 'smart_saving_tracked_products';

  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User management
  Future<void> saveUser(User user, String token) async {
    await _prefs.setString(_userKey, jsonEncode(user.toJson()));
    await _prefs.setString(_tokenKey, token);
  }

  User? getUser() {
    final json = _prefs.getString(_userKey);
    if (json == null) return null;
    try {
      return User.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
    await _prefs.remove(_tokenKey);
  }

  // Tracked products
  Future<void> saveTrackedProducts(List<String> productIds) async {
    await _prefs.setStringList(_trackedProductsKey, productIds);
  }

  List<String> getTrackedProducts() {
    return _prefs.getStringList(_trackedProductsKey) ?? [];
  }

  Future<void> addTrackedProduct(String productId) async {
    final products = getTrackedProducts();
    if (!products.contains(productId)) {
      products.add(productId);
      await saveTrackedProducts(products);
    }
  }

  Future<void> removeTrackedProduct(String productId) async {
    final products = getTrackedProducts();
    products.remove(productId);
    await saveTrackedProducts(products);
  }

  bool isProductTracked(String productId) {
    return getTrackedProducts().contains(productId);
  }

  // Generic key-value storage
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}

final storageService = StorageService();
