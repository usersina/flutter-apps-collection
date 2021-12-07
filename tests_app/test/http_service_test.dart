import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tests_app/album.dart';
import 'package:tests_app/http_service.dart';

import 'http_service_test.mocks.dart';

@GenerateMocks([Client])
void main(List<String> args) {
  group("fetchAlbum", () {
    final HttpService httpService = HttpService();
    final Client httpClient = Client();
    test("returns an Album if the http call is completed successfully",
        () async {
      final client = MockClient();
      when(
        client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
        ),
      ).thenAnswer((_) async =>
          Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
      expect(
        await httpService.fetchAlbum(httpClient),
        isA<Album>(),
      );
    });

    test(
      "throws an exception if the http call completes with an error",
      () {
        final client = MockClient();

        when(
          client.get(
            Uri.parse("uri"),
          ),
        ).thenAnswer(
          (_) async => Response("Not Found", 404),
        );

        expect(httpService.fetchAlbum(httpClient), throwsException);
      },
    );
  });
}
