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
  static const name = 'Parsa';
  static const title = 'Robotics · Perception · Autonomy';
  static const blurb =
      'Research demos in SLAM, mapping, localization, and robot learning — '
      'shown as they run.';

  /// Served from `web/content` (symlink to the project content folder).
  static const demos = <DemoVideo>[
    DemoVideo(
      title: 'Dynamic V-SLAM',
      subtitle: 'Visual SLAM in changing scenes',
      src: 'content/Dynamic Vslam.mp4',
    ),
    DemoVideo(
      title: 'LiDAR SLAM',
      subtitle: 'Fast lidar-based mapping',
      src: 'content/Lidar slam fast.mp4',
    ),
    DemoVideo(
      title: 'Localization',
      subtitle: 'Pose estimation in mapped environments',
      src: 'content/Localization.mp4',
    ),
    DemoVideo(
      title: 'Mapping',
      subtitle: 'Online map construction',
      src: 'content/mapping.webm',
    ),
    DemoVideo(
      title: 'Map & Navigation',
      subtitle: 'Mapping with navigation speed',
      src: 'content/mapp show + nav speed.mp4',
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
      title: 'LeRobot',
      subtitle: 'Robot learning experiments',
      src: 'content/lerobot.mp4',
    ),
    DemoVideo(
      title: 'Interface',
      subtitle: 'Operator UI walkthrough',
      src: 'content/ui.webm',
    ),
  ];

  /// Rasterized pages from `Nova Robot.pptx` (47 slides).
  static const slideCount = 47;

  static String slidePath(int index) {
    final n = (index + 1).toString().padLeft(2, '0');
    return Uri.base.resolve('slides/slide-$n.png').toString();
  }
}
