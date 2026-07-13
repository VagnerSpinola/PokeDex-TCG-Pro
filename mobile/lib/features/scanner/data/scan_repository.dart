import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/scan_models.dart';

class ScanRepository {
  ScanRepository(this._dio);

  final Dio _dio;

  Future<ScanResult> scanPhoto(List<int> imageBytes, String filename) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageBytes, filename: filename),
    });
    final resp = await _dio.post<Map<String, dynamic>>(
      '/scan',
      data: form,
      options: Options(sendTimeout: const Duration(seconds: 30)),
    );
    return ScanResult.fromJson(resp.data!);
  }
}

final scanRepositoryProvider = Provider<ScanRepository>(
  (ref) => ScanRepository(ref.watch(dioProvider)),
);
