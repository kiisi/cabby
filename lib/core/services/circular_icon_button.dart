import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;

  const CircularIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28.0), // Adjust the border radius
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white), // Optional border
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
