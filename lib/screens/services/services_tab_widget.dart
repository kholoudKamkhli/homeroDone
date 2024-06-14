import 'package:flutter/material.dart';
import 'package:homero/screens/services/service_tab_widget.dart';

import '../../controllers/database/service_database.dart';
import '../../models/service_model.dart';
import '../shared/widgets/sub_service_widget.dart';

class ServiceTabsWidget extends StatefulWidget {
  @override
  State<ServiceTabsWidget> createState() => _ServiceTabsWidgetState();
}

class _ServiceTabsWidgetState extends State<ServiceTabsWidget> {
  List<ServiceModel> services = [];
  List<SubServiceModel> subServices = [];
  int selectedIndex = 0;

  initServices() async {
    services = await ServiceDatabase.getMainServices();
    subServices = await ServiceDatabase.getServiceSubServices(services[0].id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: services.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 60,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "What Services Are You Looking For?",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
            ),
          ),
          TabBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            tabs: services
                .map((e) => ServiceTabWidget(
                      name: e.title ?? "",
                      isSelected:
                          selectedIndex == services.indexOf(e) ? true : false,
                    ))
                .toList(),
            isScrollable: true,
            indicatorColor: Colors.transparent,
          ),
          GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (buildContext, index) {
                return subServices.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SubServiceWidget(subservice: subServices[index]);
              })
        ],
      ),
    );
  }
}
