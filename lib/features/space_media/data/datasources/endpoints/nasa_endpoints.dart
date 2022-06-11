class NasaEndpoints {
  static String apod(String key, String date) =>
      'https://api.nasa.gov/planetary/apod?api_key=$key&date=$date';
}
