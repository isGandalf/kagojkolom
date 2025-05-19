import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/user_auth_errors.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';
import 'package:kagojkolom/features/auth/domain/repository/user_domain_repository.dart';

class UserUsecases {
  final UserDomainRepository userDomainRepository;

  UserUsecases({required this.userDomainRepository});

  Future<Either<UnableToCreateNewUser, void>> createNewUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    return await userDomainRepository.createNewUser(
      firstName,
      lastName,
      email,
      password,
    );
  }

  Future<Either<UnableToLoginUser, UserEntity>> loginUser(
    String email,
    String password,
  ) async {
    return await userDomainRepository.loginUser(email, password);
  }
}
