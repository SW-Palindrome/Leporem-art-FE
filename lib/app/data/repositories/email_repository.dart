import '../provider/api.dart';

class EmailRepository {
  final ApiClient apiClient;
  EmailRepository({required this.apiClient}) : assert(apiClient != null);

  Future<void> sendEmail(String emailAddress) async {
    await apiClient.sendEmail(emailAddress);
  }

  Future<bool> checkCode(String emailCode) async {
    return await apiClient.checkCode(emailCode);
  }
}
