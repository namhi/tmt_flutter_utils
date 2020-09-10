import 'dart:ui';

extension ColorExtensions on Color {
  Color textColor() {
    int d = 0;

// Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * (this.red ?? 0) + 0.587 * this.green + 0.114 * this.blue) /
            255;

    if (luminance > 0.5)
      d = 50; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(this.alpha, d, d, d);
  }
}
