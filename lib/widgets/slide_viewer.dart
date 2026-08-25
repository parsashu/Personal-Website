import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/site_content.dart';
import '../theme.dart';

/// Page-by-page viewer for the talk deck (exported slide images).
class SlideViewer extends StatefulWidget {
  const SlideViewer({super.key});

  @override
  State<SlideViewer> createState() => _SlideViewerState();
}

class _SlideViewerState extends State<SlideViewer> {
  late final PageController _pageController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAround(0);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _precacheAround(int index) {
    if (!mounted) return;
    for (final i in {index, index + 1, index + 2, index - 1}) {
      if (i < 0 || i >= SiteContent.slideCount) continue;
      precacheImage(
        NetworkImage(SiteContent.slidePath(i)),
        context,
      );
    }
  }

  void _go(int delta) {
    final next = (_index + delta).clamp(0, SiteContent.slideCount - 1);
    if (next == _index) return;
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
    );
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.pageDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.pageUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: SiteColors.line),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: SiteContent.slideCount,
                    allowImplicitScrolling: true,
                    onPageChanged: (i) {
                      setState(() => _index = i);
                      _precacheAround(i);
                    },
                    itemBuilder: (context, i) {
                      return Image.network(
                        SiteContent.slidePath(i),
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.low,
                        cacheWidth: 960,
                        gaplessPlayback: true,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const ColoredBox(
                            color: Colors.white,
                            child: Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Text('Slide unavailable')),
                      );
                    },
                  ),
                  Positioned(
                    left: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _NavButton(
                        icon: Icons.chevron_left_rounded,
                        enabled: _index > 0,
                        onTap: () => _go(-1),
                        semanticLabel: 'Previous slide',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _NavButton(
                        icon: Icons.chevron_right_rounded,
                        enabled: _index < SiteContent.slideCount - 1,
                        onTap: () => _go(1),
                        semanticLabel: 'Next slide',
                        emphasize: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Presentation',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Text(
                '${_index + 1} / ${SiteContent.slideCount}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SiteColors.ink,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Click the right arrow (or press →) to advance page by page.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
    required this.semanticLabel,
    this.emphasize = false,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final String semanticLabel;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final bg = emphasize ? SiteColors.accent : Colors.white.withValues(alpha: 0.92);
    final fg = emphasize ? Colors.white : SiteColors.ink;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: enabled ? 1 : 0.35,
        child: Material(
          color: bg,
          shape: const CircleBorder(),
          elevation: emphasize ? 2 : 0,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: enabled ? onTap : null,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Icon(icon, color: fg, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}
