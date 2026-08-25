class DemoVideo {
  const DemoVideo({
    required this.title,
    required this.subtitle,
    required this.src,
  });

  final String title;
  final String subtitle;
  final String src;
}

class SiteContent {
  static const name = 'Parsa Shahidi';
  static const portraitAsset = 'assets/images/portrait.jpg';
  static const title = 'Robotics · Perception · Autonomy';
  static const blurb =
      'Research demos in SLAM, mapping, localization, and robot learning — '
      'shown as they run.';

  /// Demo videos published under `web/content/` (root `content/` stays local-only).
  static const demos = <DemoVideo>[
    DemoVideo(
      title: '3D LiDAR SLAM',
      subtitle: 'Lidar-based 3D mapping',
      src: 'content/mapping.webm',
    ),
    DemoVideo(
      title: 'LiDAR SLAM',
      subtitle: 'Fast lidar-based mapping',
      src: 'content/Lidar slam fast.mp4',
    ),
    DemoVideo(
      title: 'Mapping',
      subtitle: 'Online map construction',
      src: 'content/mapping1.webm',
    ),
    DemoVideo(
      title: 'Depth Anything',
      subtitle: 'Monocular depth estimation',
      src: 'content/Depth Anything.mp4',
    ),
    DemoVideo(
      title: 'Segmentation',
      subtitle: 'Scene understanding',
      src: 'content/segmentation.webm',
    ),
    DemoVideo(
      title: 'Traffic Light',
      subtitle: 'Perception for urban driving',
      src: 'content/traffic light.webm',
    ),
    DemoVideo(
      title: 'AEB',
      subtitle: 'Automatic emergency braking',
      src: 'content/AEB1.webm',
    ),
    DemoVideo(
      title: 'Robot Arm',
      subtitle: 'Manipulator demo',
      src: 'content/arm.webm',
    ),
    DemoVideo(
      title: 'Interface',
      subtitle: 'Operator UI walkthrough',
      src: 'content/ui.webm',
    ),
  ];

  /// Rasterized talk slides (47 pages from the source deck).
  /// Skip intro pages; start at "Digital Twin: Robot Model" (slide 9).
  /// Also omit the final slide.
  static const slideFileCount = 47;
  static const slideOffset = 8;
  static const slideEndTrim = 1;
  static int get slideCount => slideFileCount - slideOffset - slideEndTrim;

  static String slidePath(int index) {
    final n = (index + slideOffset + 1).toString().padLeft(2, '0');
    final relative = 'slides/slide-$n.jpg';
    final base = Uri.base;
    final path = base.path.endsWith('/')
        ? base.path
        : base.path.substring(0, base.path.lastIndexOf('/') + 1);
    return base.replace(path: '$path$relative', query: '', fragment: '').toString();
  }
}
