import 'package:dartz/dartz.dart';
import 'package:kagojkolom/core/error/user_auth_errors.dart';
import 'package:kagojkolom/features/auth/data/source/user_auth.dart';
import 'package:kagojkolom/features/auth/domain/entity/user_entity.dart';
import 'package:kagojkolom/features/auth/domain/repository/user_domain_repository.dart';

class UserDataRepository implements UserDomainRepository {
  final UserAuth userAuth;

  UserDataRepository({required this.userAuth});

  @override
  Future<Either<UnableToCreateNewUser, void>> createNewUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    return await userAuth.createNewUser(firstName, lastName, email, password);
  }

  @override
  Future<Either<UnableToLoginUser, UserEntity>> loginUser(
    String email,
    String password,
  ) async {
    final userModel = await userAuth.loginUser(email, password);

    return userModel.fold(
      (failure) => Left(UnableToLoginUser(message: failure.message)),
      (entity) => Right(entity.toEntity()),
    );
  }
}
