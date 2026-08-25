import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/site_content.dart';
import '../theme.dart';
import '../widgets/auto_video.dart';
import '../widgets/slide_viewer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pad = width < 720 ? 20.0 : width < 1100 ? 40.0 : 72.0;
    final maxW = 1120.0;

    return Scaffold(
      body: Stack(
        children: [
          const _PaperBackdrop(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 28, pad, 0),
                      child: const _TopNav(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 56, pad, 72),
                      child: const _Hero(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 88),
                      child: const _DemosSection(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 96),
                      child: const _SlidesSection(),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 48),
                      child: const _Footer(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaperBackdrop extends StatelessWidget {
  const _PaperBackdrop();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF7F9FB),
              Color(0xFFEEF3F6),
              Color(0xFFE6EEF1),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -80,
              child: Container(
                width: 420,
                height: 420,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      SiteColors.accent.withValues(alpha: 0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 180,
              left: -100,
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF8FA6B5).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            CustomPaint(painter: _GridPainter(), size: Size.infinite),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF15202B).withValues(alpha: 0.035)
      ..strokeWidth = 1;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TopNav extends StatelessWidget {
  const _TopNav();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: SiteColors.ink,
          fontWeight: FontWeight.w600,
        );

    return Row(
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                SiteContent.portraitAsset,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              SiteContent.name,
              style: GoogleFonts.libreBaskerville(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: SiteColors.ink,
              ),
            ),
          ],
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            final ctx = _demosKey.currentContext;
            if (ctx == null) return;
            Scrollable.ensureVisible(
              ctx,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
            );
          },
          child: Text('Work', style: style),
        ),
        TextButton(
          onPressed: () {
            final ctx = _slidesKey.currentContext;
            if (ctx == null) return;
            Scrollable.ensureVisible(
              ctx,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeOutCubic,
            );
          },
          child: Text('Slides', style: style),
        ),
      ],
    );
  }
}

final _demosKey = GlobalKey();
final _slidesKey = GlobalKey();

class _Hero extends StatefulWidget {
  const _Hero();

  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          SiteContent.name.toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: narrow ? 40 : 64,
                letterSpacing: 1.0,
                height: 1.05,
              ),
        ),
        const SizedBox(height: 18),
        Container(
          width: 56,
          height: 2,
          color: SiteColors.accent,
        ),
        const SizedBox(height: 22),
        Text(
          SiteContent.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: SiteColors.accent,
                letterSpacing: 0.6,
              ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            SiteContent.blurb,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () {
                final ctx = _demosKey.currentContext;
                if (ctx != null) {
                  Scrollable.ensureVisible(
                    ctx,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutCubic,
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: SiteColors.ink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('View demos'),
            ),
            OutlinedButton(
              onPressed: () {
                final ctx = _slidesKey.currentContext;
                if (ctx != null) {
                  Scrollable.ensureVisible(
                    ctx,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutCubic,
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: SiteColors.ink,
                side: const BorderSide(color: SiteColors.ink),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 16,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('Open slides'),
            ),
          ],
        ),
      ],
    );

    final portrait = DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: SiteColors.line),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Image.asset(
        SiteContent.portraitAsset,
        width: narrow ? double.infinity : 280,
        height: narrow ? 320 : 340,
        fit: BoxFit.cover,
        alignment: const Alignment(0, -0.15),
        filterQuality: FilterQuality.high,
        semanticLabel: SiteContent.name,
      ),
    );

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: narrow
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  portrait,
                  const SizedBox(height: 28),
                  textBlock,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  portrait,
                  const SizedBox(width: 48),
                  Expanded(child: textBlock),
                ],
              ),
      ),
    );
  }
}

class _DemosSection extends StatelessWidget {
  const _DemosSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cols = width < 640 ? 1 : width < 980 ? 2 : 3;

    return KeyedSubtree(
      key: _demosKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected work',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Videos play automatically, muted and looping.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 20.0;
              final itemW =
                  (constraints.maxWidth - gap * (cols - 1)) / cols;
              return Wrap(
                spacing: gap,
                runSpacing: gap + 8,
                children: [
                  for (final demo in SiteContent.demos)
                    SizedBox(
                      width: itemW,
                      child: _DemoTile(demo: demo),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DemoTile extends StatefulWidget {
  const _DemoTile({required this.demo});

  final DemoVideo demo;

  @override
  State<_DemoTile> createState() => _DemoTileState();
}

class _DemoTileState extends State<_DemoTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: SiteColors.line),
                  color: SiteColors.paperDeep,
                ),
                child: AutoVideo(src: widget.demo.src),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.demo.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              widget.demo.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidesSection extends StatelessWidget {
  const _SlidesSection();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _slidesKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Talk slides',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Nova Robot deck — step through each page with the pointer.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 28),
          const SlideViewer(),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: SiteColors.line),
        const SizedBox(height: 18),
        Text(
          '© ${DateTime.now().year} ${SiteContent.name}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
