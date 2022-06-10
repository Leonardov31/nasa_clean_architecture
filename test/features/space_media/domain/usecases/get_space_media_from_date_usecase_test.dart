import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/space_media/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/space_media/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_architecture/features/space_media/domain/usecases/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  const tSpaceMedia = SpaceMediaEntity(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );
  final tDate = DateTime(2021, 2, 2);

  test('Should get space media entity for a given date from the repository',
      () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
      (_) async => const Right(tSpaceMedia),
    );

    final result = await usecase(tDate);

    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('Should return a failure when don´t succeed', () async {
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase(tDate);

    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
