abstract interface class UserAuthErrors {
  String getError();
}

class UnableToCreateNewUser extends UserAuthErrors {
  final String message;
  UnableToCreateNewUser({required this.message});
  @override
  String getError() {
    return message;
  }
}

class UnableToLoginUser extends UserAuthErrors {
  final String message;
  UnableToLoginUser({required this.message});
  @override
  String getError() {
    return message;
  }
}

class UnableToSignOutUser extends UserAuthErrors {
  final String message;

  UnableToSignOutUser({required this.message});

  @override
  String getError() {
    return message;
  }
}

class UpdateUserDetails extends UserAuthErrors {
  final String message;

  UpdateUserDetails({required this.message});

  @override
  String getError() {
    return message;
  }
}
