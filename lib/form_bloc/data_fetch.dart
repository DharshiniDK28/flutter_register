import 'package:equatable/equatable.dart';

abstract class DataFetch extends Equatable{
  const DataFetch();
  @override
  List<Object?> get props => [];
}


class DataFetched extends DataFetch{
  const DataFetched();
  @override
  List<Object?> get props => [];
}

class DataFetchedLoading extends DataFetch{
  const DataFetchedLoading();
  @override
  List<Object?> get props => [];
}

class DataFetchedSuccess extends DataFetch{
  const DataFetchedSuccess();
  @override
  List<Object?> get props => [];
}

class DataFetchedFailed extends DataFetch{
  const DataFetchedFailed();
  @override
  List<Object?> get props => [];
}