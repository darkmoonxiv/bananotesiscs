import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';

import 'package:universal_html/html.dart' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:admin_dashboard/models/costos.dart';
import 'package:admin_dashboard/models/inventario.dart';

import 'package:admin_dashboard/datatables/inventario_datasource.dart';

class InvetoryTableReport extends StatefulWidget {
  final String nombreReporte;

  const InvetoryTableReport({Key? key, required this.nombreReporte})
      : super(key: key);

  @override
  State<InvetoryTableReport> createState() => _InvetoryTableReportState();
}

class _InvetoryTableReportState extends State<InvetoryTableReport> {
  int c = 0;
  final TextEditingController inventoryDateController = TextEditingController();
  DateTime? selectedStartDate;
  final TextEditingController inventoryDateEndController =
      TextEditingController();
  late UsersProvider usersProvider;

  @override
  void initState() {
    super.initState();
    usersProvider = Provider.of<UsersProvider>(context, listen: false);
  }

  void filtrarPorRangoFechas(String initialDateText, String finalDateText) {
    try {
      DateTime fechaInicioSeleccionada =
          DateFormat('MM/d/yyyy').parse(initialDateText);
      DateTime fechaFinSeleccionada =
          DateFormat('MM/d/yyyy').parse(finalDateText);

      print('fechas ${fechaInicioSeleccionada} y ${fechaFinSeleccionada}');

      List<Inventario> datosFiltrados =
          usersProvider.inventario.where((element) {
        print(element.purchaseDate);
        return (element.purchaseDate
                    .isAtSameMomentAs(fechaInicioSeleccionada) ||
                element.purchaseDate.isAfter(fechaInicioSeleccionada)) &&
            (element.purchaseDate.isAtSameMomentAs(fechaFinSeleccionada) ||
                element.purchaseDate.isBefore(fechaFinSeleccionada));
      }).toList();

      setState(() {
        usersProvider.inventario = datosFiltrados;
      });
    } catch (e) {
      print('Error al parsear la fecha: $e');
    }
  }

  pw.Widget _buildTableCell(String text, {bool header = false}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    color: header ? PdfColor.fromHex('#4CAF50') : PdfColor.fromHex('#FFFFFF'),
    alignment: pw.Alignment.center,
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: header ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
      textAlign: pw.TextAlign.center,
    ),
  );
}

  void generateAndDownloadPdfInventario(
      List<Inventario> inventario, List<Costos> costos) async {
    final pdf = pw.Document();

    final ByteData imageLeftData =
        await rootBundle.load('assets/logo_pdfFruty.jpeg');
    final ByteData imageCenterData =
        await rootBundle.load('assets/seguimientoS.jpeg');
    final ByteData imageRightData =
        await rootBundle.load('assets/logo_pdfImagen.jpeg');

    final Uint8List imageLeftBytes = imageLeftData.buffer.asUint8List();
    final Uint8List imageCenterBytes = imageCenterData.buffer.asUint8List();
    final Uint8List imageRightBytes = imageRightData.buffer.asUint8List();

    final pdfImageLeft = pw.MemoryImage(imageLeftBytes);
    final pdfImageCenter = pw.MemoryImage(imageCenterBytes);
    final pdfImageRight = pw.MemoryImage(imageRightBytes);

    final permisosTable = pw.Table(
      border: pw.TableBorder.all(),
      defaultColumnWidth: pw.FlexColumnWidth(),
      children: [
        pw.TableRow(
          children: [
            for (var header in ['ID', 'Descripcion', 'Producto', 'Cantidad', 'Precio', 'Fecha'])
              _buildTableCell(header, header: true),
          ],
        ),
        ...inventario.map((inventario) {
          return pw.TableRow(
            children: [
              _buildTableCell(inventario.id.toString()),
              _buildTableCell(inventario.description),
              _buildTableCell(inventario.product),
              _buildTableCell(inventario.unitPrice.toString()),
              _buildTableCell(inventario.quantity.toString()),
              _buildTableCell(inventario.purchaseDate.toString()),
            ],
          );
        }),
      ],
    );

    pdf.addPage(
      pw.MultiPage(
        header: (pw.Context context) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(pdfImageLeft, width: 100, height: 100),
              pw.Image(pdfImageCenter, width: 200, height: 150),
              pw.Image(pdfImageRight, width: 100, height: 100),
            ],
          );
        },
        footer: (pw.Context context) {
          return pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
                'Página ${context.pageNumber} de ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 12)),
          );
        },
        build: (pw.Context context) {
          return [
            pw.Text('Tabla de Insumos',
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            permisosTable,
            pw.SizedBox(height: 20),
          ];
        },
      ),
    );

    final Uint8List bytes = await pdf.save();

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'InformeInsumos.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final inventario = usersProvider.inventario;
    final costos = usersProvider.costos;

    final inventarioDataSource =
        new InventarioDataSource(inventario, this.context, true);

    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.4,
              child: IconButton(
                onPressed: () {
                  generateAndDownloadPdfInventario(inventario, costos);
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'Filtrar por fecha',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            const Flexible(
                child: Text(
                  'Fecha inicial',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                width: 100,
                child: TextField(
                  controller: inventoryDateController,
                  decoration:
                  const InputDecoration(labelText: 'Fecha de inicio'),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          inventoryDateController.text =
                              DateFormat.yMd().format(selectedDate);
                          selectedStartDate = selectedDate;
                          filtrarPorRangoFechas(inventoryDateController.text,
                              inventoryDateEndController.text);
                        });
                      }
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Flexible(
                child: Text(
                  'Fecha final',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                width: 100,
                child: TextField(
                  enabled: inventoryDateController.text.isNotEmpty,
                  controller: inventoryDateEndController,
                  decoration: const InputDecoration(labelText: 'Fecha de fin'),
                  readOnly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedStartDate ?? DateTime.now(),
                      firstDate: selectedStartDate ?? DateTime.now(),
                      lastDate: DateTime(2030),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          inventoryDateEndController.text =
                              DateFormat.yMd().format(selectedDate);
                          filtrarPorRangoFechas(inventoryDateController.text,
                              inventoryDateEndController.text);
                        });
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            header: const Center(
                child: Text(
                  "Insumos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            headingRowHeight: 100,
            columns: const [
              DataColumn(label: Text('Id')),
              DataColumn(label: Text('Codigo')),
              DataColumn(label: Text('Producto')),
              DataColumn(label: Text('Descripción')),
              DataColumn(label: Text('Unidad/Medida')),
              DataColumn(label: Text('Fecha de compra')),
              DataColumn(label: Text('Cantidad')),
              DataColumn(label: Text('Precio')),
            ],
            source: inventarioDataSource,
            onPageChanged: (page) {},
          ),
        ),
      ],
    );
  }
}


