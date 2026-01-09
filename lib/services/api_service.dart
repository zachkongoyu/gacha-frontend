import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// HTTP client provider configured with API base URL from dart-define
final dioProvider = Provider<Dio>((ref) {
  const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000',
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add logging interceptor in debug mode
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
});

/// API service provider for making HTTP requests
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  /// Fetch banners from the API
  Future<List<dynamic>> fetchBanners() async {
    try {
      final response = await _dio.get('/banners');
      return response.data as List<dynamic>;
    } catch (e) {
      // Return empty list on error for stub
      return [];
    }
  }

  /// Fetch inventory items from the API
  Future<List<dynamic>> fetchInventory() async {
    try {
      final response = await _dio.get('/inventory');
      return response.data as List<dynamic>;
    } catch (e) {
      // Return empty list on error for stub
      return [];
    }
  }

  /// Fetch item details from the API
  Future<Map<String, dynamic>?> fetchItemDetails(String itemId) async {
    try {
      final response = await _dio.get('/items/$itemId');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      // Return null on error for stub
      return null;
    }
  }
}
