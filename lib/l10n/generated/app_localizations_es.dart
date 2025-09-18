// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'FlutterConf LATAM';

  @override
  String get navigationBarLabel => 'Navegación';

  @override
  String get homeTabLabel => 'Inicio';

  @override
  String get agendaTabLabel => 'Agenda';

  @override
  String get speakersTabLabel => 'Speakers';

  @override
  String get sponsorsTabLabel => 'Sponsors';

  @override
  String get venueTabLabel => 'Venue';

  @override
  String get moreTabLabel => 'Más';

  @override
  String get moreTabTooltip => 'Información de la conferencia y consejos';

  @override
  String get venueBannerTitle => 'Próxima parada';

  @override
  String get venueBannerSemanticsLabel => 'Información del lugar de el evento';

  @override
  String get venueBannerSemanticsHint => 'Toca para ver detalles del lugar';

  @override
  String speakerCardSemanticLabel(String name, String title) {
    return '$name, $title, toca para ver detalles';
  }

  @override
  String get speaker => 'Speaker';

  @override
  String get coSpeakersLabel => 'Co-speakers';

  @override
  String get magicBeginsLabel => 'La magia comienza en';

  @override
  String get days => 'días';

  @override
  String get hours => 'horas';

  @override
  String get minutes => 'minutos';

  @override
  String get seconds => 'segundos';

  @override
  String get homeTabTooltip => 'Pantalla de inicio con resumen del evento';

  @override
  String get agendaTabTooltip => 'Ver programa de la conferencia';

  @override
  String get speakersTabTooltip => 'Explorar ponentes de la conferencia';

  @override
  String get venueTabTooltip => 'Información del lugar de la conferencia';

  @override
  String conferenceDates(int startDay, int endDay) {
    return '$startDay y $endDay de Septiembre';
  }

  @override
  String get sessionLevelBasic => 'Básico';

  @override
  String get sessionLevelIntermediate => 'Intermedio';

  @override
  String get sessionLevelAdvanced => 'Avanzado';

  @override
  String get sessionLevelExpert => 'Experto';

  @override
  String get sessionDescriptionLabel => 'Descripción';

  @override
  String get sessionNoDataAvailable => 'Información de la sesión no disponible';

  @override
  String sessionDetailsSemanticLabel(String title) {
    return 'Detalles de la sesión: $title';
  }

  @override
  String get sessionFavoriteTooltip => 'Agregar a favoritos';

  @override
  String get sessionShareTooltip => 'Compartir sesión';

  @override
  String sessionsForDate(String date) {
    return 'Sesiones para $date';
  }

  @override
  String get sessionCardHint => 'Toca para ver detalles de la sesión';

  @override
  String get actionGetDirections => 'Cómo llegar';

  @override
  String get sectionTitleVenue => 'Información del lugar';

  @override
  String get sectionTitleAccessibility => 'Accesibilidad';

  @override
  String get errorMapsOpen => 'No se pudo abrir la aplicación de mapas';

  @override
  String get facilitiesCampusTitle => 'Instalaciones del Campus';

  @override
  String get facilitiesCampusDescription =>
      'El lugar cuenta con aulas modernas, auditorios y espacios para networking equipados con WiFi de alta velocidad en todo el campus.';

  @override
  String get facilitiesFoodTitle => 'Comida y Bebidas';

  @override
  String get facilitiesFoodDescription =>
      'Hay varias cafeterías y opciones de comida disponibles en el campus, con menús especiales preparados para los asistentes a la conferencia.';

  @override
  String get navigatingCampusTitle => 'Cómo Moverse';

  @override
  String get navigatingCampusDescription =>
      'El campus es fácil de navegar con una señalización clara. Personal del evento con camisas azules de Flutter estará disponible para ayudar con las direcciones.';

  @override
  String get accessibilityDescription =>
      'El lugar es totalmente accesible con rampas, ascensores y baños accesibles. Contacta a los organizadores si necesitas alguna adaptación especial.';

  @override
  String venueCapacity(String capacity) {
    return 'Capacidad: $capacity personas';
  }

  @override
  String get imageVenueDescription =>
      'Imagen del campus de la Universidad de las Américas';

  @override
  String get sectionTitleSafety => 'Consejos de Seguridad';

  @override
  String get sectionTitleTransportation => 'Transporte';

  @override
  String get sectionTitleFood => 'Comida';

  @override
  String get sectionTitleMoney => 'Dinero';

  @override
  String get sectionTitleWeather => 'Clima';

  @override
  String get safetyPrecautionsTipTitle => 'Precauciones de Seguridad';

  @override
  String get safetyPrecautionsTipDescription =>
      'Evita llevar grandes cantidades de dinero y mantén tus objetos de valor seguros en áreas concurridas.';

  @override
  String get emergencyContactsTipTitle => 'Contactos de Emergencia';

  @override
  String get emergencyContactsTipDescription =>
      'Marca 911 para policía, ambulancia o bomberos. Para asistencia al turista, llama al +593-123-AYUDA.';

  @override
  String get taxisTipTitle => 'Taxis y Transporte';

  @override
  String get taxisTipDescription =>
      'Usa taxis autorizados o aplicaciones como Uber y Cabify. Evita tomar taxis no registrados.';

  @override
  String get deliveryAppsTipTitle => 'Aplicaciones de Entrega';

  @override
  String get deliveryAppsTipDescription =>
      'Las opciones populares incluyen Rappi y Uber Eats para un servicio rápido y confiable.';

  @override
  String get localRestaurantsTipTitle => 'Restaurantes Locales';

  @override
  String get localRestaurantsTipDescription =>
      'Prueba platos ecuatorianos como el \"locro\" o \"ceviche\" en restaurantes cercanos como Café Quito.';

  @override
  String get currencyTipTitle => 'Moneda y Pagos';

  @override
  String get currencyTipDescription =>
      'En Ecuador se utilizan dólares estadounidenses. Las tarjetas de crédito son ampliamente aceptadas, pero mantén billetes pequeños para taxis o vendedores ambulantes.';

  @override
  String get atmsTipTitle => 'Cajeros Automáticos y Cambio de Divisas';

  @override
  String get atmsTipDescription =>
      'Hay cajeros automáticos disponibles en toda la ciudad. Evita usar cajeros en áreas aisladas o mal iluminadas por la noche.';

  @override
  String get weatherTipTitle => 'Consejos sobre el Clima';

  @override
  String get weatherTipDescription =>
      '¡Trae ropa por capas! El clima de Quito puede cambiar de cálido y soleado a fresco y lluvioso en minutos.';

  @override
  String get actionRetry => 'Reintentar';

  @override
  String get errorSessionsNone => 'No hay sesiones disponibles';

  @override
  String errorSessionsNoneForDay(String date) {
    return 'No hay sesiones programadas para el $date';
  }

  @override
  String get errorSponsorsNone => 'No hay patrocinadores disponibles';

  @override
  String get errorSpeakersNone => 'No hay ponentes disponibles';

  @override
  String get stateLoadingAgenda => 'Cargando agenda';

  @override
  String get stateLoadingSessions => 'Cargando sesiones';

  @override
  String get stateLoadingSpeakers => 'Cargando speakers';

  @override
  String get stateLoadingSponsors => 'Cargando sponsors';

  @override
  String get speaks => 'Habla';

  @override
  String get iSpeakPrefix => 'Hablo';

  @override
  String iSpeakLanguages(String languages) {
    return 'Hablo $languages';
  }

  @override
  String countryFlag(String country) {
    return 'bandera de $country';
  }

  @override
  String get agendaPreviewEmptyMessage =>
      'Aún no hay sesiones para mostrar. ¡Vuelve pronto!';

  @override
  String get favoriteSessionsLabel => 'Sesiones Favoritas';

  @override
  String get favoriteSessionsTooltip => 'Mostrar sesiones favoritas';

  @override
  String get filterButtonLabel => 'Filtros';

  @override
  String dateSelectedAnnouncement(String date) {
    return 'Mostrando sesiones para $date';
  }

  @override
  String venueBannerSemanticLabel(
    String venueName,
    String location,
    String dates,
  ) {
    return 'Sede: $venueName. Ubicación: $location. Fechas: $dates';
  }

  @override
  String get userProfileLabel => 'Perfil de Usuario';

  @override
  String get userProfileHint => 'Toca para ver tu perfil';

  @override
  String get userProfileTooltip => 'Ver perfil de usuario';

  @override
  String get filterSpeakersTooltip => 'Filtrar speakers';

  @override
  String get agendaNavigationDescription =>
      '¡2 días llenos de charlas, talleres, dinámicas y premios!';

  @override
  String get speakersNavigationDescription =>
      '¡Más de 20 speakers de 5 países diferentes';

  @override
  String get sponsorsNavigationDescription =>
      'Aliados y amigos que nos apoyan a hacer esto posible';

  @override
  String get sponsorTierPlatinum => 'Platinum';

  @override
  String get sponsorTierGold => 'Gold';

  @override
  String get sponsorTierSilver => 'Silver';

  @override
  String get sponsorTierBronze => 'Bronce';

  @override
  String get sponsorTierInkind => 'En especie';

  @override
  String get sponsorTierSenior => 'Senior';

  @override
  String get sponsorTierJunior => 'Junior';

  @override
  String get sponsorTierOther => 'Otros';

  @override
  String get dontBeShyLabel => '¡No seas tímido y salúdame!';

  @override
  String get languageEnglish => 'inglés';

  @override
  String get languageSpanish => 'español';

  @override
  String get conjunctionAnd => 'y';

  @override
  String get socialNetworkOther => 'Otro';

  @override
  String get socialProfilePrefix => 'Abre perfil en ';

  @override
  String get contactSectionTitle => 'Sigamos en contacto';

  @override
  String get errorCannotOpenLink => 'No se puede abrir el enlace';

  @override
  String get errorGeneric => 'Ha ocurrido un error';
}
