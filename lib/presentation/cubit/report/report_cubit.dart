import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/linear_sales.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/resources/state.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/core/usecases/order_usecase.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

part './report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({required this.orderUC}) : super(ReportInitial());

  final OrderUC orderUC;

  List<charts.Series<LinearSales, DateTime>> summaryReport = [];
  List<TopSelling> topProduct = [];
  Summary dataSummary = Summary();

  void load(List<DateTime> dates) async {
    emit(LoadingReport());
    DataState<ChartSummary> listSales = await orderUC.summary(dates);
    if (!GlobalHelper.isEmpty(listSales.error)) {
      emit(LoadReportFailed(messages: listSales.error));
    } else {
      summaryReport = [charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.days!,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: listSales.success!.data!,
      )];

      if (listSales.success!.data!.length != 0) {
        dataSummary = listSales.success!.summary!;
      }
    }

    DataState<List<TopSelling>> listTopSellingItem = await orderUC.topSelling(dates);
    if (!GlobalHelper.isEmpty(listSales.error)) {
      emit(LoadTopProductReportFailed(messages: listTopSellingItem.error));
    } else {
      topProduct = listTopSellingItem.success!;
      emit(LoadReportSuccess());
    }
  }
}
