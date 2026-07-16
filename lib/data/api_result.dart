
//sealed tells dart compiler evey possible subclass of APIResult
sealed class ApiResult<T> {
  const ApiResult();
}

//holds successfull data that came back
class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

//message and statysCode(optional)
class NetworkFailure<T> extends ApiResult<T> {
  final String message;
  const NetworkFailure(this.message);
}

class ServerFailure<T> extends ApiResult<T> {
  final String message;
  final int statusCode;
  const ServerFailure(this.message, this.statusCode);
}

class UnknownFailure<T> extends ApiResult<T> {
  final String message;
  const UnknownFailure(this.message);
}


// How it works: repository calls the API if it works success gets returned
//if it does not work Failure with a message gets returned notifier will receive
// the APi Result and uses a switch to check fail of success
