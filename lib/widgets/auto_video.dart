import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Muted looping autoplay video for academic demo grids.
/// Initializes only when on-screen to avoid loading every asset at once.
class AutoVideo extends StatefulWidget {
  const AutoVideo({
    super.key,
    required this.src,
    this.borderRadius = 2,
  });

  final String src;
  final double borderRadius;

  @override
  State<AutoVideo> createState() => _AutoVideoState();
}

class _AutoVideoState extends State<AutoVideo> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _starting = false;
  bool _visible = false;

  Uri get _uri {
    final encoded = widget.src.split('/').map(Uri.encodeComponent).join('/');
    return Uri.base.resolve(encoded);
  }

  Future<void> _ensurePlaying() async {
    if (_controller != null || _starting || _failed || !_visible) return;
    _starting = true;
    final controller = VideoPlayerController.networkUrl(_uri);
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      if (!mounted || !_visible) {
        await controller.dispose();
        _starting = false;
        return;
      }
      setState(() => _controller = controller);
    } catch (_) {
      await controller.dispose();
      if (mounted) setState(() => _failed = true);
    } finally {
      _starting = false;
    }
  }

  Future<void> _teardown() async {
    final controller = _controller;
    _controller = null;
    if (controller != null) {
      await controller.dispose();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('video-${widget.src}'),
      onVisibilityChanged: (info) {
        final nowVisible = info.visibleFraction > 0.15;
        if (nowVisible == _visible) return;
        _visible = nowVisible;
        if (nowVisible) {
          _ensurePlaying();
        } else {
          _teardown();
        }
      },
      child: _buildSurface(),
    );
  }

  Widget _buildSurface() {
    final controller = _controller;
    if (_failed) {
      return const ColoredBox(
        color: Color(0xFFE8EDF2),
        child: Center(
          child: Icon(Icons.videocam_off_outlined, color: Color(0xFF4A5563)),
        ),
      );
    }
    if (controller == null || !controller.value.isInitialized) {
      return const ColoredBox(
        color: Color(0xFFE8EDF2),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}
