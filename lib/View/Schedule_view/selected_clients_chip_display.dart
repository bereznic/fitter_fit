import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/Services/Schedule_service/multi_select_clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedClientsChipDisplay extends StatefulWidget {
  @override
  _SelectedClientsChipDisplayState createState() =>
      _SelectedClientsChipDisplayState();
}

class _SelectedClientsChipDisplayState
    extends State<SelectedClientsChipDisplay> {
  @override
  Widget build(BuildContext context) {
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    final selectedClients =
        Provider.of<MultiSelectClients>(context, listen: false);
    return Consumer<MultiSelectClients>(builder: (context, client, child) {
      if (client.selectedClients.length > 0)
        return Wrap(
          children: client.selectedClients.map((selectedClient) {
            return FutureBuilder(
              future: fireStoreService.getUserDocumentFuture(selectedClient),
              builder: (context, clientSnapshot) {
                if (clientSnapshot.hasError)
                  return Text("Error loading clients");
                if (clientSnapshot.connectionState == ConnectionState.waiting)
                  return Text("Loading clients");
                UserEntity clientData = clientSnapshot.data;
                return Chip(
                  label: Text("${clientData.name}"),
                  deleteIcon: Icon(Icons.cancel_outlined),
                  onDeleted: () {
                    client.deselectClient(clientData.uid);
                  },
                );
              },
            );
          }).toList(),
        );
      return Container();
    });
  }
}
