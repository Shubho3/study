import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'MasterData.dart';
import 'MasterDataController.dart';

class MasterDataScreen extends StatelessWidget {
  final MasterDataController masterDataController =
      Get.put(MasterDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Master Data X'),
      ),
      body: Obx(
            () =>
            ListView.builder(
              itemCount: masterDataController.masterData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(masterDataController.masterData[index].name!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Show update dialog
                          _showUpdateDialog(context, masterDataController.masterData[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete master data
                          masterDataController.deleteMasterData(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Screen
          _showAddBottomSheet(context);

        },
        child: Icon(Icons.add),
      ),
    );
  }
  void _showAddBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add New Master Data',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Validate and save data
                  if (nameController.text.isNotEmpty) {
                    masterDataController.addMasterData(
                      nameController.text,
                    );
                    Navigator.pop(context); // Close the bottom sheet
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
  void _showUpdateDialog(BuildContext context, MasterData masterData) {
    TextEditingController nameController = TextEditingController(text: masterData.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Master Data'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Validate and update data
                if (nameController.text.isNotEmpty) {
                  masterDataController.updateMasterData(masterData.id!, nameController.text);
                  Navigator.pop(context); // Close the dialog
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
