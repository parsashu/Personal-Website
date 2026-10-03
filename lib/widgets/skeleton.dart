import 'package:flutter/material.dart';

/// Shimmering placeholder block shown while media is still loading.
class Skeleton extends StatefulWidget {
  const Skeleton({super.key, this.borderRadius = 0});

  final double borderRadius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  static const _base = Color(0xFFDAE2E8);
  static const _highlight = Color(0xFFEDF2F5);

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        // Sweep a soft highlight band from left to right.
        final t = _c.value * 3 - 1;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(t - 1, -0.3),
              end: Alignment(t + 1, 0.3),
              colors: const [_base, _highlight, _base],
              stops: const [0.35, 0.5, 0.65],
            ),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

/// [Image.asset] that shows a [Skeleton] until its first frame is decoded.
class SkeletonImage extends StatelessWidget {
  const SkeletonImage(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.filterQuality = FilterQuality.medium,
    this.semanticLabel,
    this.placeholderAspectRatio = 4 / 3,
  });

  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final FilterQuality filterQuality;
  final String? semanticLabel;

  /// Size of the placeholder when the image has no fixed height.
  final double placeholderAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      filterQuality: filterQuality,
      semanticLabel: semanticLabel,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        if (height != null) {
          return SizedBox(width: width, height: height, child: const Skeleton());
        }
        return AspectRatio(
          aspectRatio: placeholderAspectRatio,
          child: const Skeleton(),
        );
      },
    );
  }
}
