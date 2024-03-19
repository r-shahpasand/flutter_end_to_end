import 'package:flutter/material.dart';
import 'package:sample_latest/mixins/dialogs.dart';
import 'package:sample_latest/services/db/db_configuration.dart';
import 'package:sample_latest/widgets/text_field.dart';

class DbConfigurationDialog extends StatefulWidget {
  const DbConfigurationDialog({Key? key}) : super(key: key);

  @override
  State<DbConfigurationDialog> createState() => _DbConfigurationDialogState();
}

class _DbConfigurationDialogState extends State<DbConfigurationDialog> with CustomDialogs {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dialogWithButtons(
        title: "!!! Hey Dev's !!!",
        content: _buildFrom(),
        actions: ['Close'],
        callBack: (index) => Navigator.pop(context));
  }

  Widget _buildFrom() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select atleast one option to enable and configure the DB', style: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.deepOrangeAccent)),
            CheckboxListTile(
                title: const Text('Offline Mode'),
                subtitle: const Text('Stores the data in Local db only when there was no internet. Once internet is back data will Sync automatically with server and delete the local data'),
                isThreeLine: true,
                value: DbConfigurationsByDev.storeOnlyIfOffline,
                onChanged: (status) => onSelection(0, status)),
            CheckboxListTile(
                title: const Text('Online & Offline Mode'),
                subtitle: const Text('Irrespective of Internet data will be stored in local db and data will be deleted based on the configured date'),
                isThreeLine: true,
                value: DbConfigurationsByDev.storeInBothOfflineAndOnline,
                onChanged: (status) => onSelection(1, status)),
            CheckboxListTile(
                title: const Text('Dumping Offline Data'),
                subtitle: const Text('Data will be dumped into the local DB at the time login or Module loading. Later it is used making some operations'),
                isThreeLine: true,
                value: DbConfigurationsByDev.dumpOfflineData,
                onChanged: (status) => onSelection(2, status)),
          ],
        ),
      ),
    );
  }

  void onSelection(int index, bool? status) {
    status ??= false;

    switch (index) {
      case 0:
        DbConfigurationsByDev.storeOnlyIfOffline = status;
        break;
      case 1:
        DbConfigurationsByDev.storeInBothOfflineAndOnline = status;
        break;
      case 2:
        DbConfigurationsByDev.dumpOfflineData = status;
        break;
    }
    setState(() {

    });
  }
}
