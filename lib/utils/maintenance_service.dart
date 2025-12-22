import 'package:dio/dio.dart';
import 'path/environment.dart';

const String defaultMaintenanceMessage =
    'Saat ini sedang ada pemeliharaan sistem di Jet Market untuk meningkatkan layanan agar lebih optimal';

class MaintenanceInfo {
  final bool isMaintenance; 
  final String message;

  const MaintenanceInfo({required this.isMaintenance, required this.message});
}

class MaintenanceService {
  Future<MaintenanceInfo> fetchStatus(String jenisAplikasi) async {
    try {
      final dio = Dio(BaseOptions(
        baseUrl: kBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ));

      final response = await dio.get(
        'maintenance_settings',
        queryParameters: {'jenis_aplikasi': jenisAplikasi},
      );

      final data = response.data is Map<String, dynamic>
          ? response.data['data'] as Map<String, dynamic>?
          : null;

      final status =
          (data?['status'] ?? 'active').toString().toLowerCase().trim();
      final message = (data?['message'] ?? defaultMaintenanceMessage).toString();

      return MaintenanceInfo(
        isMaintenance: status == 'maintenance',
        message: message,
      );
    } catch (_) {
      return const MaintenanceInfo(
        isMaintenance: false,
        message: defaultMaintenanceMessage,
      );
    }
  }
}
