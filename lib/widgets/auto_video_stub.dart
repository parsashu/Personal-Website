import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Non-web fallback using video_player.
class AutoVideo extends StatefulWidget {
  const AutoVideo({
    super.key,
    required this.src,
    this.mobileSrc,
    this.borderRadius = 2,
  });

  final String src;
  final String? mobileSrc;
  final double borderRadius;

  @override
  State<AutoVideo> createState() => _AutoVideoState();
}

class _AutoVideoState extends State<AutoVideo> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _starting = false;
  bool _visible = false;

  String get _activeSrc {
    final width = MediaQuery.sizeOf(context).width;
    final useMobile = width < 720 && (widget.mobileSrc?.isNotEmpty ?? false);
    return useMobile ? widget.mobileSrc! : widget.src;
  }

  Uri _resolveUri(String relative) {
    final encoded = relative.split('/').map(Uri.encodeComponent).join('/');
    final base = Uri.base;
    final path = base.path.endsWith('/')
        ? base.path
        : base.path.substring(0, base.path.lastIndexOf('/') + 1);
    return base.replace(path: '$path$encoded', query: '', fragment: '');
  }

  Future<void> _ensurePlaying() async {
    if (_starting || _failed || !_visible) return;
    _starting = true;
    final controller = VideoPlayerController.networkUrl(_resolveUri(_activeSrc));
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

  Future<void> _pause() async {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      await controller.pause();
    }
  }

  Future<void> _resume() async {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      await controller.play();
      return;
    }
    await _ensurePlaying();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('video-${widget.src}-${widget.mobileSrc}'),
      onVisibilityChanged: (info) {
        final nowVisible = info.visibleFraction > 0.2;
        if (nowVisible == _visible) return;
        _visible = nowVisible;
        if (nowVisible) {
          _resume();
        } else {
          _pause();
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
