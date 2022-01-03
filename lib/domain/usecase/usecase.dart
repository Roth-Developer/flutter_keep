abstract class UseCase<Type, Params> {
  Type call(Params params);
}

abstract class UseCaseFuture<Type, Params> {
  Future<Type> call(Params params);
}

// abstract class UseCaseNoError<Type, Params> {
//   Type call(Params params);
// }

// abstract class UseCaseNoErrorFuture<Type, Params> {
//   Future<Type> call(Params params);
// }
