

  class UserPreferencesOptions {
  final List<String> tracks;
  final List<String> levels;
  final List<String> environments;
  final List<String> personas;

  UserPreferencesOptions({
  required this.tracks,
  required this.levels,
  this.environments = const ['On-Site', 'Remote'],
  this.personas = const ['The Coach', 'The Professional', 'The Challenger', 'The Busy Manager'],
  });
  }

