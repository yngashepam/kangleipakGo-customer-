import '../models/product.dart';

const categories = [
  ('Groceries', '🛒'),
  ('Snacks', '🍿'),
  ('Cosmetics', '💄'),
  ('Medicines', '💊'),
];

const products = <Product>[
  Product(id: '1', name: 'Rice', category: 'Groceries', price: 65, unit: '1 kg', emoji: '🍚'),
  Product(id: '2', name: 'Potato Chips', category: 'Snacks', price: 30, unit: '1 pack', emoji: '🥔'),
  Product(id: '3', name: 'Face Wash', category: 'Cosmetics', price: 199, unit: '100 ml', emoji: '🧴'),
  Product(id: '4', name: 'Paracetamol', category: 'Medicines', price: 25, unit: '10 tablets', emoji: '💊'),
  Product(id: '5', name: 'Milk', category: 'Groceries', price: 35, unit: '500 ml', emoji: '🥛'),
  Product(id: '6', name: 'Chocolate', category: 'Snacks', price: 50, unit: '1 bar', emoji: '🍫'),
];
