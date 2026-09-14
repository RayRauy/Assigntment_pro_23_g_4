/// Every URL the app talks to, in one place.
///
/// Mirrors the Spring Boot project `project-spring-boot-user-image-sse`,
/// deployed at [baseUrl].
class ApiConstant {
  const ApiConstant._();

  /// The backend. A public host, so the same value works on every target —
  /// Android emulator, iOS simulator and a real device alike, with no
  /// per-platform `localhost` rules to get wrong.
  static const String baseUrl = 'https://flutter-api.janrent.com';

  // --- Auth (public) ---
  static const String login = '$baseUrl/api/auth/login';
  static const String register = '$baseUrl/api/auth/register';

  // --- Users (Bearer token required) ---
  static const String users = '$baseUrl/api/users';
  static const String currentUser = '$baseUrl/api/users/me';

  static String userById(int id) => '$baseUrl/api/users/$id';

  static String userEnabled(int id) => '$baseUrl/api/users/$id/enabled';

  static String userImage(int id) => '$baseUrl/api/users/$id/image';

  // --- Posts (Bearer token required) ---
  static const String posts = '$baseUrl/api/posts';

  static String postById(int id) => '$baseUrl/api/posts/$id';

  static String postImage(int id) => '$baseUrl/api/posts/$id/image';

  // --- Sliders ---
  /// Public: the active carousel, in display order.
  static const String sliders = '$baseUrl/api/sliders';

  /// Protected: every banner including hidden ones.
  static const String slidersManage = '$baseUrl/api/sliders/manage';

  // --- Files (public GET) ---
  /// Absolute URL for an `Image.network`, from whatever `imageUrl` the backend
  /// sent.
  ///
  /// Accepts both shapes on purpose. The backend returns a path such as
  /// `/api/files/3-a1b2.png`, which has to be joined with [baseUrl]; but if it
  /// is ever changed to return a full URL, joining again would produce
  /// `https://hosthttps://host/api/files/…` and every image would break. Passing
  /// an already-absolute URL straight through makes this safe either way.
  static String fileUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }
    return '$baseUrl$imagePath';
  }

  // --- SSE ---
  /// `EventSource` cannot send headers, so the backend also accepts the token
  /// as a query parameter on this route.
  static String sseSubscribe(String token) =>
      '$baseUrl/api/sse/subscribe?access_token=$token';
}
