

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/models/service_model.dart';
import 'package:homero/models/worker_model.dart';
import 'package:homero/screens/workers/worker_widget.dart';
import 'package:http/http.dart' as http;

import '../../controllers/database/worker_database.dart';
import '../../controllers/view_models/workers_view_model.dart';
import '../../models/package_model.dart';
import '../service_details/service_details_view.dart';

int numOfChoosenWorkers = 0;

class WorkerView extends StatefulWidget {
  static const String routeName = "Worker";

  @override
  State<WorkerView> createState() => _WorkerViewState();
}

class _WorkerViewState extends State<WorkerView> {
  WorkerViewModel viewModel = WorkerViewModel();
  bool isSelected = false;
  late int workerChosen;

  static bool buttonClicked = false;
  List<WorkerModel> workers = [];
  SubServiceModel? service;
  PackageModel ? package;

  Future<List<WorkerModel>> initWorkers(String serviceName) async {
    List<WorkerModel> workers = await WorkerDatabase.getWorkers(serviceName);
    return workers;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numOfChoosenWorkers = 0;
    //SubServiceModel service =
    // ModalRoute.of(context)!.settings.arguments as SubServiceModel;
    // workers = viewModel.initWorkers(service.title);
  }
  void didChangeDependencies()async {
    super.didChangeDependencies();
    if (service == null&&package == null) {
      // service=ModalRoute.of(context)!.settings.arguments as SubServiceModel;
      // workers = viewModel.initWorkers(service?.title??"");
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      service = args['subService'] as SubServiceModel?;
      package = args['package'] as PackageModel?;}
    print(service?.title??"no title" );
      if(service!=null){
        print("inside service choice");
        await viewModel.initWorkers(service?.title??"");
      }
      else if(package!=null){
        print("inside package choice");
        await viewModel.initWorkers(package?.title??"");
      }
      print("Workers length ${workers.length}");
      setState(() {
      });
    }

  static changeColor() {
    buttonClicked = !buttonClicked;
  }

  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
     service = args['subService'] as SubServiceModel?;
     package = args['package'] as PackageModel?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workers",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider<WorkerViewModel>(
        create: (_) => viewModel,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<WorkerViewModel, WorkerSate>(builder: (context, state) {
               if (state is ErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if(state is LoadedState){
                 workers = state.workers;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return WorkerWidget(
                        index: index,
                        worker: state.workers[index],
                        changecolor: onClickCallBack,
                      );
                    },
                    itemCount: state.workers.length,
                  ),
                );
              }
               else{
                 return const Expanded(child: Center(child: CircularProgressIndicator(),));
               }
            }),
            Container(
              alignment: Alignment.center,
              height: 127,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: buttonClicked == false
                    ? Colors.transparent
                    : const Color.fromARGB(255, 84, 84, 84),
              ),
              child: InkWell(
                onTap: () {
                  if (buttonClicked == true) {
                    Navigator.pushNamed(
                      context,
                      ServiceDetailsView.routeName,
                      arguments: {
                        'service': service,
                        'workerName': workers[workerChosen].name,
                        'package':package,
                      },
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: buttonClicked == false
                        ? Color.fromARGB(255, 84, 84, 84)
                        : Color.fromARGB(255, 52, 205, 196),
                  ),
                  child: Text(
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
          ],
        ),
      ),
    );
  }

  void onClickCallBack(bool isSelected, int index) {
    workerChosen = index;
    if (isSelected == true) {
      buttonClicked = true;
    } else {
      buttonClicked = false;
    }
    setState(() {});
  }
}
// Expanded(child: FutureBuilder<List<WorkerModel>>(
//   future: initWorkers(service.title??""),
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       workers = (snapshot.data as List<WorkerModel>?) ?? [];
//       print(service.title??"");
//       print(workers.length);
//       return ListView.builder(
//         itemBuilder: (_, index) {
//           return WorkerWidget(
//             index:index,
//             worker: workers[index],
//             changecolor: onClickCallBack,
//
//           );
//         },
//         itemCount: workers.length,
//       );
//     } else if (snapshot.hasError) {
//       return Center(
//         child: Text('Error: ${snapshot.error}'),
//       );
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   },
// ),),
