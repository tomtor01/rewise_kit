import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  final double fontSize;
  final bool useGradient;
  final List<Color> gradientColors;
  final String? prefix;
  final String? suffix;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const AppTitle({
    super.key,
    this.fontSize = 32,
    this.useGradient = true,
    this.gradientColors = const [Colors.purple, Colors.blueAccent],
    this.prefix,
    this.suffix,
    this.textStyle,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {

    // Dla przypadku z prefixem i/lub suffixem
    final defaultStyle = (textStyle ??
        Theme.of(context).textTheme.bodyLarge ??
        const TextStyle())
        .copyWith(fontSize: fontSize * 0.8);

    final appNameStyle = GoogleFonts.protestRiot(
      fontSize: fontSize,
      color: Colors.white,
    );

    // Sprawdza czy prefix zawiera znak nowej linii
    if (prefix != null && prefix!.contains('\n')) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            prefix!.trim(),
            style: defaultStyle,
            textAlign: textAlign,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => ui.Gradient.linear(
                  const Offset(0, 0),
                  Offset(bounds.width, 0),
                  gradientColors,
                ),
                child: Text(
                  'ReWiseKit',
                  style: appNameStyle,
                ),
              ),
              if (suffix != null)
                Text(
                  suffix!,
                  style: defaultStyle,
                ),
            ],
          ),
        ],
      );
    }

    // dla przypadku bez znaku nowej linii
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefix != null)
          Text(
            prefix!,
            style: defaultStyle,
          ),
        ShaderMask(
          shaderCallback: (bounds) => ui.Gradient.linear(
            const Offset(0, 0),
            Offset(bounds.width, 0),
            gradientColors,
          ),
          child: Text(
            'ReWiseKit',
            style: appNameStyle,
          ),
        ),
        if (suffix != null)
          Text(
            suffix!,
            style: defaultStyle,
          ),
      ],
    );
  }
}
