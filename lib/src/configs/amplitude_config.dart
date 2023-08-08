import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AmplitudeConfig {
  static Amplitude analytics =
      Amplitude.getInstance(instanceName: "leporem-art");

  static Future<void> init() async {
    await dotenv.load(fileName: 'assets/config/.env');
    String amplitudeAPIKey = dotenv.get('AMPLITUDE_APIKEY');

    // Initialize SDK
    await analytics.init(amplitudeAPIKey);
  }
}
