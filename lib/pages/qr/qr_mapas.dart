import 'package:componentes/bloc/scan_blocs.dart';
import 'package:componentes/models/scan_model.dart';
import 'package:componentes/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class MapasPageQR extends StatelessWidget {
  ScansBloc _scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    _scansBloc.getScans();
    return Scaffold(
      body: StreamBuilder(
        stream: _scansBloc.scansStreamGeo,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(
              child: Text("No hay datos"),
            );
          }
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (context, i) {
              return Dismissible(
                background: Container(
                  color: Colors.red,
                ),
                key: UniqueKey(),
                child: ListTile(
                  leading: Icon(Icons.map),
                  title: Text(scans[i].valor),
                  trailing: Icon(Icons.arrow_forward_ios),
                  subtitle: Text(scans[i].id.toString()),
                  onTap: () {
                    utils.launchScan(context, scans[i]);
                  },
                ),
                onDismissed: (tile) {
                  _scansBloc.deleteScan(scans[i].id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
