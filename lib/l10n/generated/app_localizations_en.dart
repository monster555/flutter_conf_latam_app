// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'FlutterConf LATAM';

  @override
  String get navigationBarLabel => 'Navigation';

  @override
  String get homeTabLabel => 'Home';

  @override
  String get agendaTabLabel => 'Agenda';

  @override
  String get speakersTabLabel => 'Speakers';

  @override
  String get sponsorsTabLabel => 'Sponsors';

  @override
  String get venueTabLabel => 'Venue';

  @override
  String get moreTabLabel => 'More';

  @override
  String get moreTabTooltip => 'Conference information and tips';

  @override
  String get venueBannerTitle => 'Next stop';

  @override
  String get venueBannerSemanticsLabel => 'Conference venue information';

  @override
  String get venueBannerSemanticsHint => 'Tap to see venue details';

  @override
  String speakerCardSemanticLabel(String name, String title) {
    return '$name, $title, tap to view details';
  }

  @override
  String get speaker => 'Speaker';

  @override
  String get coSpeakersLabel => 'Co-speakers';

  @override
  String get magicBeginsLabel => 'The magic begins in';

  @override
  String get days => 'days';

  @override
  String get hours => 'hours';

  @override
  String get minutes => 'minutes';

  @override
  String get seconds => 'seconds';

  @override
  String get homeTabTooltip => 'Home screen with event overview';

  @override
  String get agendaTabTooltip => 'Conference schedule by day and time';

  @override
  String get speakersTabTooltip => 'Conference speakers and presentations';

  @override
  String get venueTabTooltip => 'Venue information and location';

  @override
  String conferenceDates(int startDay, int endDay) {
    return 'September $startDay - $endDay';
  }

  @override
  String get sessionLevelBasic => 'Basic';

  @override
  String get sessionLevelIntermediate => 'Intermediate';

  @override
  String get sessionLevelAdvanced => 'Advanced';

  @override
  String get sessionLevelExpert => 'Expert';

  @override
  String get sessionDescriptionLabel => 'Description';

  @override
  String get sessionNoDataAvailable => 'No session data available';

  @override
  String sessionDetailsSemanticLabel(String title) {
    return 'Session details for: $title';
  }

  @override
  String get sessionFavoriteTooltip => 'Add to favorites';

  @override
  String get sessionShareTooltip => 'Share this session';

  @override
  String sessionsForDate(String date) {
    return 'Sessions for $date';
  }

  @override
  String get sessionCardHint => 'Tap to view session details';

  @override
  String get actionGetDirections => 'Get Directions';

  @override
  String get sectionTitleVenue => 'Venue Information';

  @override
  String get sectionTitleAccessibility => 'Accessibility';

  @override
  String get errorMapsOpen => 'Unable to open maps application';

  @override
  String get facilitiesCampusTitle => 'Campus Facilities';

  @override
  String get facilitiesCampusDescription =>
      'The venue offers modern classrooms, auditoriums, and networking spaces equipped with high-speed WiFi throughout the campus.';

  @override
  String get facilitiesFoodTitle => 'Food & Refreshments';

  @override
  String get facilitiesFoodDescription =>
      'Several cafeterias and food options are available on campus, with special menus prepared for conference attendees.';

  @override
  String get navigatingCampusTitle => 'Getting Around';

  @override
  String get navigatingCampusDescription =>
      'The campus is easy to navigate with clear signage. Event staff in Flutter blue shirts will be available to help with directions.';

  @override
  String get accessibilityDescription =>
      'The venue is fully accessible with ramps, elevators, and accessible restrooms. Contact the organizers if you need any special accommodations.';

  @override
  String venueCapacity(String capacity) {
    return 'Capacity: $capacity people';
  }

  @override
  String get imageVenueDescription =>
      'Image of Universidad de las Américas campus';

  @override
  String get sectionTitleSafety => 'Safety Tips';

  @override
  String get sectionTitleTransportation => 'Transportation';

  @override
  String get sectionTitleFood => 'Food';

  @override
  String get sectionTitleMoney => 'Money';

  @override
  String get sectionTitleWeather => 'Weather';

  @override
  String get safetyPrecautionsTipTitle => 'Safety Precautions';

  @override
  String get safetyPrecautionsTipDescription =>
      'Avoid carrying large amounts of cash, and keep valuables secure in crowded areas.';

  @override
  String get emergencyContactsTipTitle => 'Emergency Contacts';

  @override
  String get emergencyContactsTipDescription =>
      'Dial 911 for police, ambulance, or fire services. For tourist assistance, call +593-123-HELP.';

  @override
  String get taxisTipTitle => 'Taxis and Rideshares';

  @override
  String get taxisTipDescription =>
      'Use authorized taxis or apps like Uber and Cabify. Avoid hailing unregistered taxis.';

  @override
  String get deliveryAppsTipTitle => 'Delivery Apps';

  @override
  String get deliveryAppsTipDescription =>
      'Popular options include Rappi and Uber Eats for fast and reliable service.';

  @override
  String get localRestaurantsTipTitle => 'Local Restaurants';

  @override
  String get localRestaurantsTipDescription =>
      'Taste Ecuadorian favorites like \"locro\" or \"ceviche\" at nearby restaurants like Café Quito.';

  @override
  String get currencyTipTitle => 'Currency and Payments';

  @override
  String get currencyTipDescription =>
      'US dollars are used in Ecuador. Credit cards are widely accepted, but keep small bills for taxis or street vendors.';

  @override
  String get atmsTipTitle => 'ATMs and Currency Exchange';

  @override
  String get atmsTipDescription =>
      'ATMs are available across the city. Avoid using ATMs in isolated or poorly lit areas at night.';

  @override
  String get weatherTipTitle => 'Weather Tips';

  @override
  String get weatherTipDescription =>
      'Bring layers! Quito\'s weather can change from warm and sunny to cool and rainy in minutes.';

  @override
  String get actionRetry => 'Retry';

  @override
  String get errorSessionsNone => 'No sessions available';

  @override
  String errorSessionsNoneForDay(String date) {
    return 'No sessions scheduled for $date';
  }

  @override
  String get errorSponsorsNone => 'No sponsors available';

  @override
  String get errorSpeakersNone => 'No speakers available';

  @override
  String get stateLoadingAgenda => 'Loading Agenda';

  @override
  String get stateLoadingSessions => 'Loading Sessions';

  @override
  String get stateLoadingSpeakers => 'Loading Speakers';

  @override
  String get stateLoadingSponsors => 'Loading Sponsors';

  @override
  String get speaks => 'Speaks';

  @override
  String get iSpeakPrefix => 'I speak';

  @override
  String iSpeakLanguages(String languages) {
    return 'I speak $languages';
  }

  @override
  String countryFlag(String country) {
    return '$country flag';
  }

  @override
  String get agendaPreviewEmptyMessage =>
      'No sessions to preview yet. Check back soon!';

  @override
  String get favoriteSessionsLabel => 'Favorite Sessions';

  @override
  String get favoriteSessionsTooltip => 'Show favorite sessions';

  @override
  String get filterButtonLabel => 'Filters';

  @override
  String dateSelectedAnnouncement(String date) {
    return 'Showing sessions for $date';
  }

  @override
  String venueBannerSemanticLabel(
    String venueName,
    String location,
    String dates,
  ) {
    return 'Venue: $venueName. Location: $location. Dates: $dates';
  }

  @override
  String get userProfileLabel => 'User profile';

  @override
  String get userProfileHint => 'Tap to view your profile and settings';

  @override
  String get userProfileTooltip => 'Your profile';

  @override
  String get filterSpeakersTooltip => 'Filter speakers';

  @override
  String get agendaNavigationDescription =>
      '2 days full of talks, workshops, activities and prizes!';

  @override
  String get speakersNavigationDescription =>
      'Over 20 speakers from 5 different countries';

  @override
  String get sponsorsNavigationDescription =>
      'Partners and friends who help make this possible';

  @override
  String get sponsorTierPlatinum => 'Platinum';

  @override
  String get sponsorTierGold => 'Gold';

  @override
  String get sponsorTierSilver => 'Silver';

  @override
  String get sponsorTierInkind => 'In-kind';

  @override
  String get sponsorTierSenior => 'Senior';

  @override
  String get sponsorTierOther => 'Others';

  @override
  String get dontBeShyLabel => 'Don\'t be shy and say hi!';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get conjunctionAnd => 'and';

  @override
  String get socialNetworkOther => 'Other';

  @override
  String get socialProfilePrefix => 'Open profile on ';

  @override
  String get contactSectionTitle => 'Let\'s keep in touch';

  @override
  String get welcome => 'Welcome';

  @override
  String get welcomeDescription =>
      'Get ready to experience the best of the Flutter world!';

  @override
  String continueWith(Object value) {
    return 'Continue with $value';
  }

  @override
  String get continueAsGuests => 'Continue as guest';

  @override
  String get or => 'or';

  @override
  String get termsAndPrivacyPart1 => 'Almost there! Just accept our ';

  @override
  String get termsLabel => 'Terms';

  @override
  String get termsAndPrivacyAnd => ' and ';

  @override
  String get privacyPolicyLabel => 'Privacy Policy';

  @override
  String get termsAndPrivacyPart2 => ' to get started.';

  @override
  String get accept => 'Accept';

  @override
  String get flutterConfLatamLogoDescription =>
      'Logo of Flutter Conf Latam, third edition, in Quito, Ecuador.';

  @override
  String get errorCannotOpenLink => 'Cannot open this link';

  @override
  String get errorGeneric => 'An error occurred';

  @override
  String get termsAndConditionsErrorTitle => 'One last step';

  @override
  String get termsAndConditionsErrorDescription =>
      'Please accept our terms and policies.';

  @override
  String get authErrorGenericTitle => 'Oops, something went wrong';

  @override
  String get authErrorInternetTitle => 'Oops! You’re offline';

  @override
  String get authErrorGenericDescription => 'No worries, let’s try again.';

  @override
  String get authErrorInternetDescription =>
      'Check your connection and try again when you’re ready.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get retryButton => 'Retry';

  @override
  String get onboardingTitle => 'Personal information';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingUpdatePhoto => 'Update photo';

  @override
  String get onboardingPhotoPreview => 'Profile photo preview';

  @override
  String get onboardingNamesLabel => 'Names';

  @override
  String get onboardingLastNameLabel => 'Last Name';

  @override
  String get onboardingContinue => 'Continue';

  @override
  String get shareDialogTitle => 'Share and help grow the community!';

  @override
  String get shareBadgeSelectThemeHint => 'Select a theme for the card';

  @override
  String get shareBadgeThemeBlue => 'Blue theme';

  @override
  String get shareBadgeThemeYellow => 'Yellow theme';

  @override
  String get userAvatarLabel => 'User profile photo';

  @override
  String get badgeImPartOf => 'I’m part of';

  @override
  String get badgeConference => 'FlutterConf Latam';

  @override
  String get badgeYear => '2025';

  @override
  String get badgeLocation => 'Quito - Ecuador';

  @override
  String get hashtagBeFCL25 => '#BeFCL25';

  @override
  String get shareLater => 'Later';

  @override
  String get shareAction => 'Share';

  @override
  String get dashEcuadorLabel => 'Illustration of Dash in Ecuador';

  @override
  String get quitoLogoLabel => 'Quito logo';
}
