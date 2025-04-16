import 'package:app2/data/models/register_model.dart';
import 'package:app2/data/services/register_services.dart';

class RegisterRepository {
  final RegisterService registerService;
  RegisterRepository({required this.registerService});
  Future<bool> register(RegisterRequestModel model) async {
    return await registerService.registerUser(model);
  }
}
