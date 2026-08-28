import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Web-native muted autoplay video that streams progressively.
/// The `src` is attached only while the tile is on screen.
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
  static int _viewCounter = 0;

  late final String _viewType = 'auto-video-${_viewCounter++}';
  html.VideoElement? _video;
  bool _failed = false;
  bool _visible = false;
  bool _registered = false;
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registerView();
  }

  @override
  void didUpdateWidget(covariant AutoVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src ||
        oldWidget.mobileSrc != widget.mobileSrc) {
      if (_visible) {
        _detach();
        _attach();
      }
    }
  }

  void _registerView() {
    if (_registered) return;
    _registered = true;
    ui_web.platformViewRegistry.registerViewFactory(
      _viewType,
      (int viewId) {
        final video = html.VideoElement()
          ..muted = true
          ..loop = true
          ..autoplay = true
          ..controls = false
          ..preload = 'none'
          ..setAttribute('playsinline', '')
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'cover'
          ..style.backgroundColor = '#E8EDF2';
        video.onError.listen((_) {
          if (mounted) setState(() => _failed = true);
        });
        video.onCanPlay.listen((_) {
          if (mounted) setState(() => _ready = true);
        });
        video.onPlaying.listen((_) {
          if (mounted) setState(() => _ready = true);
        });
        _video = video;
        if (_visible) _attach();
        return video;
      },
    );
  }

  String _pickSrc() {
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

  void _attach() {
    final video = _video;
    if (video == null || _failed) return;

    final uri = _resolveUri(_pickSrc()).toString();
    if (video.getAttribute('src') != uri) {
      setState(() => _ready = false);
      video
        ..setAttribute('src', uri)
        ..load();
    }
    video.play().catchError((_) {});
  }

  void _detach() {
    final video = _video;
    if (video == null) return;
    video.pause();
    video.removeAttribute('src');
    video.load();
    if (mounted) setState(() => _ready = false);
  }

  @override
  void dispose() {
    _detach();
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
          _attach();
        } else {
          _detach();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: _failed
            ? const ColoredBox(
                color: Color(0xFFE8EDF2),
                child: Center(
                  child: Icon(
                    Icons.videocam_off_outlined,
                    color: Color(0xFF4A5563),
                  ),
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  HtmlElementView(viewType: _viewType),
                  if (!_ready)
                    const ColoredBox(
                      color: Color(0xFFE8EDF2),
                      child: Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
