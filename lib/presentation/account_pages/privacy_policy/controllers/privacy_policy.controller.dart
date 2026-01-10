import 'package:get/get.dart';
import '../../../../infrastructure/dal/daos/provider/remote/remote_provider.dart';

class PrivacyPolicyController extends GetxController {
  String htmlContent = '';
  bool isLoading = true;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      final response = await RemoteProvider.get(path: '/privacy-policy');

      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['data'] != null) {
          htmlContent = data['data']['content'] ?? '';
        }
      } else {
        errorMessage = 'Gagal memuat Privacy Policy';
      }

      isLoading = false;
      update();
    } catch (e) {
      errorMessage = 'Gagal memuat Privacy Policy';
      isLoading = false;
      update();
    }
  }

  Future<void> refreshData() async {
    await fetchPrivacyPolicy();
  }
}
