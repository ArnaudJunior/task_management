class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String userEndpoint = '/user';
  static const String createTask = '/tasks';
  static const String updateTask = '/tasks/{task}';
  static const String getTasks = '/tasks';
  static const String getUsers = '/all/users';

  // Headers
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Map<String, String> authHeaders(String token) => {
        ...headers,
        'Authorization': 'Bearer $token',
      };
}
