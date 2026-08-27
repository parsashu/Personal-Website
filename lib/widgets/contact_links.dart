import 'package:flutter/material.dart';

import '../data/site_content.dart';
import '../utils/open_url.dart';

/// Soft sky-blue labels matching the contact reference style.
const _labelBlue = Color(0xFF7EB6D4);

class ContactLinks extends StatelessWidget {
  const ContactLinks({
    super.key,
    this.dense = false,
    this.vertical = true,
  });

  final bool dense;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final gap = dense ? 12.0 : 14.0;
    final children = [
      for (final link in SiteContent.contacts)
        _ContactRow(link: link, dense: dense),
    ];

    if (vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: gap),
            children[i],
          ],
        ],
      );
    }

    return Wrap(
      spacing: 20,
      runSpacing: gap,
      children: children,
    );
  }
}

class _ContactRow extends StatefulWidget {
  const _ContactRow({required this.link, required this.dense});

  final ContactLink link;
  final bool dense;

  @override
  State<_ContactRow> createState() => _ContactRowState();
}

class _ContactRowState extends State<_ContactRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.dense ? 20.0 : 22.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openExternalUrl(widget.link.url),
        child: Opacity(
          opacity: _hover ? 0.75 : 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BrandIcon(id: widget.link.id, size: size),
              const SizedBox(width: 10),
              Text(
                widget.link.label,
                style: TextStyle(
                  fontFamily: 'Source Sans 3',
                  fontSize: widget.dense ? 16 : 17,
                  fontWeight: FontWeight.w500,
                  color: _labelBlue,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandIcon extends StatelessWidget {
  const _BrandIcon({required this.id, required this.size});

  final String id;
  final double size;

  @override
  Widget build(BuildContext context) {
    switch (id) {
      case 'email':
        return Icon(
          Icons.email,
          size: size,
          color: const Color(0xFF4A5563),
        );
      case 'github':
        return CustomPaint(
          size: Size.square(size),
          painter: const _GitHubMarkPainter(Color(0xFF24292F)),
        );
      case 'linkedin':
        return CustomPaint(
          size: Size.square(size),
          painter: const _LinkedInMarkPainter(Color(0xFF0A66C2)),
        );
      case 'telegram':
        return CustomPaint(
          size: Size.square(size),
          painter: const _TelegramMarkPainter(Color(0xFF2AABEE)),
        );
      default:
        return Icon(Icons.link, size: size, color: _labelBlue);
    }
  }
}

class _GitHubMarkPainter extends CustomPainter {
  const _GitHubMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Official-style mark on a 24×24 grid, scaled to [size].
    final scale = size.width / 24;
    canvas.save();
    canvas.scale(scale);
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(12, 0)
      ..cubicTo(5.37, 0, 0, 5.37, 0, 12)
      ..cubicTo(0, 17.31, 3.44, 21.8, 8.21, 23.39)
      ..cubicTo(8.81, 23.5, 9, 23.13, 9, 22.81)
      ..lineTo(9, 20.58)
      ..cubicTo(5.67, 21.31, 4.97, 19.11, 4.97, 19.11)
      ..cubicTo(4.42, 17.72, 3.63, 17.35, 3.63, 17.35)
      ..cubicTo(2.55, 16.61, 3.71, 16.62, 3.71, 16.62)
      ..cubicTo(4.91, 16.71, 5.55, 17.86, 5.55, 17.86)
      ..cubicTo(6.62, 19.7, 8.36, 19.17, 9.04, 18.86)
      ..cubicTo(9.15, 18.09, 9.46, 17.56, 9.81, 17.26)
      ..cubicTo(7.14, 16.96, 4.34, 15.93, 4.34, 11.34)
      ..cubicTo(4.34, 10.03, 4.81, 8.96, 5.58, 8.12)
      ..cubicTo(5.46, 7.82, 5.05, 6.6, 5.7, 4.95)
      ..cubicTo(5.7, 4.95, 6.71, 4.63, 9, 6.18)
      ..cubicTo(9.96, 5.91, 10.98, 5.78, 12, 5.77)
      ..cubicTo(13.02, 5.78, 14.04, 5.91, 15, 6.18)
      ..cubicTo(17.29, 4.63, 18.3, 4.95, 18.3, 4.95)
      ..cubicTo(18.95, 6.6, 18.54, 7.82, 18.42, 8.12)
      ..cubicTo(19.19, 8.96, 19.66, 10.03, 19.66, 11.34)
      ..cubicTo(19.66, 15.94, 16.85, 16.95, 14.17, 17.25)
      ..cubicTo(14.6, 17.62, 15, 18.35, 15, 19.45)
      ..lineTo(15, 22.81)
      ..cubicTo(15, 23.13, 15.19, 23.51, 15.8, 23.39)
      ..cubicTo(20.57, 21.8, 24, 17.31, 24, 12)
      ..cubicTo(24, 5.37, 18.63, 0, 12, 0)
      ..close();
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GitHubMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _LinkedInMarkPainter extends CustomPainter {
  const _LinkedInMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final bg = Paint()..color = color;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, s, s),
        Radius.circular(s * 0.18),
      ),
      bg,
    );
    final ink = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(s * 0.28, s * 0.3), s * 0.09, ink);
    canvas.drawRect(Rect.fromLTWH(s * 0.19, s * 0.44, s * 0.18, s * 0.4), ink);
    canvas.drawRect(Rect.fromLTWH(s * 0.48, s * 0.44, s * 0.18, s * 0.4), ink);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(s * 0.48, s * 0.4, s * 0.34, s * 0.28),
        topRight: Radius.circular(s * 0.12),
        bottomRight: Radius.circular(s * 0.02),
      ),
      ink,
    );
    // Carve the open part of the "n"
    canvas.drawRect(
      Rect.fromLTWH(s * 0.66, s * 0.52, s * 0.16, s * 0.32),
      bg,
    );
  }

  @override
  bool shouldRepaint(covariant _LinkedInMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _TelegramMarkPainter extends CustomPainter {
  const _TelegramMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    canvas.drawCircle(
      Offset(s / 2, s / 2),
      s / 2,
      Paint()..color = color,
    );
    final plane = Path()
      ..moveTo(s * 0.22, s * 0.48)
      ..lineTo(s * 0.78, s * 0.28)
      ..lineTo(s * 0.58, s * 0.76)
      ..lineTo(s * 0.46, s * 0.56)
      ..lineTo(s * 0.62, s * 0.4)
      ..lineTo(s * 0.4, s * 0.54)
      ..close();
    canvas.drawPath(plane, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant _TelegramMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
