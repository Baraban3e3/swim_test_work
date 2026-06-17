import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:swim_test/features/pace_selector/domain/usecases/submit_pace_usecase.dart';
import 'package:swim_test/features/pace_selector/presentation/cubit/pace_cubit.dart';
import 'package:swim_test/features/pace_selector/presentation/cubit/pace_state.dart';
import 'package:swim_test/core/error/exceptions.dart';
import 'package:swim_test/features/pace_selector/domain/entities/pace_entity.dart';

class MockSubmitPaceUseCase extends Mock implements SubmitPaceUseCase {}
class FakePaceEntity extends Fake implements PaceEntity {}

void main() {
  late PaceCubit cubit;
  late MockSubmitPaceUseCase mockSubmitPaceUseCase;

  setUpAll(() {
    registerFallbackValue(FakePaceEntity());
  });

  setUp(() {
    mockSubmitPaceUseCase = MockSubmitPaceUseCase();
    cubit = PaceCubit(mockSubmitPaceUseCase);
  });

  group('PaceCubit', () {
    test('initial state should be PaceState with 1 minute 30 seconds', () {
      expect(cubit.state.minutes, 1);
      expect(cubit.state.seconds, 30);
    });

    group('updateMinutes', () {
      blocTest<PaceCubit, PaceState>(
        'should update minutes correctly',
        build: () => cubit,
        act: (cubit) => cubit.updateMinutes(3),
        expect: () => [
          const PaceState(minutes: 3, seconds: 30),
        ],
      );

      blocTest<PaceCubit, PaceState>(
        'should ignore if minutes < 0 or > 4',
        build: () => cubit,
        act: (cubit) {
          cubit.updateMinutes(-1);
          cubit.updateMinutes(5);
        },
        expect: () => [],
      );

      blocTest<PaceCubit, PaceState>(
        'should set seconds to 0 if minutes is 4',
        build: () => cubit,
        act: (cubit) => cubit.updateMinutes(4),
        expect: () => [
          const PaceState(minutes: 4, seconds: 0),
        ],
      );
    });

    group('updateSeconds', () {
      blocTest<PaceCubit, PaceState>(
        'should update seconds correctly',
        build: () => cubit,
        act: (cubit) => cubit.updateSeconds(45),
        expect: () => [
          const PaceState(minutes: 1, seconds: 45),
        ],
      );

      blocTest<PaceCubit, PaceState>(
        'should ignore if seconds < 0 or > 59',
        build: () => cubit,
        act: (cubit) {
          cubit.updateSeconds(-1);
          cubit.updateSeconds(60);
        },
        expect: () => [],
      );

      blocTest<PaceCubit, PaceState>(
        'should set seconds to 0 if minutes is 4 and user tries to update seconds',
        build: () {
          cubit.updateMinutes(4);
          return cubit;
        },
        act: (cubit) => cubit.updateSeconds(10),
        expect: () => [],
      );
    });

    group('updateFromTotalSeconds', () {
      blocTest<PaceCubit, PaceState>(
        'should convert total seconds to minutes and seconds',
        build: () => cubit,
        act: (cubit) => cubit.updateFromTotalSeconds(130),
        expect: () => [
          const PaceState(minutes: 2, seconds: 10),
        ],
      );
    });

    group('submitPace', () {
      blocTest<PaceCubit, PaceState>(
        'should emit [Loading, Success] when successful',
        build: () {
          when(() => mockSubmitPaceUseCase(any()))
              .thenAnswer((_) async => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.submitPace(),
        expect: () => [
          const PaceState(minutes: 1, seconds: 30, isLoading: true),
          const PaceState(minutes: 1, seconds: 30, isLoading: false, isSuccess: true),
        ],
      );

      blocTest<PaceCubit, PaceState>(
        'should emit [Loading, Error] when failed',
        build: () {
          when(() => mockSubmitPaceUseCase(any()))
              .thenThrow(ServerException('Error message'));
          return cubit;
        },
        act: (cubit) => cubit.submitPace(),
        expect: () => [
          const PaceState(minutes: 1, seconds: 30, isLoading: true),
          const PaceState(minutes: 1, seconds: 30, isLoading: false, errorMessage: "Instance of 'ServerException'"),
        ],
      );
    });
  });
}
