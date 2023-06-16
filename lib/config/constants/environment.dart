import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbApiKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? "No existe API Key";
}
