// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ProfileApiService extends ProfileApiService {
  _$ProfileApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ProfileApiService;

  Future<Response> getProfile(int id) {
    final $url = '/student-profile.php';
    final Map<String, dynamic> $params = {'id': id};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> editProfile(Map<String, dynamic> body) {
    final $url = '/edit-profile.php';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
