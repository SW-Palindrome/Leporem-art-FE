import 'package:flutter/material.dart';
import 'package:leporemart/src/theme/app_theme.dart';

class PlantTemperature extends StatelessWidget {
  const PlantTemperature({
    super.key,
    required this.temperature,
  });

  final double temperature;

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
        //assets/images/1.png를 가져오고 아래에 controller.itemDetail.temperature를 int로해 넣어주면 될듯
        Image.asset(
          imageSrc!,
          width: 42,
          height: 48,
        ),
        Container(
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
        ),
      ],
    );
  }
}
