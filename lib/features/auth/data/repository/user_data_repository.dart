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
    final user = await userAuth.createNewUser(
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

  @override
  Future<Either<UnableToSignOutUser, void>> userSignOut() async {
    final result = await userAuth.userSignOut();
    return result.fold(
      (failure) => Left(UnableToSignOutUser(message: failure.message)),
      (_) => Right(null),
    );
  }

  @override
  Future<Either<UpdateUserDetails, UserEntity>> updateUserDetails(
    String firstName,
    String lastName,
    String profilePictureUrl,
  ) async {
    final userModel = await userAuth.updateUserDetails(
      firstName,
      lastName,
      profilePictureUrl,
    );

    return userModel.fold(
      (failure) => Left(UpdateUserDetails(message: failure.message)),
      (model) => Right(model.toEntity()),
    );
  }
}
