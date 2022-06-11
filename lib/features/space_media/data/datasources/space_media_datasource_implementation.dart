import 'dart:convert';

import 'package:nasa_clean_architecture/core/errors/exceptions.dart';
import 'package:nasa_clean_architecture/core/http_client/http_client.dart';
import 'package:nasa_clean_architecture/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_architecture/core/utils/keys/nasa_api_key.dart';
import 'package:nasa_clean_architecture/features/space_media/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_architecture/features/space_media/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_architecture/features/space_media/data/models/space_media_model.dart';

class NasaMediaDatasourceImplementation implements ISpaceMediaDatasource {
  final HttpClient httpClient;

  NasaMediaDatasourceImplementation(this.httpClient);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await httpClient.get(NasaEndpoints.apod(
      NasaApiKeys.apiKey,
      DateToStringConverter.converter(date),
    ));

    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
