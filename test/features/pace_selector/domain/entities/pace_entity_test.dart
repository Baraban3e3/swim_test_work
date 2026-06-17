import 'package:flutter_test/flutter_test.dart';
import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';

void main() {
  group('PaceEntity', () {
    test('should calculate totalSeconds correctly', () {
      const pace = PaceEntity(minutes: 2, seconds: 15);
      expect(pace.totalSeconds, 135);
    });

    group('swimmerLevel', () {
      test('should return Elite when total <= 70', () {
        const pace1 = PaceEntity(minutes: 1, seconds: 10);
        const pace2 = PaceEntity(minutes: 0, seconds: 50);
        expect(pace1.swimmerLevel, 'Elite');
        expect(pace2.swimmerLevel, 'Elite');
      });

      test('should return Advanced when total > 70 and <= 90', () {
        const pace1 = PaceEntity(minutes: 1, seconds: 11);
        const pace2 = PaceEntity(minutes: 1, seconds: 30);
        expect(pace1.swimmerLevel, 'Advanced');
        expect(pace2.swimmerLevel, 'Advanced');
      });

      test('should return Intermediate when total > 90 and <= 150', () {
        const pace1 = PaceEntity(minutes: 1, seconds: 31);
        const pace2 = PaceEntity(minutes: 2, seconds: 30);
        expect(pace1.swimmerLevel, 'Intermediate');
        expect(pace2.swimmerLevel, 'Intermediate');
      });

      test('should return Beginner when total > 150', () {
        const pace1 = PaceEntity(minutes: 2, seconds: 31);
        const pace2 = PaceEntity(minutes: 4, seconds: 00);
        expect(pace1.swimmerLevel, 'Beginner');
        expect(pace2.swimmerLevel, 'Beginner');
      });
    });
  });
}
