import 'package:flutter/material.dart';
import 'package:homero/screens/services/service_tab_widget.dart';
import '../../controllers/database/service_database.dart';
import '../../models/service_model.dart';
import '../home_screen/home_screen_view.dart';
import '../shared/widgets/sub_service_widget.dart';

class ServicesView extends StatefulWidget {
  static const String routeName = "ServicesView";

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  List<ServiceModel> services = [];
  List<SubServiceModel> subServices = [];
  String? searchService;
  int selectedIndex = 0;
  List<SubServiceModel> searchServices = [];
  initServices() async {
    services = await ServiceDatabase.getMainServices();
    Future.delayed(const Duration(seconds: 40));
    subServices = await ServiceDatabase.getServiceSubServices(
        services[selectedIndex].id ?? "");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Services",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomeScreenView.routeName),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  onChanged: (value) async {
                    searchService = value;
                    searchServices =
                        await ServiceDatabase.getAllSubServices(value);
                    setState(() {
                      print("onChanged value $searchService");
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ),
            ),
          ),
          //ServiceTabsWidget(),
          searchService != null
              ? const SizedBox(
                  height: 0,
                )
              : const SizedBox(
                  height: 10,
                ),
          searchService != null
              ? Container()
              : SizedBox(
                  height: 60,
                  child: DefaultTabController(
                    initialIndex: selectedIndex,
                    length: services.length,
                    child: TabBar(
                      onTap: (index) async {
                        selectedIndex = index;
                        subServices =
                            await ServiceDatabase.getServiceSubServices(
                                services[index].id ?? "");
                        setState(() {});
                      },
                      tabs: services
                          .map((e) => ServiceTabWidget(
                                name: e.title ?? "",
                                isSelected: selectedIndex == services.indexOf(e)
                                    ? true
                                    : false,
                              ))
                          .toList(),
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                    ),
                  ),
                ),

          searchService != null
              ? Expanded(
                  child: searchServices.isEmpty
                      ? const Center(
                          child: Text("No matched results"),
                        )
                      : GridView.builder(
                          itemBuilder: (buildContext, index) {
                            return SubServiceWidget(
                                subservice: searchServices[index]);
                          },
                          itemCount: searchServices.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                        ),
                )
              : Expanded(
                  child: subServices.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemBuilder: (buildContext, index) {
                            return SubServiceWidget(
                                subservice: subServices[index]);
                          },
                          itemCount: subServices.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                        ),
                )
        ],
      ),
    );
  }
}
