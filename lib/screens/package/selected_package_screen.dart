import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/controllers/view_models/package_view_model.dart';
import 'package:homero/models/service_model.dart';

import '../../controllers/database/service_database.dart';
import '../../models/package_model.dart';
import '../home_screen/home_screen_view.dart';
import '../shared/widgets/sub_service_widget.dart';
import '../workers/worker_view.dart';

class SelectedPackageView extends StatefulWidget {
  static const String routeName = "selectedPackageView";

  @override
  State<SelectedPackageView> createState() => _SelectedPackageViewState();
}

class _SelectedPackageViewState extends State<SelectedPackageView> {
  PackageViewModel packageViewModel = PackageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var package = ModalRoute.of(context)?.settings!.arguments as PackageModel;
    packageViewModel.getPackageSubServices(package.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          package.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider<PackageViewModel>(
        create: (_) => packageViewModel,
        child: Column(
          children: [
            BlocBuilder<PackageViewModel, PackageState>(
                builder: (context, state) {
              if (state is ErrorPackagesState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is LoadedPackageServicesState) {
                return Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            height:MediaQuery.of(context).size.height*0.891,
                            child: GridView.builder(
                              itemBuilder: (buildContext, index) {
                                return IgnorePointer(
                                  child: SubServiceWidget(
                                      subservice: state.subServices![index]
                                  ),
                                );
                              },
                              itemCount: state.subServices!.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom:0,
                      left:0,
                      right:0,
                      child: Container(
                        alignment: Alignment.center,
                        height: 127,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 84, 84, 84),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, WorkerView.routeName,arguments: {
                              'subService': null,
                              'package': package,
                            },);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 58,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color:
                              const Color.fromARGB(255, 52, 205, 196),
                            ),
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],

                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
