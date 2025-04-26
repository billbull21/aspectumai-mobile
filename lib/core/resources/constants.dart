const APIKEY = String.fromEnvironment('GEMINI_API_KEY');
const GEMINI_ICON = 'assets/gemini-icon.png';

enum BlocStatus { initial, loading, loaded, error }

class ApiConstants {
  static const String baseUrl = 'https://bc41-182-253-116-53.ngrok-free.app/api/v1/';
  static const String jwtKey = 'jwt';
}
