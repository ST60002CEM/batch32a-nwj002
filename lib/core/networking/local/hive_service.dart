import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Hive Adapters
    // Hive.registerAdapter(AuthHiveModelAdapter());
  }
}
