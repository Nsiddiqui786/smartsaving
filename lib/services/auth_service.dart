import '../models/user.dart';
import 'storage_service.dart';

class AuthService {
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<void> initialize() async {
    await storageService.initialize();
    _currentUser = storageService.getUser();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      // Validation
      if (email.isEmpty || password.isEmpty) {
        return {'success': false, 'message': 'Email and password are required'};
      }

      if (!email.contains('@')) {
        return {'success': false, 'message': 'Invalid email format'};
      }

      if (password.length < 6) {
        return {
          'success': false,
          'message': 'Password must be at least 6 characters',
        };
      }

      // Mock successful login
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: email.split('@')[0],
        createdAt: DateTime.now(),
      );

      final token = 'token_${DateTime.now().millisecondsSinceEpoch}';

      await storageService.saveUser(user, token);
      _currentUser = user;

      return {'success': true, 'user': user, 'token': token};
    } catch (e) {
      return {'success': false, 'message': 'Login failed: $e'};
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));

      // Validation
      if (email.isEmpty || password.isEmpty || name.isEmpty) {
        return {'success': false, 'message': 'All fields are required'};
      }

      if (!email.contains('@')) {
        return {'success': false, 'message': 'Invalid email format'};
      }

      if (password.length < 6) {
        return {
          'success': false,
          'message': 'Password must be at least 6 characters',
        };
      }

      if (name.length < 2) {
        return {
          'success': false,
          'message': 'Name must be at least 2 characters',
        };
      }

      // Mock successful registration
      final user = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        createdAt: DateTime.now(),
      );

      final token = 'token_${DateTime.now().millisecondsSinceEpoch}';

      await storageService.saveUser(user, token);
      _currentUser = user;

      return {'success': true, 'user': user, 'token': token};
    } catch (e) {
      return {'success': false, 'message': 'Registration failed: $e'};
    }
  }

  Future<void> logout() async {
    await storageService.clearUser();
    _currentUser = null;
  }

  Future<bool> checkAuthStatus() async {
    final user = storageService.getUser();
    final token = storageService.getToken();

    if (user != null && token != null) {
      _currentUser = user;
      return true;
    }
    return false;
  }
}

final authService = AuthService();
