// This is a file which contains mock data for a conference app. Final data
// will come from a remote source
// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:conf_shared_models/conf_shared_models.dart';

abstract class ConferenceMockData {
  static String _getMaleAvatar() {
    final index = Random().nextInt(10);
    return 'https://xsgames.co/randomusers/assets/avatars/male/$index.jpg';
  }

  static String _getFemaleAvatar() {
    final index = Random().nextInt(10);
    return 'https://xsgames.co/randomusers/assets/avatars/female/$index.jpg';
  }

  static Venue getVenue() => Venue(
    name: 'Universidad de Las Américas',
    address: 'Vía a Nayón, Quito 170124, Ecuador',
    latitude: -0.162645,
    longitude: -78.459199,
    capacity: 500,
  );

  static List<Speaker> getSpeakers() => [
    Speaker(
      id: 'S1',
      name: 'Juan Pérez',
      title: 'Desarrollador Senior',
      company: 'Tech Solutions',
      country: 'España',
      countryCode: 'ES',
      languages: [Language.spanish],
      description:
          'Experto en Flutter con más de 5 años de experiencia en el desarrollo de aplicaciones móviles. Ha trabajado en proyectos de gran escala y es conocido por su habilidad para liderar equipos de desarrollo.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          type: 'LinkedIn',
          link: 'https://linkedin.com/in/juanperez',
        ),
        SocialMediaLink(type: 'GitHub', link: 'https://github.com/juanperez'),
        SocialMediaLink(
          type: 'Twitter',
          link: 'https://twitter.com/juanperezdev',
        ),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S2',
      name: 'Ana García',
      title: 'Ingeniera de Software',
      company: 'Innovatech',
      country: 'México',
      countryCode: 'MX',
      languages: [Language.spanish],
      description:
          'Especialista en diseño de interfaces de usuario con experiencia en UX/UI. Ha trabajado en proyectos de aplicaciones móviles y web, y es experta en crear experiencias de usuario intuitivas y atractivas.',
      photo: _getFemaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          type: 'LinkedIn',
          link: 'https://linkedin.com/in/anagarcia',
        ),
        SocialMediaLink(type: 'Others', link: 'https://dribbble.com/anagarcia'),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S3',
      name: 'John Smith',
      title: 'Arquitecto de Software',
      company: 'Global Tech',
      country: 'Estados Unidos',
      countryCode: 'US',
      languages: [Language.english],
      description:
          'Experto en arquitectura de aplicaciones móviles con más de 10 años de experiencia. Ha diseñado sistemas escalables y seguros para empresas líderes en el sector tecnológico.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          type: 'LinkedIn',
          link: 'https://linkedin.com/in/johnsmith',
        ),
        SocialMediaLink(type: 'GitHub', link: 'https://github.com/johnsmith'),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S4',
      name: 'María Rodríguez',
      title: 'Desarrolladora de Aplicaciones Móviles',
      company: 'App Creators',
      country: 'Argentina',
      countryCode: 'AR',
      languages: [Language.spanish],
      description:
          'Especialista en desarrollo de aplicaciones móviles con Flutter. Ha trabajado en proyectos de aplicaciones sociales y de entretenimiento, y es conocida por su habilidad para crear soluciones innovadoras.',
      photo: _getFemaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          link: 'https://linkedin.com/in/mariarodriguez',
          type: 'LinkedIn',
        ),
        SocialMediaLink(
          type: 'Twitter',
          link: 'https://twitter.com/mariarodriguezdev',
        ),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S5',
      name: 'Michael Davis',
      title: 'Especialista en Inteligencia Artificial',
      company: 'AI Innovations',
      country: 'Reino Unido',
      countryCode: 'GB',
      languages: [Language.english],
      description:
          'Investigador en aplicaciones de inteligencia artificial en móviles. Ha publicado varios artículos sobre el tema y ha trabajado en proyectos de integración de IA en aplicaciones móviles.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          type: 'LinkedIn',
          link: 'https://linkedin.com/in/michaeldavis',
        ),
        SocialMediaLink(
          type: 'Others',
          link: 'https://scholar.google.com/citations?user=michaeldavis',
        ),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S6',
      name: 'Pedro Álvarez',
      title: 'Flutter Dev',
      company: 'Dev Solutions',
      country: 'Perú',
      countryCode: 'PE',
      languages: [Language.spanish],
      description:
          'Desarrollador Flutter con 3 años de experiencia en el desarrollo de aplicaciones móviles. Ha trabajado en proyectos de aplicaciones de productividad y educativas.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          type: 'LinkedIn',
          link: 'https://linkedin.com/in/pedroalvarez',
        ),
        SocialMediaLink(
          type: 'GitHub',
          link: 'https://github.com/pedroalvarez',
        ),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S7',
      name: 'Leo Farias',
      title: 'GDE Flutter & Dart',
      company: 'HiTech',
      country: 'Estados Unidos',
      countryCode: 'US',
      languages: [Language.english],
      description:
          'Experto en Flutter y Dart, conocido por su trabajo en interfaces generativas y animaciones avanzadas. Ha sido reconocido como Google Developer Expert por su contribución a la comunidad.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          link: 'https://linkedin.com/in/leofarias',
          type: 'LinkedIn',
        ),
        SocialMediaLink(link: 'https://twitter.com/leofarias', type: 'Twitter'),
        SocialMediaLink(type: 'Youtube', link: 'https://youtube.com/leofarias'),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S8',
      name: 'Kendi Jacqueline',
      title: 'Especialista en Realidad Aumentada',
      company: 'AR Tech',
      country: 'Canadá',
      countryCode: 'CA',
      languages: [Language.english],
      description:
          'Especialista en realidad aumentada con experiencia en el desarrollo de aplicaciones móviles que integran ARCore y ARKit. Ha trabajado en proyectos de realidad aumentada para la industria del entretenimiento.',
      photo: _getFemaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          link: 'https://linkedin.com/in/kendijacqueline',
          type: 'LinkedIn',
        ),
        SocialMediaLink(
          link: 'https://github.com/kendijacqueline',
          type: 'Github',
        ),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S9',
      name: 'Alex Chen',
      title: 'Especialista en Optimización de Rendimiento',
      company: 'Performance Labs',
      country: 'China',
      countryCode: 'CN',
      languages: [Language.english],
      description:
          'Experto en optimización de rendimiento de aplicaciones móviles, con experiencia en técnicas de reducción de consumo de memoria y mejora de la velocidad de carga. Ha trabajado en proyectos de aplicaciones de juegos y sociales.',
      photo: _getMaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          link: 'https://linkedin.com/in/alexchen',
          type: 'LinkedIn',
        ),
        SocialMediaLink(link: 'https://medium.com/@alexchen', type: 'Others'),
      ],
      // sessions:[],
    ),
    Speaker(
      id: 'S10',
      name: 'Eva Moreno',
      title: 'Desarrolladora Cross-Platform',
      company: 'CrossTech',
      country: 'Francia',
      countryCode: 'FR',
      languages: [Language.spanish],
      description:
          'Especialista en desarrollo de aplicaciones multiplataforma con Flutter. Ha trabajado en proyectos que requieren la compartición de código entre iOS, Android y web.',
      photo: _getFemaleAvatar(),
      socialMediaLinks: [
        SocialMediaLink(
          link: 'https://linkedin.com/in/evamoreno',
          type: 'LinkedIn',
        ),
        SocialMediaLink(
          link: 'https://twitter.com/evamorenodev',
          type: 'twitter',
        ),
      ],
      // sessions:[],
    ),
  ];

  static List<Session> getSessionsList() {
    final speakers = getSpeakers();

    return [
      // Día 1: 9 de septiembre
      Session(
        id: 'SES1',
        title: 'Introducción a la Programación Móvil con Flutter',
        description:
            'Sesión básica sobre los fundamentos de Flutter, incluyendo widgets, layouts y gestión de estado. Ideal para desarrolladores principiantes que buscan comenzar su viaje en el mundo móvil.',
        level: SessionLevel.basic,
        mainSpeaker: speakers[0],
        startTime: DateTime(2025, 9, 9, 9),
        endTime: DateTime(2025, 9, 9, 10, 30),
        track: 'Sala A',
        language: Language.spanish,
      ),
      Session(
        id: 'SES2',
        title: 'Diseño de Interfaces de Usuario Atractivas',
        description:
            'Exploración de técnicas y mejores prácticas para crear interfaces de usuario atractivas y funcionales en aplicaciones móviles, utilizando Flutter como plataforma de desarrollo.',
        level: SessionLevel.intermediate,
        mainSpeaker: speakers[1],
        startTime: DateTime(2025, 9, 9, 11),
        endTime: DateTime(2025, 9, 9, 12, 30),
        track: 'Sala B',
        language: Language.spanish,
      ),
      Session(
        id: 'SES3',
        title: 'Arquitectura de Aplicaciones Móviles Escalables',
        description:
            'Análisis de las mejores prácticas para diseñar aplicaciones móviles escalables y mantenibles, utilizando Flutter como base tecnológica. Se cubrirán temas como la separación de capas, inyección de dependencias y gestión de estado.',
        level: SessionLevel.advanced,
        mainSpeaker: speakers[2],
        startTime: DateTime(2025, 9, 9, 14),
        endTime: DateTime(2025, 9, 9, 15, 30),
        track: 'Sala A',
        language: Language.english,
      ),
      Session(
        id: 'SES7',
        title: 'Desarrollo de Aplicaciones Web Modernas',
        description:
            'Cómo utilizar Flutter para crear aplicaciones web modernas y responsivas, aprovechando las ventajas de la plataforma para desarrollar experiencias multiplataforma.',
        level: SessionLevel.intermediate,
        mainSpeaker: speakers[3],
        startTime: DateTime(2025, 9, 9, 16),
        endTime: DateTime(2025, 9, 9, 17, 30),
        track: 'Sala B',
        language: Language.spanish,
      ),
      Session(
        id: 'SES8',
        title: 'Integración de Servicios en el Backend',
        description:
            'Guía práctica sobre cómo integrar servicios de backend como Firebase en aplicaciones móviles desarrolladas con Flutter, cubriendo temas de autenticación, almacenamiento y bases de datos en la nube.',
        level: SessionLevel.intermediate,
        mainSpeaker: speakers[4],
        startTime: DateTime(2025, 9, 9, 18),
        endTime: DateTime(2025, 9, 9, 19, 30),
        track: 'Sala A',
        language: Language.english,
      ),

      // Día 2: 10 de septiembre
      Session(
        id: 'SES4',
        title: 'Taller Práctico de Desarrollo Móvil',
        description:
            'Taller práctico donde los participantes podrán desarrollar una aplicación móvil completa utilizando Flutter, cubriendo desde la creación de la interfaz hasta la implementación de funcionalidades básicas.',
        level: SessionLevel.intermediate,
        mainSpeaker: speakers[5],
        startTime: DateTime(2025, 9, 10, 9),
        endTime: DateTime(2025, 9, 10, 10, 30),
        track: 'Sala B',
        language: Language.spanish,
      ),
      Session(
        id: 'SES5',
        title: 'Optimización del Rendimiento en Aplicaciones Móviles',
        description:
            'Técnicas avanzadas para mejorar el rendimiento de aplicaciones móviles desarrolladas con Flutter, incluyendo optimización de gráficos, reducción de consumo de memoria y mejoras en la experiencia del usuario.',
        level: SessionLevel.advanced,
        mainSpeaker: speakers[6],
        startTime: DateTime(2025, 9, 10, 11),
        endTime: DateTime(2025, 9, 10, 12, 30),
        track: 'Sala A',
        language: Language.english,
      ),
      Session(
        id: 'SES6',
        title: 'Realidad Aumentada en Aplicaciones Móviles',
        description:
            'Cómo utilizar tecnologías de realidad aumentada en aplicaciones móviles desarrolladas con Flutter, explorando frameworks como ARCore y ARKit para crear experiencias inmersivas.',
        level: SessionLevel.expert,
        mainSpeaker: speakers[7],
        startTime: DateTime(2025, 9, 10, 14),
        endTime: DateTime(2025, 9, 10, 15, 30),
        track: 'Sala A',
        language: Language.spanish,
      ),
      Session(
        id: 'SES9',
        title: 'Tendencias Futuras en el Desarrollo Móvil',
        description:
            'Análisis de las próximas tendencias y actualizaciones en el desarrollo móvil, incluyendo cómo Flutter se está posicionando en el mercado y qué nuevas características se esperan en futuras versiones.',
        level: SessionLevel.advanced,
        mainSpeaker: speakers[8],
        startTime: DateTime(2025, 9, 10, 16),
        endTime: DateTime(2025, 9, 10, 17, 30),
        track: 'Sala B',
        language: Language.english,
      ),
      Session(
        id: 'SES10',
        title: 'Desarrollo de Aplicaciones Multiplataforma',
        description:
            'Estrategias para desarrollar aplicaciones multiplataforma utilizando Flutter, cubriendo temas como la compartición de código entre plataformas y la adaptación de interfaces para diferentes dispositivos.',
        level: SessionLevel.intermediate,
        mainSpeaker: speakers[9],
        startTime: DateTime(2025, 9, 10, 18),
        endTime: DateTime(2025, 9, 10, 19, 30),
        track: 'Sala A',
        language: Language.spanish,
      ),
    ];
  }
}
