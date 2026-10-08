/// EDIT ME — every word on the site lives here.
/// Update this file and the whole portfolio follows.
abstract class Content {
  static const name = 'Kamlesh Savale';
  static const role = 'Full-Stack Developer';
  static const greeting = "Hello, I'm";
  static const intro =
      'Computer science student building full-stack projects end to end — '
      'a Flutter shopping app, a Python recipe recommender — and looking '
      'for the next thing to build.';
  static const status = 'Studying computer science · open to internships';
  static const location = 'Mumbai, India';

  static const github = 'https://github.com/Kamlesh2112';
  static const handle = '@Kamlesh2112';
  static const linkedin = 'https://www.linkedin.com/in/kamlesh-savale-744327244';
  static const email = 'kamlesh2112sawale@gmail.com';

  // ── Nav: mono number + label ──
  static const nav = [
    NavLink(number: '01', label: 'About', target: 'about'),
    NavLink(number: '02', label: 'Skills', target: 'skills'),
    NavLink(number: '03', label: 'Projects', target: 'projects'),
    NavLink(number: '04', label: 'Contact', target: 'contact'),
  ];

  // ── About ──
  static const aboutTitle = 'From blank file to working product.';
  static const aboutBody =
      'I like taking an idea all the way from a blank file to something people can '
      'actually use. That\'s meant building a Flutter app that recreates Amazon\'s core '
      'shopping flow, and a recommendation tool that suggests recipes from whatever\'s '
      'already in your kitchen — two different problems, each teaching me something new '
      'about writing for real users rather than just passing tests.';
  static const focus = [
    'Flutter · cross-platform apps',
    'Python · recommendation systems',
    'Firebase · realtime backends',
  ];

  // ── Skills ──
  static const skillsTitle = 'What I work with.';
  static const skillGroups = [
    SkillGroup(
      label: 'Languages',
      items: ['Dart', 'Python', 'JavaScript', 'HTML', 'CSS', 'SQL'],
    ),
    SkillGroup(
      label: 'Frameworks & Tools',
      items: ['Flutter', 'Firebase', 'Node.js', 'Express', 'MongoDB', 'Git', 'REST APIs'],
    ),
  ];

  // ── Projects ──
  static const projectsTitle = 'Selected projects.';
  static const projects = [
    Project(
      title: 'Full-Stack Amazon Clone',
      summary:
          'A cross-platform shopping app that rebuilds Amazon\'s core flow — '
          'product browsing, cart, and checkout — with a responsive interface '
          'on Android and iOS, backed by a Node.js API.',
      points: [
        'End-to-end shopping flow: browse, cart, checkout',
        'Express + MongoDB backend with REST APIs',
        'Responsive Flutter UI for Android and iOS',
      ],
      tags: ['Flutter', 'Node.js', 'Express', 'MongoDB'],
      url: 'https://github.com/Kamlesh2112/Full-Stack-Amazon-Clone',
    ),
    Project(
      title: 'Recipe Recommendation App',
      summary:
          'Suggests recipes based on the ingredients already in your kitchen, '
          'so you spend less time deciding what to cook and less food goes '
          'to waste.',
      points: [
        'Ingredient-based recipe recommendations',
        'Built around reducing food waste',
        'Simple, calm cooking-first UX',
      ],
      tags: ['Dart', 'Flutter', 'Recommendations'],
      url: 'https://github.com/Kamlesh2112/recipe-recommendation',
    ),
  ];

  // ── Contact ──
  static const contactTitle = 'Get in touch.';
  static const contactHeadline = 'Let’s build something together.';
  static const contactBody =
      'Open to internships and full-stack roles, and always happy to talk '
      'through a project. The fastest way to reach me is email — or find me '
      'on GitHub and LinkedIn.';
  static const contactCta = 'GitHub';
  static const contactCtaSecondary = 'LinkedIn';

  // ── Footer ──
  static const designedBy = 'Designed & Built by Kamlesh Savale';
  static const madeWith = 'Made with';
  static const madeWithSuffix = 'in Flutter';
}

class NavLink {
  final String number;
  final String label;
  final String target;
  const NavLink({required this.number, required this.label, required this.target});
}

class SkillGroup {
  final String label;
  final List<String> items;
  const SkillGroup({required this.label, required this.items});
}

class Project {
  final String title;
  final String summary;
  final List<String> points;
  final List<String> tags;
  final String url;
  const Project({
    required this.title,
    required this.summary,
    required this.points,
    required this.tags,
    required this.url,
  });
}
