import 'package:admin_dashboard/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:admin_dashboard/models/parametrizacion.dart';

import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';

class SiembraDataSource extends DataTableSource {
  final List<Parametrizacion> parametrizaciones;
  final BuildContext context;
  final bool reporte;
  SiembraDataSource(this.parametrizaciones, this.context, this.reporte);

  @override
  DataRow getRow(int index) {
    final Parametrizacion parametrizacion = parametrizaciones[index];

    final TextEditingController nombreSemillasController =
        TextEditingController();
    final TextEditingController cantidadpesticidaController =
        TextEditingController();
    final TextEditingController cantidadFertilizanteController =
        TextEditingController();
    final TextEditingController fumgationDateController =
        TextEditingController();

    final TextEditingController sowingDateController = TextEditingController();
    final TextEditingController sowingDateEndController =
        TextEditingController();
    final TextEditingController numberOfBunchesController =
        TextEditingController();
    final TextEditingController rejectedBunchesController =
        TextEditingController();
    final TextEditingController averageBunchWeightController =
        TextEditingController();

    List<String> condition = ["Sunny", "Rainning"];
    String selectedCondition = parametrizacion.climaticCondition.toString();
    List<String> sowingOptions = ["8", "10"];
    String selectedSowingOption =
        parametrizacion.estimatedSowingTime.toString();
    List<String> batchOptions = ["1", "2", "3", "4", "5", "6"];
    String selectedBatchOption = parametrizacion.batchNumber.toString();

    String selectedIrrigationOption = parametrizacion.irrigation.toString();
    List<String> irrigationOptions = (selectedCondition == "Rainning")
        ? ["No disponible"]
        : ["Motores/Bombas", "Electrico/Diesel"];
    List<String> variedadOptions = ["Cavendish", "Williams"];
    String selectedvariedadOption = "Cavendish";

    cantidadFertilizanteController.text =
        parametrizacion.fertilizerQuantityKG.toString();
    nombreSemillasController.text = parametrizacion.seedName.toString();
    cantidadpesticidaController.text =
        parametrizacion.pesticideQuantityKG.toString();
    fumgationDateController.text =
        DateFormat.yMd().format(parametrizacion.fumigationDate);

    DateTime selectedStartDate = parametrizacion.sowingDate;
    sowingDateController.text =
        DateFormat.yMd().format(parametrizacion.sowingDate);
    sowingDateEndController.text =
        DateFormat.yMd().format(parametrizacion.sowingDateEnd);

    numberOfBunchesController.text = parametrizacion.numberOfBunches.toString();
    rejectedBunchesController.text = parametrizacion.rejectedBunches.toString();
    averageBunchWeightController.text =
        parametrizacion.averageBunchWeight.toString();

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Tooltip(
          message: parametrizacion.id
              .toString(), // Mensaje del tooltip sin _trimString
          child: Text(_trimString(parametrizacion.id.toString(), 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion
              .climaticCondition, // Mensaje del tooltip sin _trimString
          child: Text(_trimString(parametrizacion.climaticCondition, 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion
              .bananaVariety, // Mensaje del tooltip sin _trimString
          child: Text(_trimString(parametrizacion.bananaVariety, 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion.pesticideQuantityKG
              .toString(), // Mensaje del tooltip sin _trimString
          child: Text(
              _trimString(parametrizacion.pesticideQuantityKG.toString(), 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion.fertilizerQuantityKG
              .toString(), // Mensaje del tooltip sin _trimString
          child: Text(
              _trimString(parametrizacion.fertilizerQuantityKG.toString(), 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion.seedName
              .toString(), // Mensaje del tooltip sin _trimString
          child: Text(_trimString(parametrizacion.seedName.toString(), 5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: DateFormat('MMM d, y').format(parametrizacion
              .fumigationDate), // Mensaje del tooltip sin _trimString
          child: Text(_trimString(
              DateFormat('MMM d, y').format(parametrizacion.fumigationDate),
              5)),
        ),
      ),
      DataCell(
        Tooltip(
          message: parametrizacion.irrigation
              .toString(), // Mensaje del tooltip sin _trimString
          child: Text(_trimString(parametrizacion.irrigation.toString(), 5)),
        ),
      ),
      if (reporte != true)
        DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  final usersProvider =
                      Provider.of<UsersProvider>(context, listen: false);
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return AlertDialog(
                            title: Text('Modificar planificación'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButtonFormField<String>(
                                    value: selectedCondition,
                                    decoration: const InputDecoration(
                                        labelText: 'Condición climática'),
                                    items: condition.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCondition = value!;
                                        if (selectedCondition == 'Sunny') {
                                          irrigationOptions = [
                                            "Motores/Bombas",
                                            "Electrico/Diesel"
                                          ];
                                          selectedIrrigationOption =
                                              "Motores/Bombas";
                                        } else if (selectedCondition ==
                                            'Rainning') {
                                          irrigationOptions = ["No disponible"];
                                          selectedIrrigationOption =
                                              "No disponible";
                                        }
                                      });
                                    },
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedvariedadOption,
                                    decoration: InputDecoration(
                                        labelText: 'Variedad del banano'),
                                    items: variedadOptions.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedvariedadOption = newValue!;
                                      });
                                    },
                                  ),
                                  TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: nombreSemillasController,
                                    decoration: InputDecoration(
                                        labelText:
                                            'Cantidad de semillas/plantas'),
                                  ),
                                  TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: cantidadFertilizanteController,
                                    decoration: InputDecoration(
                                        labelText: 'Cantidad de fertilizante'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: cantidadpesticidaController,
                                    decoration: InputDecoration(
                                        labelText: 'Cantidad de pesticida'),
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextField(
                                    controller: fumgationDateController,
                                    decoration: InputDecoration(
                                        labelText: 'Fecha fumigación'),
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2040),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            fumgationDateController.text =
                                                DateFormat.yMd()
                                                    .format(selectedDate);
                                          });
                                        }
                                      });
                                    },
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedIrrigationOption,
                                    decoration:
                                        InputDecoration(labelText: 'Riego'),
                                    items: irrigationOptions.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedIrrigationOption = newValue!;
                                      });
                                    },
                                  ),
                                  TextField(
                                    controller: sowingDateController,
                                    decoration: InputDecoration(
                                        labelText: 'Fecha de inicio'),
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            sowingDateController.text =
                                                DateFormat.yMd()
                                                    .format(selectedDate);
                                            selectedStartDate = selectedDate;
                                          });
                                        }
                                      });
                                    },
                                  ),
                                  TextField(
                                    controller: sowingDateEndController,
                                    decoration: InputDecoration(
                                        labelText: 'Fecha de fin'),
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: selectedStartDate,
                                        lastDate: DateTime(2030),
                                      ).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            sowingDateEndController.text =
                                                DateFormat.yMd()
                                                    .format(selectedDate);
                                          });
                                        }
                                      });
                                    },
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedSowingOption,
                                    decoration: InputDecoration(
                                        labelText: 'Tiempo estimado'),
                                    items: sowingOptions.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedSowingOption = newValue!;
                                      });
                                    },
                                  ),
                                  TextField(
                                    controller: numberOfBunchesController,
                                    decoration: InputDecoration(
                                        labelText: 'Número de racimos'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                  TextField(
                                    controller: rejectedBunchesController,
                                    decoration: InputDecoration(
                                        labelText:
                                            'Número de racimos rechazados'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                  TextField(
                                    controller: averageBunchWeightController,
                                    decoration: const InputDecoration(
                                        labelText: 'Peso estimado',
                                        hintText: 'Kg'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),

                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedBatchOption,
                                    decoration: InputDecoration(
                                        labelText: 'Número de lote'),
                                    items: batchOptions.map((option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text("Lote #" + option),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedBatchOption = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  // Validar cantidad y precio

                                  // Validar cantidad y precio

                                  final nombreSemilla =
                                      nombreSemillasController.text;
                                  final cantidadF = double.tryParse(
                                      cantidadFertilizanteController.text);
                                  final cantidadP = double.tryParse(
                                      cantidadpesticidaController.text);
                                  final condicion = selectedCondition;
                                  final variedadBanano = selectedvariedadOption;
                                  final riego = selectedIrrigationOption;
                                  final fumationDate =
                                      fumgationDateController.text;

                                  final fechaI = sowingDateController.text;
                                  final fechaF = sowingDateEndController.text;
                                  final selectedSowingOpt =
                                      int.tryParse(selectedSowingOption);

                                  final numberB = int.tryParse(
                                      numberOfBunchesController.text);
                                  final rechazados = int.tryParse(
                                      rejectedBunchesController.text);
                                  final estimadoPeso = double.tryParse(
                                      averageBunchWeightController.text);
                                  final numberLote =
                                      int.tryParse(selectedBatchOption);

// Validar que los campos no estén vacíos
                                  if (condicion.isEmpty ||
                                      variedadBanano.isEmpty) {
                                    NotificationsService.showSnackBarError(
                                        'Variedad o condición incorrectos');
                                    return;
                                  }

// Validar que las fechas sean válidas
                                  // ignore: unnecessary_null_comparison
                                  if (fechaI == null || fechaF == "") {
                                    NotificationsService.showSnackBarError(
                                        'Fecha o Nombre incorrectos');
                                    return;
                                  }

// Validar la longitud máxima de los campos
                                  final maxCharacters = 10;

                                  if (numberB.toString().length >
                                      maxCharacters) {
                                    numberOfBunchesController.text = numberB
                                            .toString()
                                            .substring(0, maxCharacters) +
                                        '...';
                                  }

                                  if (estimadoPeso.toString().length >
                                      maxCharacters) {
                                    averageBunchWeightController.text =
                                        estimadoPeso
                                                .toString()
                                                .substring(0, maxCharacters) +
                                            '...';
                                  }

                                  //final fecha = fechaController.text;
                                  // ignore: unnecessary_null_comparison
                                  if (condicion == null ||
                                      condicion == "" ||
                                      // ignore: unnecessary_null_comparison
                                      variedadBanano == null ||
                                      variedadBanano == "") {
                                    NotificationsService.showSnackBarError(
                                        'variedad o condición incorrectos');
                                    return;
                                  }

                                  // Actualizar el inventario
                                  //  inventario.product = productoController.text;
                                  // inventario.purchaseDate = DateFormat.yMd().parse(fechaController.text);
                                  //inventario.quantity = cantidad;
                                  //inventario.unitPrice = precio;

                                  // Guardar cambios
                                  await usersProvider.putUpdateParametrizacion(
                                      condicion,
                                      nombreSemilla,
                                      variedadBanano,
                                      cantidadF!,
                                      cantidadP!,
                                      fumationDate,
                                      riego,
                                      fechaI,
                                      fechaF,
                                      selectedSowingOpt!,
                                      estimadoPeso!,
                                      numberB!,
                                      rechazados!,
                                      numberLote!,
                                      parametrizacion.id);
                                  NotificationsService.showSnackBar(
                                      'Planificación Actualizada');
                                  Navigator.pop(context);
                                },
                                child: Text('Guardar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  final dialog = AlertDialog(
                    title: const Text('Eliminar siembra'),
                    content: const Text('¿Desea eliminar el registro?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar')),
                      ElevatedButton(
                          onPressed: () async {
                            final usersProvider = Provider.of<UsersProvider>(
                                context,
                                listen: false);
                            await usersProvider
                                .deleteParametrizacion(parametrizacion.id);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Eliminar')),
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
              ),
            ],
          ),
        ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => this.parametrizaciones.length;

  @override
  int get selectedRowCount => 0;
}

String _trimString(String value, int maxLength) {
  if (value.length > maxLength) {
    return value.substring(0, maxLength) + "...";
  }
  return value;
}
