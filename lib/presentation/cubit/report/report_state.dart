part of 'report_cubit.dart';

abstract class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {
}

class LoadReportSuccess extends ReportState {

}

class LoadingReport extends ReportState {

}

class LoadReportFailed extends ReportState {
  final String? messages;

  LoadReportFailed({this.messages});
}

class LoadTopProductReportFailed extends ReportState {
  final String? messages;

  LoadTopProductReportFailed({this.messages});
}