// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_architecture/core/errors/failures.dart';
import 'package:nasa_clean_architecture/core/usecase/usecase.dart';
import 'package:nasa_clean_architecture/features/space_media/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_architecture/features/space_media/domain/repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromData(date);
  }
}
