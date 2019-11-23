import 'package:chopper/chopper.dart';

part 'profile_api_service.chopper.dart';

@ChopperApi()
abstract class ProfileApiService extends ChopperService {
  @Get(path: '/student-profile.php')
  Future<Response> getProfile(@Query('id') int id);

  @Post(path: '/edit-profile.php')
  Future<Response> editProfile(
    @Body() Map<String, dynamic> body,
  );

  static ProfileApiService create() {
    final client = ChopperClient(
      baseUrl: 'http://10.0.3.2:8000',
      services: [
        _$ProfileApiService(),
      ],
      interceptors: [HttpLoggingInterceptor()],
      converter: JsonConverter(),
    );
    return _$ProfileApiService(client);
  }
}
