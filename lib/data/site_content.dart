class Project {
  const Project({
    required this.title,
    required this.summary,
    required this.highlights,
    this.imageAsset,
    this.galleryFigures = const [],
    this.galleryVideos = const [],
    this.liveUrl,
    this.liveLabel = 'Website',
    this.githubUrl,
    this.pdfUrl,
    this.credit,
  });

  final String title;
  final String summary;
  final List<String> highlights;
  final String? imageAsset;
  final List<String> galleryFigures;
  final List<DemoVideo> galleryVideos;
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
    this.src,
    this.mobileSrc,
    this.imageAsset,
    this.galleryTile = false,
    this.galleryAspectRatio = 16 / 10,
    this.gallerySizeFactor = 1,
  });

  final String title;
  final String subtitle;
  final String? src;
  final String? mobileSrc;
  final String? imageAsset;
  final bool galleryTile;
  final double galleryAspectRatio;
  final double gallerySizeFactor;
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
      credit: 'Supervisors: Prof. Dr. Mohsen Ansari, Dr. Sepideh Safari',
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
      title: 'Second bachelor project',
      summary:
          'Conducted as a research project with the Physics Department on '
          'photoacoustic computed tomography (PACT). I built an open-source '
          'MATLAB package and benchmark for simulation, reconstruction, and '
          'method comparison — work that later fed into the PATBox publications.',
      credit: 'Supervisor: Prof. Dr. Reza Rahimi Tabar',
      highlights: const [
        'Built k-Wave forward simulations for linear, square, and circular sensor geometries with controllable noise and grid settings.',
        'Implemented and compared classical PACT reconstruction methods (DAS, CF-DAS, DMAS, DS-DMAS, UBP, time reversal, iterative variants, and related beamformers).',
        'Developed quantitative evaluation and algorithm benchmarking (PSNR, SSIM, CNR, SBR, runtime, and related metrics) across acquisition setups.',
        'Packaged the workflow as PATBox — a metadata-aware MATLAB toolbox for reproducible simulation, reconstruction, and method comparison.',
        'Explored deep-learning reconstruction paths (signal- and image-domain U-Nets) alongside traditional beamforming baselines.',
      ],
      imageAsset: 'assets/images/patbox/patbox-pipeline.png',
      githubUrl: 'https://github.com/parsashu/PAT',
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
    Project(
      title: 'Simulation & computational physics',
      summary:
          'A collection of Python simulations developed for my Simulation and '
          'Computational Physics course, covering fractals, statistical '
          'mechanics, Monte Carlo methods, chaos theory, and agent-based models.',
      credit: 'Instructor: Prof. Dr. Mohammad Reza Ejtehadi',
      highlights: const [
        'Fractals — Julia sets, Koch curves, Sierpinski triangles, dragon curves, and related self-similar generators.',
        'Surface deposition — bottom-up, competitive, and lateral deposition growth models.',
        'Percolation — site/bond percolation, Hoshen–Kopelman labeling, cluster growth, and finite-size scaling.',
        'Random walks & DLA — 1D/2D random walks, self-avoiding walks, and diffusion-limited aggregation.',
        'Random number generation — pseudorandom generators, Gaussian sampling, and central-limit-theorem validation.',
        'Monte Carlo integration — high-dimensional sampling and variance-reduction estimators.',
        'Ising model — Metropolis Monte Carlo simulation of spin lattices and magnetic domain formation.',
        'ODE solvers — numerical integration for RC-circuit dynamics.',
        'Chaos & bifurcations — algorithmic instability, driven oscillators, and the logistic-map route to chaos.',
        'Molecular dynamics — Lennard–Jones particle simulations.',
        'Schelling segregation — agent-based model of emergent spatial segregation.',
      ],
      imageAsset: 'assets/images/projects/comp-physics/julia-sets.jpg',
      galleryFigures: const [
        'assets/images/projects/comp-physics/julia-sets-2.jpg',
        'assets/images/projects/comp-physics/dla.png',
        'assets/images/projects/comp-physics/schelling-model.gif',
      ],
      githubUrl: 'https://github.com/parsashu/computational-physics',
    ),
  ];

  static const otherProjects = <Project>[
    Project(
      title: 'Percolation simulation',
      summary:
          'Course project for Complex Systems: site percolation on 2D lattices '
          'with cluster identification, spanning-cluster detection, and '
          'visualization near the percolation threshold.',
      credit: 'Instructor: Prof. Dr. Shahin Rouhani',
      highlights: const [
        'Coloring algorithm — labels connected occupied neighbors by recursively assigning the same cluster color across the lattice.',
        'Hoshen–Kopelman algorithm — union-find cluster labeling that efficiently identifies connected components and checks for percolation.',
        'Compared both methods for cluster detection on lattices up to 1000×1000 near p_c ≈ 0.59.',
        'Visualized percolating clusters and studied how spanning paths emerge at the critical occupancy probability.',
      ],
      imageAsset: 'assets/images/projects/percolation-clusters.png',
      githubUrl:
          'https://github.com/parsashu/Percolation-Sim---Complex-System-Course-',
    ),
    Project(
      title: 'Particle life',
      summary:
          'Course project for Biophysics: a particle-life simulation where '
          'complex collective behavior emerges from simple pairwise forces and '
          'interactions between particle types.',
      credit: 'Instructor: Prof. Dr. Nader Reihani',
      highlights: const [
        'Four particle species interact through a tunable attraction–repulsion force matrix.',
        'Spatial partitioning accelerates pairwise force updates for hundreds of particles in real time.',
        'Short-range repulsion and friction stabilize motion while preserving emergent structure.',
        'Self-organizing clusters, orbits, and filaments arise from local rules alone.',
        'Interactive Pygame visualization of particles and the live force matrix.',
      ],
      imageAsset: 'assets/images/projects/particle-life.png',
      githubUrl: 'https://github.com/parsashu/Particle-life',
    ),
    Project(
      title: 'Random walk & polymer',
      summary:
          'Biophysics course project simulating polymer chains with the '
          'freely jointed chain (FJC) model — from 3D random walks to '
          'end-to-end statistics and force–extension behavior.',
      credit: 'Instructor: Prof. Dr. Nader Reihani',
      highlights: const [
        'Implemented 1D and 3D random-walk simulations and analyzed mean-squared displacement.',
        'Modeled polymers as freely jointed chains with randomly oriented rigid segments.',
        'Computed end-to-end distance distributions and compared results to theory.',
        'Visualized polymer conformations in 3D and studied how chain length affects reach.',
        'Simulated force–extension response with directional bias and compared grid vs. free-joint forms.',
      ],
      imageAsset: 'assets/images/projects/random-walk-polymer.png',
      githubUrl: 'https://github.com/parsashu/RandomWalk-and-Polymer',
    ),
    Project(
      title: 'Oscillating dipoles',
      summary:
          'Electromagnetism II course project numerically computing radiation '
          'from oscillating electric dipoles and comparing exact retarded-potential '
          'results with Griffiths’ approximate far-field theory.',
      credit: 'Instructor: Prof. Dr. Shant Baghram',
      highlights: const [
        'Simulated charge-oscillating and length-oscillating dipole models.',
        'Built retarded scalar and vector potentials with fixed-point iteration for moving charges.',
        'Computed Poynting-vector intensity and compared with Griffiths §11.1.2 predictions.',
        'Verified far-field scaling (I ∝ r⁻²) and angular sin²θ dependence numerically.',
      ],
      githubUrl: 'https://github.com/parsashu/Oscillating-Dipoles',
    ),
  ];

  /// Demo videos published under `web/content/optimized/` (generated by
  /// `scripts/optimize_videos.sh` for progressive streaming).
  static const demos = <DemoVideo>[
    DemoVideo(
      title: 'Path optimizer',
      subtitle: 'Operator UI walkthrough',
      src: 'content/optimized/ui.mp4',
      mobileSrc: 'content/optimized/ui-mobile.mp4',
    ),
    DemoVideo(
      title: 'Room service robot simulation',
      subtitle: 'Simulated in Gazebo',
      src: 'content/optimized/room-service-robot.mp4',
      mobileSrc: 'content/optimized/room-service-robot-mobile.mp4',
    ),
    DemoVideo(
      title: 'Human detection',
      subtitle: 'Office environment in Gazebo',
      src: 'content/optimized/human-detection.mp4',
      mobileSrc: 'content/optimized/human-detection-mobile.mp4',
    ),
    DemoVideo(
      title: 'Autonomous navigation',
      subtitle: 'MPPI-based robot navigation',
      src: 'content/optimized/mppi.mp4',
      mobileSrc: 'content/optimized/mppi-mobile.mp4',
    ),
    DemoVideo(
      title: '3D LiDAR SLAM',
      subtitle: 'Lidar-based 3D mapping',
      src: 'content/optimized/mapping.mp4',
      mobileSrc: 'content/optimized/mapping-mobile.mp4',
    ),
    DemoVideo(
      title: 'Visual SLAM',
      subtitle: 'Online map construction',
      src: 'content/optimized/mapping1.mp4',
      mobileSrc: 'content/optimized/mapping1-mobile.mp4',
    ),
    DemoVideo(
      title: 'Depth estimation',
      subtitle: 'Monocular depth estimation',
      src: 'content/optimized/depth-anything.mp4',
      mobileSrc: 'content/optimized/depth-anything-mobile.mp4',
    ),
    DemoVideo(
      title: 'Segmentation',
      subtitle: 'Scene understanding',
      src: 'content/optimized/segmentation.mp4',
      mobileSrc: 'content/optimized/segmentation-mobile.mp4',
    ),
    DemoVideo(
      title: 'Traffic Light',
      subtitle: 'Perception for urban driving',
      src: 'content/optimized/traffic-light.mp4',
      mobileSrc: 'content/optimized/traffic-light-mobile.mp4',
    ),
    DemoVideo(
      title: 'AEB',
      subtitle: 'Automatic emergency braking',
      src: 'content/optimized/aeb1.mp4',
      mobileSrc: 'content/optimized/aeb1-mobile.mp4',
    ),
    DemoVideo(
      title: 'Robot Arm',
      subtitle: 'Manipulator in Isaac Sim + MoveIt2 + LeRobot',
      src: 'content/optimized/arm.mp4',
      mobileSrc: 'content/optimized/arm-mobile.mp4',
    ),
    DemoVideo(
      title: 'LiDAR SLAM',
      subtitle: 'Fast lidar-based mapping',
      src: 'content/optimized/lidar-slam-fast.mp4',
      mobileSrc: 'content/optimized/lidar-slam-fast-mobile.mp4',
    ),
    DemoVideo(
      title: 'Particle life',
      subtitle: 'Emergent behavior from simple interactions',
      src: 'content/optimized/introduction.mp4',
      mobileSrc: 'content/optimized/introduction-mobile.mp4',
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
