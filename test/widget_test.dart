import 'package:flutter_test/flutter_test.dart';
import 'package:task_assigment/data/repositories/mock_magnet_repository.dart';

void main() {
  group('MockMagnetRepository Tests', () {
    const repository = MockMagnetRepository();

    test('getProfile returns expected fallback values', () {
      final profile = repository.getProfile();
      expect(profile.name, isNotEmpty);
      expect(profile.email, isNotEmpty);
    });

    test('getProfile accepts user values', () {
      final profile = repository.getProfile(
        name: 'Test User',
        email: 'test@example.com',
      );
      expect(profile.name, 'Test User');
      expect(profile.email, 'test@example.com');
    });

    test('getVisitorAnalytics returns non-empty stats', () {
      final analytics = repository.getVisitorAnalytics();
      expect(analytics.totalViews, isNotEmpty);
    });

    test('getWebTemplates returns template items', () {
      final templates = repository.getWebTemplates();
      expect(templates, isNotEmpty);
    });
  });
}
