enum Status { isLOADING, isCOMPLETED, isERROR }

class ApiResponse<T> {
  Status? status;
  String? message;
  T? data;

  ApiResponse({this.status, this.message, this.data});

  ApiResponse.loading() : status = Status.isLOADING;
  ApiResponse.completed(this.data) : status = Status.isCOMPLETED;
  ApiResponse.error(this.message) : status = Status.isERROR;

  @override
  String toString() {
    return 'Status: $status\nMessage: $message,\n Data: $data';
  }
}