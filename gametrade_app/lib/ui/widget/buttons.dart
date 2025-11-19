import 'package:flutter/material.dart';


class Boton extends StatelessWidget {
  final String label;
  // final Color? color;
  final Color? fontColor;
  final Widget? icono;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  
  const Boton({
      required this.label,
      // required this.color,
      required this.fontColor,
      required this.icono,
      required this.gradient,
      required this.onPressed,
      super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
                    width: double.infinity,
                    height: 64,
                    decoration: BoxDecoration(
                      gradient: gradient ?? LinearGradient(
                        colors: [Colors.lightBlue , Colors.red]
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      onPressed: onPressed,
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors.transparent,
                        foregroundColor: fontColor ?? Colors.black,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icono!= null) icono!,
                          if (icono != null) SizedBox(width: 8),
                          SizedBox(width: 8),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
  }
}