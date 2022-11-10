import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:vakinha_burger_api/app/core/exceptions/email_already_registered.dart';
import 'package:vakinha_burger_api/app/entities/user.dart';
import 'package:vakinha_burger_api/app/repositories/user_repository.dart';

part 'auth_controller.g.dart';

class AuthController {
  final _userRepository = UserRepository();

  @Route.post('/register')
  Future<Response> register(Request request) async {
    try {
      final userRq = User.fromJson(await request.readAsString());
      await _userRepository.save(userRq);

      return Response(200,
        headers: {
          'content-type': 'application/json',
        }
      );
    } on EmailAlreadyRegistered catch (e, s) {
      log('Erro email já cadastrado', error: e, stackTrace: s);
      return Response(
        400,
        body: {
          jsonEncode(
            {'error': 'E-mail já utilizado por outro usuario'},
          ),
        },
        headers: {
          'content-type': 'application/json',
        }
      );
    } catch(e, s) {
      log('Erro desconhecido', error: e, stackTrace: s);
      return Response.internalServerError();
    }
  }

  Router get router => _$AuthControllerRouter(this);
}
