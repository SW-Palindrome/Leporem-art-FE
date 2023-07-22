import 'package:flutter/material.dart';
import 'package:leporemart/src/theme/app_theme.dart';

enum PlantTemperatureType { all, image, text }

class PlantTemperature extends StatelessWidget {
  const PlantTemperature({
    super.key,
    required this.temperature,
    this.type = PlantTemperatureType.all,
  });

  final double temperature;
  final PlantTemperatureType type;

  @override
  Widget build(BuildContext context) {
    String? imageSrc;
    Color? temperatureColor;
    if (temperature >= 0 && temperature < 20) {
      imageSrc = 'assets/images/1.png';
      temperatureColor = ColorPalette.orange;
    } else if (temperature >= 20 && temperature < 40) {
      imageSrc = 'assets/images/2.png';
      temperatureColor = ColorPalette.yellow;
    } else if (temperature >= 40 && temperature < 60) {
      imageSrc = 'assets/images/3.png';
      temperatureColor = ColorPalette.green;
    } else if (temperature >= 60 && temperature < 80) {
      imageSrc = 'assets/images/4.png';
      temperatureColor = ColorPalette.blue;
    } else if (temperature >= 80 && temperature < 100) {
      imageSrc = 'assets/images/5.png';
      temperatureColor = ColorPalette.purple;
    }
    return Column(
      children: [
        PlantTemperatureType.all == type || PlantTemperatureType.image == type
            ? Image.asset(
                imageSrc!,
                width: 42,
                height: 48,
              )
            : Container(),
        PlantTemperatureType.all == type || PlantTemperatureType.text == type
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: temperatureColor,
                ),
                child: Text(
                  "${temperature.toInt()}%",
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PretendardVariable",
                    fontStyle: FontStyle.normal,
                    fontSize: 12.0,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
