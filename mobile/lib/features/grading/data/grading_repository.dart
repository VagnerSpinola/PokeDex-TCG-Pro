import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/grading_models.dart';

class GradingRepository {
  GradingRepository(this._dio);

  final Dio _dio;

  Future<GradeEstimate> gradePhoto(List<int> imageBytes, String filename) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageBytes, filename: filename),
    });
    final resp = await _dio.post<Map<String, dynamic>>(
      '/grade',
      data: form,
      options: Options(sendTimeout: const Duration(seconds: 30)),
    );
    return GradeEstimate.fromJson(resp.data!);
  }
}

final gradingRepositoryProvider = Provider<GradingRepository>(
  (ref) => GradingRepository(ref.watch(dioProvider)),
);
