import 'package:vania/vania.dart';
import 'package:vania_sample/app/models/users.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required',
      'password': 'required|min_length:8|confirmed',
    }, {
      'name.required': 'nama tidak boleh kosong',
      'email.required': 'email tidak boleh kosong',
      'password.required': 'password tidak boleh kosong',
      'password.min_length': 'password harus berisi minimal 8 karakter',
      'password.confirmed': 'password tidak sesuai',
    });

    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password');

    var user = await Users().query().where('email', '=', email).first();
    if (user != null) {
      return Response.json({
        'messsage': 'user sudah ada',
      }, 409);
    }

    password = Hash().make(password);
    await Users().query().insert({
      'name': name,
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
    });
    return Response.json({
      'message': 'user berhasil terdaftar',
    }, 201);
  }

  Future<Response> login(Request request) async {
    request.validate({
      'email': "required|email",
      'password': 'required|min_length:8',
    }, {
      'email.required': 'email harus diisi',
      'email.email': 'format email tidak valid',
      'password.required': 'password harus diisi',
      'password.min_length': 'password harus diisi minimal 8 karakter',
    });

    final email = request.input('email');
    final password = request.input('password');

    var user = await Users().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({
        'message': 'user belum terdaftar',
      }, 409);
    }
    if (!Hash().verify(password, user['password'])) {
      return Response.json({
        'message': 'password salah',
      }, 401);
    }
    final token = await Auth()
        .login(user)
        .createToken(expiresIn: Duration(days: 5), withRefreshToken: true);

    return Response.json({
      'message': 'login berhasil',
      'token': token,
    });
  }
}

final AuthController authController = AuthController();
