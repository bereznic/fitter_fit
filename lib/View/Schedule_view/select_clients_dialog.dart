import 'package:fitter_fit/Entity/user_entity.dart';
import 'package:fitter_fit/Services/firestore_service.dart';
import 'package:fitter_fit/View/Schedule_view/multi_select_clients_provider.dart';
import 'package:fitter_fit/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectClientsDialog extends StatefulWidget {
  @override
  _SelectClientsDialogState createState() => _SelectClientsDialogState();
}

class _SelectClientsDialogState extends State<SelectClientsDialog> {
  @override
  Widget build(BuildContext context) {
    final fireStoreService =
        Provider.of<FireStoreService>(context, listen: false);
    final selectClients =
        Provider.of<MultiSelectClients>(context, listen: false);
    return AlertDialog(
      scrollable: true,
      actions: [
        FlatButton.icon(
          icon: Icon(Icons.cancel),
          label: Text("Cancel"),
          onPressed: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => AlertDialog(
                      title: Text("Exit client selection?"),
                      actions: [
                        FlatButton.icon(
                            icon: Icon(Icons.cancel),
                            label: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        FlatButton.icon(
                            icon: Icon(Icons.check),
                            label: Text("Confirm"),
                            onPressed: () {
                              selectClients.deselectAllClients();
                              Navigator.pop(context, 'exit');
                            })
                      ],
                    )).then((result) {
              if (result == 'exit') Navigator.pop(context);
            });
          },
        ),
        FlatButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
          label: Text("Submit"),
        )
      ],
      content: StreamBuilder(
        stream: fireStoreService.getUserDocument(currentUserId),
        builder: (context, trainerSnapshot) {
          if (trainerSnapshot.hasError) {
            return Text("Error loading clients");
          }
          if (trainerSnapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          UserEntity trainerData = trainerSnapshot.data;
          return Container(
            height: height(context),
            width: width(context),
            child: ListView.builder(
              itemCount: trainerData.clients.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: fireStoreService
                      .getUserDocumentFuture(trainerData.clients[index]),
                  builder: (context, clientSnapshot) {
                    if (clientSnapshot.hasError)
                      return Text("Error loading clients");
                    if (clientSnapshot.connectionState ==
                        ConnectionState.waiting) return Text("Loading clients");
                    UserEntity clientData = clientSnapshot.data;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Consumer<MultiSelectClients>(
                          builder: (context, client, child) {
                            bool _isSelected =
                                client.isSelected(clientData.uid);
                            return Checkbox(
                                value: _isSelected,
                                onChanged: (bool newValue) {
                                  if (_isSelected == true)
                                    client.deselectClient(clientData.uid);
                                  else
                                    client.selectClient(clientData.uid);
                                });
                          },
                        ),
                        Flexible(
                            child: Text(
                                "${clientData.name}(${clientData.email})")),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
