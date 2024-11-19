import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  static late DatabaseReference _dbRef;
  static bool _initialized = false;

  // Private constructor
  FirebaseService._internal();

  // Factory constructor for singleton
  factory FirebaseService() {
    return _instance;
  }

  // Initialize Firebase
  static Future<void> initialize() async {
    if (!_initialized) {
      _dbRef = FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL:
                  'https://classify-x-default-rtdb.asia-southeast1.firebasedatabase.app/')
          .ref();
      _initialized = true;

      print("database connected");
    }
  }

  // Getter for database reference
  DatabaseReference get dbRef => _dbRef;

  // Get a reference for a specific path
  DatabaseReference getReference(String path) {
    return dbRef.child(path);
  }
}
