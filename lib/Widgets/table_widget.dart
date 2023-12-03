import 'package:flutter/material.dart';

class JsonTableWidget extends StatefulWidget {
  final List<dynamic> tableData;

  const JsonTableWidget({super.key, required this.tableData});

  @override
  State<JsonTableWidget> createState() => _JsonTableWidgetState();
}

class _JsonTableWidgetState extends State<JsonTableWidget> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    if (widget.tableData.isEmpty || widget.tableData.first is! Map) {
      return const Center(child: Text("No data available"));
    }

    List<String> columns =
        (widget.tableData.first as Map).keys.cast<String>().toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _isAscending,
        columns: _createColumns(columns),
        rows: _createRows(columns),
      ),
    );
  }

  List<DataColumn> _createColumns(List<String> columns) {
    return List.generate(columns.length, (index) {
      return DataColumn(
        label: Text(columns[index]),
        onSort: (columnIndex, ascending) {
          setState(() {
            _sortColumnIndex = columnIndex;
            _isAscending = ascending;

            if (ascending) {
              widget.tableData.sort(
                (a, b) => a[columns[columnIndex]]
                    .toString()
                    .compareTo(b[columns[columnIndex]].toString()),
              );
            } else {
              widget.tableData.sort(
                (a, b) => b[columns[columnIndex]]
                    .toString()
                    .compareTo(a[columns[columnIndex]].toString()),
              );
            }
          });
        },
      );
    });
  }

  List<DataRow> _createRows(List<String> columns) {
    return widget.tableData.map((dynamic item) {
      Map<String, dynamic> rowMap = item as Map<String, dynamic>;
      return DataRow(
        cells: columns
            .map(
              (String column) =>
                  DataCell(Text(rowMap[column]?.toString() ?? '')),
            )
            .toList(),
      );
    }).toList();
  }
}
