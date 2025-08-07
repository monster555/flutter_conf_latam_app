enum FCLRoutes {
  splash(name: 'Splash', path: '/splash'),
  auth(name: 'Auth', path: '/auth'),
  authError(name: 'Auth Error', path: 'error'),
  loading(name: 'Loading', path: '/:route/loading'),
  onboarding(name: 'Onboarding', path: '/onboarding'),
  onboardingError(name: 'Onboarding Error', path: 'error'),
  fclCard(name: 'FCL Card', path: 'fcl-card'),
  sharingFclCard(name: 'Sharing FCL Card', path: 'sharing'),
  home(name: 'Home', path: '/home');

  const FCLRoutes({required this.name, required this.path});
  final String name;
  final String path;
}
