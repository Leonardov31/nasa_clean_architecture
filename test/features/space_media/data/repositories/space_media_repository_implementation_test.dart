import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/features/space_media/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/space_media/data/models/space_media_model.dart';
import 'package:nasa_clean_architecture/features/space_media/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
    description: 'description',
    mediaType: 'mediaType',
    title: 'title',
    mediaUrl: 'mediaUrl',
  );

  final tDate = DateTime(2022, 2, 2);

  test('Should return space media model when calls the datasource', () async {
    //Arrange
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((invocation) async => tSpaceMediaModel);

    //Act
    final result = await repository.getSpaceMediaFromDate(tDate);

    //Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('Should return a server failure when call the datasource is unsucessull',
      () async {
    when(() => datasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDate);

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
