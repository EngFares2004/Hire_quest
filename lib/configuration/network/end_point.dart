class AppEndPoint {
  static const String baseUrl = 'https://hirequest.runasp.net';

  /// -------- AUTH --------
  static const String login = '$baseUrl/api/Auth/login';
  static const String register = '$baseUrl/api/Auth/register';

  static const String verifyOtp = '$baseUrl/api/Auth/verify-Email';
  static const String resendOtp = '$baseUrl/api/Auth/resend-otp';

  static const String generateVrCode = "$baseUrl/api/Device/generate-code";
  static const String vrLogin = "$baseUrl/api/Device/vr-login";
  static const String devices = "$baseUrl/api/Device";
  static const String disconnectDevice = "$baseUrl/api/Device";

  static const String resetPassword = '$baseUrl/api/Auth/reset-password';
  static const String changePassword = '$baseUrl/api/Auth/change-password';
  static const String refreshToken = '$baseUrl/api/Auth/refresh-token';
  static const String revokeToken = '$baseUrl/api/Auth/revoke-token';

  /// -------- USER PROFILE --------
  static const String myProfile = '$baseUrl/api/UserProfile/me';
  static const String userProfileById = '$baseUrl/api/UserProfile';
  static const String uploadAvatar = '$baseUrl/api/UserProfile/me/avatar';
  static const String deleteAvatar = '$baseUrl/api/UserProfile/me/avatar';
  static const String myStatistics = '$baseUrl/api/UserProfile/me/statistics';

  /// -------- USER PREFERENCES --------
  static const String userPreferences = '$baseUrl/api/UserPreferences';
  static const String userPreferencesOptions =
      '$baseUrl/api/UserPreferencesOptions';

  /// -------- INTERVIEW --------


  static const String analyzeIntro =
      '$baseUrl/api/Interview/analyze-intro';

  static const String generateQuestion =
      '$baseUrl/api/Interview/generate-question';


  static const String evaluateAnswer =
      '$baseUrl/api/Interview/evaluate-answer';


  static const String generateSummary =
      '$baseUrl/api/Interview/generate-summary';

  static const String myInterviews =
      '$baseUrl/api/Interview/my-interviews';


  static const String interviewById =
      '$baseUrl/api/Interview/';

  /// -------- LEADERBOARD --------
  static const String leaderboard =
      '$baseUrl/api/leaderboard';

  static const String leaderboardJobTitles =
      '$baseUrl/api/leaderboard/job-titles';

}