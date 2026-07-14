import 'package:flutter/material.dart';

import '../theme.dart';

/// Text painted with the iridescent holo gradient — the brand accent,
/// reserved for the logo, prices and key numbers.
class HoloText extends StatelessWidget {
  const HoloText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => holoGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(text, style: (style ?? const TextStyle()).copyWith(color: Colors.white)),
    );
  }
}

/// Gradient-filled action button (replaces the plain FAB for hero actions).
class HoloButton extends StatelessWidget {
  const HoloButton({super.key, required this.onPressed, required this.icon, required this.label});

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: holoGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x8846A0FF), blurRadius: 18, offset: Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: surfaceDeep),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: surfaceDeep,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated holographic sheen sweeping across its child — the "opening a
/// booster" moment, used on rare cards in the detail screen.
class HoloShimmer extends StatefulWidget {
  const HoloShimmer({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  State<HoloShimmer> createState() => _HoloShimmerState();
}

class _HoloShimmerState extends State<HoloShimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 4));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (widget.enabled && !reduceMotion) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final t = _controller.value * 2 - 1; // -1 .. 1
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(t - 0.6, -1),
                        end: Alignment(t + 0.6, 1),
                        colors: const [
                          Colors.transparent,
                          Color(0x2E46E3FF),
                          Color(0x2EB06BFF),
                          Color(0x2EFF5FA8),
                          Color(0x2EFFD34E),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Thin holo gradient frame around rare cards in the grid (static — cheap).
class HoloFrame extends StatelessWidget {
  const HoloFrame({super.key, required this.child, this.enabled = true, this.radius = 10});

  final Widget child;
  final bool enabled;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return Container(
      decoration: BoxDecoration(
        gradient: holoGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      padding: const EdgeInsets.all(1.4),
      child: ClipRRect(borderRadius: BorderRadius.circular(radius - 1.4), child: child),
    );
  }
}
