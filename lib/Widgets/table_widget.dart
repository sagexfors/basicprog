import 'package:flutter/material.dart';

class JsonTableWidget extends StatelessWidget {
  final List<dynamic> tableData;

  const JsonTableWidget({super.key, required this.tableData});

  @override
  Widget build(BuildContext context) {
    if (tableData.isEmpty || tableData.first is! Map) {
      return const Center(child: Text("No data available"));
    }

    // Assuming all maps have the same keys
    List<String> columns =
        (tableData.first as Map).keys.cast<String>().toList();

    return DataTable(
      columns: _createColumns(columns),
      rows: _createRows(columns),
    );
  }

  List<DataColumn> _createColumns(List<String> columns) {
    return columns
        .map((String column) => DataColumn(label: Text(column)))
        .toList();
  }

  List<DataRow> _createRows(List<String> columns) {
    return tableData.map((dynamic item) {
      Map<String, dynamic> rowMap = item as Map<String, dynamic>;
      return DataRow(
        cells: columns
            .map((String column) => DataCell(Text(rowMap[column].toString())))
            .toList(),
      );
    }).toList();
  }
}
