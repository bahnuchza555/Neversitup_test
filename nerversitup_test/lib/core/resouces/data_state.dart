import 'package:dio/dio.dart';

abstract class DataState<T> {
  const DataState({this.data, this.error});

  final T? data;
  final DioException? error; 
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFail<T> extends DataState<T> {
  const DataFail(DioException error) : super(error: error);
}