const APIKEY = String.fromEnvironment('GEMINI_API_KEY');
const GEMINI_ICON = 'assets/gemini-icon.png';

enum BlocStatus { initial, loading, loaded, error }

class ApiConstants {
  static const String baseUrl = 'https://7d0c-120-188-81-25.ngrok-free.app/api/v1/';
  static const String jwtKey = 'jwt';
}
