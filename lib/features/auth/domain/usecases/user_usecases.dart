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
    final user = await userDomainRepository.createNewUser(
      firstName,
      lastName,
      email,
      password,
    );

    return user.fold(
      (failure) => Left(UnableToCreateNewUser(message: failure.message)),
      (_) => Right(null),
    );
  }

  Future<Either<UnableToLoginUser, UserEntity>> loginUser(
    String email,
    String password,
  ) async {
    final result = await userDomainRepository.loginUser(email, password);

    return result.fold(
      (failure) => Left(UnableToLoginUser(message: failure.message)),
      (user) => Right(user),
    );
  }

  Future<Either<UnableToSignOutUser, void>> userSignOut() async {
    final result = await userDomainRepository.userSignOut();

    return result.fold(
      (failure) => Left(UnableToSignOutUser(message: failure.message)),
      (_) => Right(null),
    );
  }

  Future<Either<UpdateUserDetails, UserEntity>> updateUserDetails(
    String firstName,
    String lastName,
    String profilePictureUrl,
  ) async {
    final result = await userDomainRepository.updateUserDetails(
      firstName,
      lastName,
      profilePictureUrl,
    );
    return result.fold(
      (failure) => Left(UpdateUserDetails(message: failure.message)),
      (entity) => Right(entity),
    );
  }
}
