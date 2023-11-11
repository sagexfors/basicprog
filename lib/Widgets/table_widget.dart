import 'package:flutter/material.dart';

class JsonTableWidget extends StatelessWidget {
  final List<dynamic> data;

  const JsonTableWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> _buildRows() {
      return data.sublist(1).map<DataRow>((row) {
        return DataRow(
          cells: row
              .map<DataCell>((cell) => DataCell(Text(cell.toString())))
              .toList(),
        );
      }).toList();
    }

    return DataTable(
      columns: data[0]
          .map<DataColumn>(
            (header) => DataColumn(label: Text(header.toString())),
          )
          .toList(),
      rows: _buildRows(),
    );
  }
}
