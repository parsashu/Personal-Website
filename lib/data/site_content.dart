class Project {
  const Project({
    required this.title,
    required this.summary,
    required this.highlights,
    required this.imageAsset,
    this.liveUrl,
    this.liveLabel = 'Website',
    this.githubUrl,
    this.pdfUrl,
    this.credit,
  });

  final String title;
  final String summary;
  final List<String> highlights;
  final String imageAsset;
  final String? liveUrl;
  final String liveLabel;
  final String? githubUrl;
  final String? pdfUrl;
  final String? credit;

  static String resolveSitePath(String relative) {
    final base = Uri.base;
    final path = base.path.endsWith('/')
        ? base.path
        : base.path.substring(0, base.path.lastIndexOf('/') + 1);
    return base
        .replace(path: '$path$relative', query: '', fragment: '')
        .toString();
  }
}

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

class Publication {
  const Publication({
    required this.title,
    required this.authors,
    required this.venue,
    this.date,
    this.note,
    this.abstractText,
    this.figures = const [],
    this.githubUrl,
  });

  final String title;
  final String authors;
  final String venue;
  final String? date;
  final String? note;
  final String? abstractText;
  final List<String> figures;
  final String? githubUrl;
}

class TalkDeck {
  const TalkDeck({
    required this.id,
    required this.title,
    required this.folder,
    required this.fileCount,
    this.offset = 0,
    this.endTrim = 0,
    this.aspectRatio = 16 / 9,
  });

  final String id;
  final String title;
  final String folder;
  final int fileCount;
  final int offset;
  final int endTrim;
  final double aspectRatio;

  int get slideCount => fileCount - offset - endTrim;

  String slidePath(int index) {
    final n = (index + offset + 1).toString().padLeft(2, '0');
    final relative = 'slides/$folder/slide-$n.jpg';
    final base = Uri.base;
    final path = base.path.endsWith('/')
        ? base.path
        : base.path.substring(0, base.path.lastIndexOf('/') + 1);
    return base.replace(path: '$path$relative', query: '', fragment: '').toString();
  }
}

class SiteContent {
  static const name = 'Parsa Shahidi';
  static const portraitAsset = 'assets/images/portrait.jpg';
  static const researchInterests = <String>[
    'Robot perception & SLAM',
    'Autonomous navigation',
    'Digital twin',
    'Photoacoustic imaging',
    'Mobile edge computing, DRL & PPO',
    'Real-time systems',
    'Embedded systems',
    'IoT',
    'Computational physics & simulation',
    'Biophysics',
    'Complex systems',
    'Soft matter',
    'Quantum computing',
    'Machine learning',
  ];

  static const publications = <Publication>[
    Publication(
      title:
          'A DRL-based Task Offloading Strategy for Reliability and Energy Management in Vehicular Edge Computing (in preparation)',
      authors:
          'Parsa Shahidi, Moein Esnaashari, Amirmohammad Saleh, Pourya Arefi Jamal, Amirreza Kafashan, Ali Ghasemi Nejad, Sepideh Safari, and Mohsen Ansari.',
      venue: 'IEEE Transactions on Mobile Computing.',
      abstractText:
          'Modern automated vehicles (AVs) must run compute-intensive perception '
          'pipelines under hard timing and safety constraints on a power-limited '
          'on-board platform. Edge offloading can relieve this load, but its '
          'benefit depends on the instantaneous vehicular (V2X) network state, '
          'which varies with local traffic density. This paper presents a '
          'closed-loop autonomous-driving stack that jointly studies '
          'network-aware task offloading, real-time schedulability, energy, and '
          'fault-tolerant control. We contribute (i) a semantic-segmentation-based '
          'automatic emergency braking (AEB) module with a speed-adaptive danger '
          'zone; (ii) a traffic-light perception task that can execute on board or '
          'remotely; (iii) a reinforcement-learning (RL) offloading policy that '
          'adapts the offload decision to zone congestion, compared against random '
          'and no-offload baselines; (iv) a network-in-the-loop path that injects '
          'traffic-coupled V2X delay into remote perception; (v) a primary/backup '
          'collision monitor with a watchdog and fault-injection harness; and '
          '(vi) an evaluation methodology that measures reliability, quality of '
          'service (QoS), accessibility, failover latency, deadline schedulability, '
          'and task-level energy. On matched ∼4.5-minute runs, offloading raises '
          'the fraction of schedulable tasks from 0.60 to 0.80 and reduces '
          'estimated on-board energy by 18–24%, at the cost of a modest QoS drop '
          '(from 0.76 to 0.62–0.68) once V2X delay is present. The RL policy '
          'matches the random policy’s schedulability while offloading far less '
          'often (14% vs. 52% of ticks). Watchdog failover reliability stays above '
          '0.98 with mean latency 120–156 ms. These results quantify the trade-off '
          'between schedulability/energy gains and QoS under realistic network '
          'delay, and show that selective RL offloading can capture most of the '
          'benefit at a fraction of the offload rate.',
    ),
    Publication(
      title:
          'PATBox: Reproducible and Metadata-Aware Benchmarking of Photoacoustic Reconstruction Methods',
      date: 'Aug. 16, 2026',
      authors: 'Bahareh Khishkhah†, Parsa Shahidi†, and M. Reza Rahimi Tabar.',
      venue:
          'Scientific Reports (Collection: Image processing techniques for enhanced visual quality). (submitted)',
      note: '† Equal first authorship',
      figures: const [
        'assets/images/patbox/patbox-overview.png',
        'assets/images/patbox/patbox-pipeline.png',
      ],
      githubUrl: 'https://github.com/parsashu/PATBox',
      abstractText:
          'Reliable comparison of photoacoustic computed tomography reconstruction '
          'methods is challenging when forward modeling, receiver geometry, detector '
          'response, preprocessing, and image scaling vary across implementations. We '
          'present PATBox, an open-source MATLAB toolbox that combines k-Wave-based '
          'two-dimensional acoustic simulation with a unified, metadata-aware '
          'workflow for reconstruction, benchmarking, and quantitative evaluation. '
          'The validated suite comprises delay-and-sum (DAS), coherence-factor DAS '
          '(CF-DAS), sign-coherence-factor DAS (SCF-DAS), delay-multiply-and-sum '
          '(DMAS), double-stage DMAS (DS-DMAS), filtered back-projection (FBP), '
          'universal back-projection (UBP), and acoustic time reversal (TR). Method '
          'assumptions are evaluated before execution, and incompatible analytic '
          'cases are retained as expected compatibility guards rather than '
          'computational failures. PATBox was assessed using 123 unit tests, a '
          '48-case full-view benchmark, a 40-case count-fixed limited-view study, '
          'and non-ideal acquisitions incorporating acoustic heterogeneity, '
          'attenuation, finite detector aperture, detector bandwidth, and additive '
          'noise. A paired Monte Carlo study with 10 random seeds and five '
          'signal-to-noise-ratio levels produced 50 simulations and 400 algorithm '
          'outcomes. SCF-DAS achieved the highest structural similarity and '
          'signal-to-background ratio at all noise levels and significantly '
          'outperformed the runner-up after Holm correction. TR achieved the '
          'highest contrast-to-noise ratio at 5 dB, whereas DAS provided the best '
          'mean scale-invariant normalized root-mean-square error and correlation '
          'at 10–30 dB, without a significant advantage over TR after '
          'multiple-comparison correction. Performance was therefore metric- and '
          'noise-dependent. PATBox provides a reproducible platform for numerical '
          'photoacoustic research and algorithm verification.',
    ),
    Publication(
      title:
          'A Physics-Based Benchmark of Direct Beamforming Methods for Photoacoustic Computed Tomography in Heterogeneous Media',
      date: 'Jul. 16, 2026',
      authors: 'Bahareh Khishkhah†, Parsa Shahidi†, and M. Reza Rahimi Tabar.',
      venue: 'Biomedical Optics Express. (submitted)',
      note: '† Equal first authorship',
      abstractText:
          'Photoacoustic computed tomography (PACT) image quality is simultaneously '
          'affected by optical fluence variations, acoustic heterogeneity, detector '
          'aperture, angular coverage, and measurement noise. We present a '
          'comprehensive physics-based benchmark of direct beamforming methods '
          'using full-wave simulations in heterogeneous media. Eleven numerical '
          'phantoms were evaluated over multiple signal-to-noise ratios using '
          'conventional, coherence-, variance-, and adaptive minimum-variance '
          'beamforming strategies under both full- and limited-view acquisition '
          'geometries. Across all benchmark configurations, delay-and-sum (DAS) '
          'provided the most consistent preservation of extended low-amplitude '
          'structures and achieved the highest overall PSNR. Under severe full-view '
          'noise, DMAS and DASDSF improved structural similarity at the expense of '
          'signal fidelity, highlighting the inherent trade-off between artifact '
          'suppression and structural preservation. Strong coherence- and '
          'variance-based weighting further reduced clutter but progressively '
          'attenuated weak targets. In the limited-view adaptive cohort, SM-MV '
          'produced only modest, statistically non-significant structural '
          'improvements relative to DAS. Point-target experiments further showed '
          'that reduced full-width at half-maximum and sidelobe levels did not '
          'necessarily translate into improved preservation of extended vascular '
          'structures. These results establish a statistically validated benchmark '
          'for evaluating direct beamforming methods under physics-based '
          'heterogeneous PACT conditions and clarify the trade-offs among artifact '
          'suppression, structural fidelity, spatial resolution, and computational '
          'cost.',
    ),
  ];

  static const projects = <Project>[
    Project(
      title:
          'DeepRL-Based Reliability and Energy Management in Vehicular Edge Computing',
      summary:
          'I successfully defended my Bachelor’s thesis with full marks. '
          'Conducted as an elective research project with the Computer '
          'Engineering Department.',
      credit: 'Supervisors: Dr. Mohsen Ansari, Dr. Sepideh Safari',
      highlights: const [
        'Developed and evaluated a closed-loop autonomous driving system integrating Deep Reinforcement Learning (DRL) and vehicular edge computing.',
        'Built a digital-twin simulation environment combining CARLA, SUMO, OMNeT++, and ROS 2.',
        'Investigated network-aware V2X task offloading and fault-tolerant execution.',
        'Implemented and compared no-offloading, random offloading, and DRL-based offloading strategies.',
        'Implemented Triple Modular Redundancy (TMR) for safety-critical real-time tasks.',
        'Optimized latency, battery usage, Quality of Service (QoS), deadline satisfaction, and system reliability.',
      ],
      imageAsset: 'assets/images/projects/thesis-architecture.png',
      pdfUrl: 'content/thesis.pdf',
    ),
    Project(
      title: 'Protein stability enhancement',
      summary:
          'An open-source tool and web app that uses machine learning to predict '
          'and enhance protein stability, developed for my Machine Learning '
          'course under the supervision of Dr. Sadegh Raeisi.',
      highlights: const [
        'Stability prediction — evaluate protein stability directly from its sequence.',
        'Mutation suggestion — recommend targeted mutations that increase stability while preserving structural integrity.',
      ],
      imageAsset: 'assets/images/projects/ml-on-proteins.jpg',
      liveUrl: 'https://make-protein-stable.web.app/',
      githubUrl: 'https://github.com/parsashu/ML-on-Proteins',
      credit: 'Supervised by Dr. Sadegh Raeisi',
    ),
  ];

  /// Demo videos published under `web/content/` (root `content/` stays local-only).
  static const demos = <DemoVideo>[
    DemoVideo(
      title: 'Interface',
      subtitle: 'Operator UI walkthrough',
      src: 'content/ui.webm',
    ),
    DemoVideo(
      title: 'Autonomous navigation',
      subtitle: 'MPPI-based robot navigation',
      src: 'content/MPPI.mp4',
    ),
    DemoVideo(
      title: '3D LiDAR SLAM',
      subtitle: 'Lidar-based 3D mapping',
      src: 'content/mapping.webm',
    ),
    DemoVideo(
      title: 'Visual SLAM',
      subtitle: 'Online map construction',
      src: 'content/mapping1.webm',
    ),
    DemoVideo(
      title: 'Depth estimation',
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
      title: 'LiDAR SLAM',
      subtitle: 'Fast lidar-based mapping',
      src: 'content/Lidar slam fast.mp4',
    ),
  ];

  static const decks = <TalkDeck>[
    TalkDeck(
      id: 'nova',
      title: 'Room service robot',
      folder: 'nova',
      fileCount: 47,
      offset: 15,
      endTrim: 1,
    ),
    TalkDeck(
      id: 'thesis',
      title: 'Bachelor\'s Thesis',
      folder: 'thesis',
      fileCount: 62,
      aspectRatio: 210 / 297,
    ),
  ];

  static const contacts = <ContactLink>[
    ContactLink(
      id: 'email',
      label: 'p.shahidi91@gmail.com',
      url: 'mailto:p.shahidi91@gmail.com',
    ),
    ContactLink(
      id: 'linkedin',
      label: 'LinkedIn',
      url:
          'https://www.linkedin.com/in/parsa-shahidi-b459bb189/?skipRedirect=true',
    ),
    ContactLink(
      id: 'telegram',
      label: 'Telegram',
      url: 'https://t.me/parsashu',
    ),
    ContactLink(
      id: 'github',
      label: 'GitHub',
      url: 'https://github.com/parsashu',
    ),
  ];
}

class ContactLink {
  const ContactLink({
    required this.id,
    required this.label,
    required this.url,
  });

  final String id;
  final String label;
  final String url;
}
