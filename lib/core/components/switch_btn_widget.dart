import 'package:flutter/material.dart';
import 'package:weather_application/core/constants/config.dart';

class AppSwitchButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppSwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppConfig().colors.primaryColor;

    return Switch(
        activeColor: primaryColor,
        inactiveTrackColor: Colors.white,
        activeTrackColor: primaryColor,
        thumbColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return AppConfig().colors.disableColor;
          },
        ),
        value: value,
        onChanged: onChanged);
  }
}
