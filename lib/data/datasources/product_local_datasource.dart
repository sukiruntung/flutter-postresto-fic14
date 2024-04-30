import 'package:resto_fic14/data/models/response/product_response_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalDataSource {
  ProductLocalDataSource._init();
  static final ProductLocalDataSource instance = ProductLocalDataSource._init();

  final String tableProduct = 'products';
  static Database? _database;
// "id": 1,
//                 "categories_id": 2,
//                 "name": "Maximo Reilly",
//                 "description": "Quibusdam non rem beatae praesentium. Sit ducimus exercitationem aspernatur.",
//                 "image": "C:\\Users\\lenovo\\AppData\\Local\\Temp\\16fa2ea388650cfb5236f4e3bd00d67c.png",
//                 "price": "10000.00",
//                 "stock": 92,
//                 "status": 0,
//                 "is_favorite": 1,
//                 "created_at": "2024-04-18T09:38:44.000000Z",
//                 "updated_at": "2024-04-19T04:46:29.000000Z",
//                 "deleted_at": null
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
create table $tableProduct(
  id integer primary key,
  products_id integer,
  categories_id integer,
  categories_name text,
  name text,
  description text,
  image text,
  price text,
  stock integer,
  status integer,
  is_favorite integer, 
  created_at text,
  updated_at text,
  deleted_at text
)
''');
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // create a new database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dbresto14.db');
    return _database!;
  }

//insert  product
  Future<void> insertProduct(Product product) async {
    final db = await instance.database;
    await db.insert(tableProduct, product.toLocalMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

//insert list of product
  Future<void> insertProducts(List<Product> products) async {
    final db = await instance.database;
    for (var product in products) {
      await db.insert(tableProduct, product.toLocalMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print('insert successfully ${product.name}');
    }
  }

// get all the products
  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableProduct);
    return List.generate(maps.length, (i) {
      return Product.fromLocalMap(maps[i]);
    });
  }

  // delete product all
  Future<void> deleteAllProduct() async {
    final db = await instance.database;
    //   final sql = 'DROP TABLE IF EXISTS $tableProduct';
    // await db.execute(sql);
    await db.delete(tableProduct);
  }
}
