class HomeDataSource {
  Future<Map<String, dynamic>> fetchHome() async {
    await Future.delayed(const Duration(seconds: 1));

    return {
      "userName": "Fares",
      "role": "Flutter Dev",
      "hasInterview": true,
      "questions": 50,
      "aiModels": 4,
      "duration": "20-30 Minutes",
      "languages": 2,
      "total": 9,
      "average": 82,
      "best": 95,
      "level": "Junior",
      "recentScore": 85,
      "recentDuration": "2 days ago • 25 minutes",
      "lastInterviewRole": "Flutter Developer",
      "lastInterviewScore": 88,
      "lastInterviewDate": "2025-12-20",
    };
  }
}
