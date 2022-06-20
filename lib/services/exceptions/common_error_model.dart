class CommonError {
  late bool? success;
  late String? error;

  CommonError({
    this.success,
    this.error,
  });

  CommonError.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'] ?? json['detail'];
  }
}
