import 'package:flutter/material.dart';
import '../../core/theme/app_assets.dart';

/// Reusable gradient + subtle grid overlay background.
/// Wrap any screen's content with this to get the same hero background
/// used on the landing page.
class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // ─── Gradient background ───────────────────────────────────────
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFF7AAECE), // sky blue top
                  Color(0xFF9DA8D8), // mid periwinkle
                  Color(0xFFB8B0D8), // muted lavender bottom
                ],
                stops: <double>[0.0, 0.55, 1.0],
              ),
            ),
          ),
        ),

        // ─── bg.svg subtle grid overlay ───────────────────────────────
        Positioned.fill(
          child: Image.asset(
            AppAssets.bgImage,
            fit: BoxFit.cover,
          ),
        ),

        // ─── Actual screen content ─────────────────────────────────────
        child,
      ],
    );
  }
}