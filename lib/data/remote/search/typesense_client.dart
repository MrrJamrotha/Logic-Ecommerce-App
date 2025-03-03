import 'package:typesense/typesense.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TypesenseClient {
  // Singleton pattern for a single instance of the client
  static final TypesenseClient _instance = TypesenseClient._internal();

  factory TypesenseClient() {
    return _instance;
  }

  late final Client _client;

  TypesenseClient._internal() {
    // Load environment variables
    final host = dotenv.env['TYPESENSE_HOST'] ?? 'localhost';
    final port = int.tryParse(dotenv.env['TYPESENSE_PORT'] ?? '8108') ?? 8108;
    final protocol = dotenv.env['TYPESENSE_PROTOCOL'] == 'https'
        ? Protocol.https
        : Protocol.http;
    final apiKey = dotenv.env['TYPESENSE_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      throw Exception('TYPESENSE_API_KEY is not set in .env file');
    }

    final config = Configuration(
      apiKey,
      nodes: {
        Node(
          protocol,
          host,
          port: port,
        ),
      },
      numRetries: 3, // A total of 4 tries (1 original try + 3 retries)
      connectionTimeout: const Duration(seconds: 2),
    );

    _client = Client(config);
  }

  Client get client => _client;

  // Perform search query
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final searchParameters = {
      'q': query,
      'query_by': 'name,name_2',
    };

    try {
      final response = await _client
          .collection('products_index')
          .documents
          .search(searchParameters);
      return List<Map<String, dynamic>>.from(
          response['hits'].map((hit) => hit['document']));
    } catch (e) {
      return [];
    }
  }
}
