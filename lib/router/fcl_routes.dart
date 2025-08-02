enum FCLRoutes {
  splash(name: 'Splash', path: '/splash'),
  auth(name: 'Auth', path: '/auth'),
  loading(name: 'Loading', path: '/:route/loading'),
  onboarding(name: 'Onboarding', path: '/onboarding'),
  home(name: 'Home', path: '/home');

  const FCLRoutes({required this.name, required this.path});
  final String name;
  final String path;
}
