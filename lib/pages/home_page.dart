import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../theme.dart';
import '../utils/open_url.dart';
import '../widgets/auto_video.dart';
import '../widgets/contact_links.dart';
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
                      padding: EdgeInsets.fromLTRB(pad, 56, pad, 72),
                      child: const _Hero(),
                    ),
                  ),
                ),
              ),
              // Publications near the top
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 72),
                      child: const _PublicationsSection(),
                    ),
                  ),
                ),
              ),
              // Projects
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxW),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 72),
                      child: const _ProjectsSection(),
                    ),
                  ),
                ),
              ),
              // Videos — wider canvas so 2-column tiles read larger
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: width < 720 ? maxW : 1320,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 88),
                      child: const _DemosSection(),
                    ),
                  ),
                ),
              ),
              // Presentations after selected work, side by side
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
                      padding: EdgeInsets.fromLTRB(pad, 0, pad, 96),
                      child: const _OtherProjectsSection(),
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
          ],
        ),
      ),
    );
  }
}

final _pubsKey = GlobalKey();
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

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
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
          'Research interests',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: SiteColors.accent,
                letterSpacing: 0.4,
              ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            SiteContent.researchInterests.join(', '),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: () => _scrollTo(_pubsKey),
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
              child: const Text('Publications'),
            ),
            OutlinedButton(
              onPressed: () => _scrollTo(_slidesKey),
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
            OutlinedButton(
              onPressed: () => _scrollTo(_demosKey),
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
              child: const Text('View demos'),
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

    final portraitColumn = SizedBox(
      width: narrow ? double.infinity : 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          portrait,
          const SizedBox(height: 16),
          const ContactLinks(vertical: true),
        ],
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
                  portraitColumn,
                  const SizedBox(height: 28),
                  textBlock,
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  portraitColumn,
                  const SizedBox(width: 48),
                  Expanded(child: textBlock),
                ],
              ),
      ),
    );
  }
}

class _PublicationsSection extends StatelessWidget {
  const _PublicationsSection();

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: _pubsKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PUBLICATIONS',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 10),
          const Divider(color: SiteColors.line, thickness: 1, height: 1),
          const SizedBox(height: 22),
          for (var i = 0; i < SiteContent.publications.length; i++) ...[
            if (i > 0) const SizedBox(height: 20),
            _PublicationItem(pub: SiteContent.publications[i]),
          ],
        ],
      ),
    );
  }
}

class _PublicationItem extends StatefulWidget {
  const _PublicationItem({required this.pub});

  final Publication pub;

  @override
  State<_PublicationItem> createState() => _PublicationItemState();
}

class _PublicationItemState extends State<_PublicationItem> {
  bool _open = false;

  Publication get pub => widget.pub;

  List<InlineSpan> _authorSpans(TextStyle? base) {
    const name = SiteContent.name;
    final parts = pub.authors.split(name);
    final spans = <InlineSpan>[];
    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i], style: base));
      }
      if (i < parts.length - 1) {
        spans.add(
          TextSpan(
            text: name,
            style: base?.copyWith(
              fontWeight: FontWeight.w700,
              color: SiteColors.ink,
            ),
          ),
        );
      }
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final body = Theme.of(context).textTheme.bodyLarge;
    final titleStyle = body?.copyWith(
      fontStyle: FontStyle.italic,
      color: SiteColors.ink,
      fontWeight: FontWeight.w500,
    );
    final previewFigure =
        pub.figures.isNotEmpty ? pub.figures.first : null;
    final dropdownFigures =
        pub.figures.length > 1 ? pub.figures.sublist(1) : const <String>[];
    final hasDetails = pub.abstractText != null ||
        dropdownFigures.isNotEmpty ||
        pub.githubUrl != null ||
        pub.note != null;

    Widget figureTile(String path) {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: SiteColors.line),
          color: Colors.white,
        ),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          width: double.infinity,
          filterQuality: FilterQuality.medium,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SiteColors.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: hasDetails ? () => setState(() => _open = !_open) : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(pub.title, style: titleStyle),
                              ),
                              if (pub.date != null) ...[
                                const SizedBox(width: 16),
                                Text(
                                  pub.date!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: SiteColors.inkSoft),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text.rich(TextSpan(children: _authorSpans(body))),
                          const SizedBox(height: 6),
                          Text(
                            pub.venue,
                            style: body?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    if (hasDetails)
                      Padding(
                        padding: const EdgeInsets.only(left: 8, top: 2),
                        child: Icon(
                          _open
                              ? Icons.expand_less_rounded
                              : Icons.expand_more_rounded,
                          color: SiteColors.accent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (previewFigure != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                child: figureTile(previewFigure),
              ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: SiteColors.line, height: 1),
                    if (pub.note != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        pub.note!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    if (pub.abstractText != null) ...[
                      const SizedBox(height: 14),
                      Text(
                        'Abstract',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 16,
                              color: SiteColors.accent,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pub.abstractText!,
                        style: body?.copyWith(height: 1.55),
                      ),
                    ],
                    if (pub.githubUrl != null) ...[
                      const SizedBox(height: 14),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => openExternalUrl(pub.githubUrl!),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.code,
                                size: 18,
                                color: SiteColors.accent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'GitHub — ${pub.githubUrl!.replaceFirst('https://github.com/', '')}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: SiteColors.accent,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      decorationColor: SiteColors.accent,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (dropdownFigures.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      for (var i = 0; i < dropdownFigures.length; i++) ...[
                        if (i > 0) const SizedBox(height: 12),
                        figureTile(dropdownFigures[i]),
                      ],
                    ],
                  ],
                ),
              ),
              crossFadeState: _open
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 220),
              sizeCurve: Curves.easeOutCubic,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < SiteContent.projects.length; i++) ...[
          if (i > 0) const SizedBox(height: 24),
          _ProjectCard(project: SiteContent.projects[i]),
        ],
      ],
    );
  }
}

class _OtherProjectsSection extends StatelessWidget {
  const _OtherProjectsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other projects',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 28),
        for (var i = 0; i < SiteContent.otherProjects.length; i++) ...[
          if (i > 0) const SizedBox(height: 24),
          _ProjectCard(project: SiteContent.otherProjects[i]),
        ],
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    final body = Theme.of(context).textTheme.bodyLarge;

    final hasImage = project.imageAsset != null;
    final image = hasImage
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ColoredBox(
                color: const Color(0xFFF7F9FB),
                child: Image.asset(
                  project.imageAsset!,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          )
        : null;

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 26,
              ),
        ),
        if (project.credit != null) ...[
          const SizedBox(height: 6),
          Text(
            project.credit!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: SiteColors.accent,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
        const SizedBox(height: 12),
        Text(project.summary, style: body),
        const SizedBox(height: 14),
        for (final h in project.highlights) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '·  ',
                  style: body?.copyWith(
                    color: SiteColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Text(h, style: body)),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            if (project.liveUrl != null)
              OutlinedButton.icon(
                onPressed: () => openExternalUrl(project.liveUrl!),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: Text(project.liveLabel),
                style: OutlinedButton.styleFrom(
                  foregroundColor: SiteColors.ink,
                  side: const BorderSide(color: SiteColors.ink),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            if (project.pdfUrl != null)
              OutlinedButton.icon(
                onPressed: () => openExternalUrl(
                  Project.resolveSitePath(project.pdfUrl!),
                ),
                icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                label: const Text('Thesis PDF'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: SiteColors.ink,
                  side: const BorderSide(color: SiteColors.ink),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            if (project.githubUrl != null)
              OutlinedButton.icon(
                onPressed: () => openExternalUrl(project.githubUrl!),
                icon: const Icon(Icons.code, size: 18),
                label: const Text('GitHub'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: SiteColors.ink,
                  side: const BorderSide(color: SiteColors.ink),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
          ],
        ),
      ],
    );

    Widget galleryVideoTile(DemoVideo video, double width, {bool showLabels = false}) {
      return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: video.galleryAspectRatio,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: SiteColors.line),
                  color: SiteColors.paperDeep,
                ),
                child: AutoVideo(
                  src: video.src,
                  mobileSrc: video.mobileSrc,
                ),
              ),
            ),
            if (showLabels) ...[
              const SizedBox(height: 6),
              Text(
                video.title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (video.subtitle.isNotEmpty)
                Text(
                  video.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ],
        ),
      );
    }

    Widget gallery() {
      if (project.galleryFigures.isEmpty && project.galleryVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      final tileVideos =
          project.galleryVideos.where((v) => v.galleryTile).toList();
      final fullVideos =
          project.galleryVideos.where((v) => !v.galleryTile).toList();

      return LayoutBuilder(
        builder: (context, constraints) {
          final cols = constraints.maxWidth < 520 ? 2 : 3;
          const gap = 10.0;
          final tileW = (constraints.maxWidth - gap * (cols - 1)) / cols;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Text(
                'Outputs',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: SiteColors.accent,
                      letterSpacing: 0.3,
                    ),
              ),
              const SizedBox(height: 10),
              if (project.galleryFigures.isNotEmpty || tileVideos.isNotEmpty)
                Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final path in project.galleryFigures)
                      SizedBox(
                        width: tileW,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: SiteColors.line),
                            color: const Color(0xFFF7F9FB),
                          ),
                          child: Image.asset(
                            path,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.medium,
                          ),
                        ),
                      ),
                    for (final video in tileVideos)
                      galleryVideoTile(
                        video,
                        tileW * video.gallerySizeFactor,
                      ),
                  ],
                ),
              for (final video in fullVideos) ...[
                if (project.galleryFigures.isNotEmpty || tileVideos.isNotEmpty)
                  const SizedBox(height: gap),
                SizedBox(
                  width: constraints.maxWidth,
                  child: galleryVideoTile(
                    video,
                    constraints.maxWidth,
                    showLabels: true,
                  ),
                ),
              ],
            ],
          );
        },
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SiteColors.line),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (hasImage) ...[
                          image!,
                          const SizedBox(height: 18),
                        ],
                        text,
                      ],
                    )
                  : hasImage
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 280, child: image),
                            const SizedBox(width: 28),
                            Expanded(child: text),
                          ],
                        )
                      : text,
              gallery(),
            ],
          ),
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

    return KeyedSubtree(
      key: _demosKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected work',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 20.0;
              final cols = width < 640 ? 1 : 2;
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
                child: AutoVideo(
                  src: widget.demo.src,
                  mobileSrc: widget.demo.mobileSrc,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.demo.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 17,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              widget.demo.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
            'Presentations',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final gap = 24.0;
              final sideBySide = constraints.maxWidth >= 720;
              if (!sideBySide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < SiteContent.decks.length; i++) ...[
                      if (i > 0) SizedBox(height: gap),
                      SlideViewer(
                        deck: SiteContent.decks[i],
                        maxWidth: constraints.maxWidth,
                      ),
                    ],
                  ],
                );
              }
              final itemW = (constraints.maxWidth - gap) / 2;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < SiteContent.decks.length; i++) ...[
                    if (i > 0) SizedBox(width: gap),
                    SlideViewer(
                      deck: SiteContent.decks[i],
                      maxWidth: itemW,
                    ),
                  ],
                ],
              );
            },
          ),
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
