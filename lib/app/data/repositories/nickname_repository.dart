import '../provider/api.dart';

class NicknameRepository {
  final ApiClient apiClient;
  NicknameRepository({required this.apiClient}) : assert(apiClient != null);

  Future<bool> isDuplicate(String nickname) async {
    return await apiClient.isDuplicate(nickname);
  }
}
