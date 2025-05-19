import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/user_auth_errors.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';

abstract interface class UserDomainRepository {
  Future<Either<UnableToCreateNewUser, void>> createNewUser(
    String firstName,
    String lastName,
    String email,
    String password,
  );
  Future<Either<UnableToLoginUser, UserEntity>> loginUser(
    String email,
    String password,
  );
}
