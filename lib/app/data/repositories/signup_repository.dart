import '../provider/api.dart';

class SignupRepository {
  final ApiClient apiClient;
  SignupRepository({required this.apiClient}) : assert(apiClient != null);

  Future<bool> signupWithKakao(String nickname) async {
    return await apiClient.signupWithKakao(nickname);
  }

  Future<bool> signupWithApple(String userIdentifier, String nickname) async {
    return await apiClient.signupWithApple(userIdentifier, nickname);
  }
}
