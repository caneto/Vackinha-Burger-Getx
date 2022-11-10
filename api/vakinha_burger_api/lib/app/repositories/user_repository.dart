
import 'dart:developer';

import 'package:mysql1/mysql1.dart';
import 'package:vakinha_burger_api/app/core/database/database.dart';
import 'package:vakinha_burger_api/app/core/exceptions/email_already_registered.dart';
import 'package:vakinha_burger_api/app/core/helpers/cripty_helper.dart';
import 'package:vakinha_burger_api/app/entities/user.dart';

class UserRepository {
  Future<void> save(User user) async {
     MySqlConnection? conn;
      try {
        conn = await Database().openConnection();

        final isUserRegiser = await conn.query('select * from usuario where email = ?', [user.email]);

        if(isUserRegiser.isEmpty) {
           await conn.query(''' 
              insert into usuario
              values(?, ?, ?, ?)
           ''', [
            null,
            user.name,
            user.email,
            CriptyHelper.generateSha256Hash(user.password)
           ]); 
        } else {
          throw EmailAlreadyRegistered();
        }
       
    } on MySqlException catch (e, s) {
      log('Erro no MySQL', error: e, stackTrace: s);
      throw Exception();
    } finally {
      await conn?.close();
    }
  }
}