import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/grading_models.dart';

class GradingRepository {
  GradingRepository(this._dio);

  final Dio _dio;

  Future<GradeEstimate> gradePhoto(
    List<int> imageBytes,
    String filename, {
    List<int>? backBytes,
    String? backFilename,
  }) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageBytes, filename: filename),
      if (backBytes != null)
        'back': MultipartFile.fromBytes(backBytes, filename: backFilename ?? 'back.jpg'),
    });
    final resp = await _dio.post<Map<String, dynamic>>(
      '/grade',
      data: form,
      options: Options(sendTimeout: const Duration(seconds: 60)),
    );
    return GradeEstimate.fromJson(resp.data!);
  }

  Future<GradeEstimate> gradeVideo(List<int> videoBytes, String filename) async {
    final form = FormData.fromMap({
      'file': MultipartFile.fromBytes(videoBytes, filename: filename),
    });
    final resp = await _dio.post<Map<String, dynamic>>(
      '/grade/video',
      data: form,
      options: Options(
        sendTimeout: const Duration(minutes: 3),
        receiveTimeout: const Duration(minutes: 3),
      ),
    );
    return GradeEstimate.fromJson(resp.data!);
  }
}

final gradingRepositoryProvider = Provider<GradingRepository>(
  (ref) => GradingRepository(ref.watch(dioProvider)),
);
