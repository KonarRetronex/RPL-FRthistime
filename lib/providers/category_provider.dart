import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart'; // Untuk enum TransactionType

class CategoryProvider with ChangeNotifier {
  final Box<CategoryModel> _categoryBox = Hive.box('categories');
  final Uuid _uuid = const Uuid();

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  CategoryProvider() {
    loadCategories();
  }

  void loadCategories() {
    _categories = _categoryBox.values.toList().cast<CategoryModel>();
    // Tambah kategori default jika kosong
    if (_categories.isEmpty) {
      _addDefaultCategories();
    }
    notifyListeners();
  }

  Future<void> _addDefaultCategories() async {
    final defaultCategories = [
      CategoryModel(id: _uuid.v4(), name: 'Gaji', type: TransactionType.income),
      CategoryModel(id: _uuid.v4(), name: 'Investasi', type: TransactionType.income),
      CategoryModel(id: _uuid.v4(), name: 'Makanan', type: TransactionType.expense),
      CategoryModel(id: _uuid.v4(), name: 'Transportasi', type: TransactionType.expense),
      CategoryModel(id: _uuid.v4(), name: 'Tagihan', type: TransactionType.expense),
    ];

    for (var cat in defaultCategories) {
      await _categoryBox.put(cat.id, cat);
    }
    loadCategories(); // Muat ulang setelah menambah
  }
  
  Future<void> addCategory(String name, TransactionType type) async {
    final newCategory = CategoryModel(
      id: _uuid.v4(),
      name: name,
      type: type,
    );
    await _categoryBox.put(newCategory.id, newCategory);
    loadCategories();
  }

  CategoryModel getCategoryById(String id) {
    return _categories.firstWhere((cat) => cat.id == id,
        orElse: () => CategoryModel(id: 'default', name: 'Lainnya', type: TransactionType.expense));
  }

  List<CategoryModel> get incomeCategories =>
      _categories.where((cat) => cat.type == TransactionType.income).toList();

  List<CategoryModel> get expenseCategories =>
      _categories.where((cat) => cat.type == TransactionType.expense).toList();
}