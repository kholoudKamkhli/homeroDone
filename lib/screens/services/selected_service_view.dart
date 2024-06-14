import 'package:flutter/material.dart';
import 'package:homero/models/service_model.dart';

import '../../controllers/database/service_database.dart';
import '../home_screen/home_screen_view.dart';
import '../shared/widgets/sub_service_widget.dart';

class SelectedServiceView extends StatelessWidget {
  static const String routeName = "selectedServiceView";
  @override
  Widget build(BuildContext context) {
    var service = ModalRoute.of(context)?.settings!.arguments as ServiceModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          service.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,

        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              ),
          onPressed: () => Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
        Expanded(
          child: FutureBuilder<List<SubServiceModel>>(
          future: ServiceDatabase.getServiceSubServices(service.id), // a previously-obtained Future<String> or null
          builder: (BuildContext context, snapshot) {
            List<SubServiceModel>? subServices;
            if (snapshot.hasData) {
              subServices = snapshot.data;
            } else if (snapshot.hasError) {
              return Center(child:Text("Couldn't get services") ,);
            } else if(snapshot.connectionState==ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            return GridView.builder(
              itemBuilder: (buildContext, index) {
                return SubServiceWidget(
                    subservice: subServices![index]);
              },
              itemCount: subServices!.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
            );
          },
      ),
        ),
        ],
      ),
    );
  }
}
