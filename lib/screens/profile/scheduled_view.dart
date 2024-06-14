import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/screens/orders/widgets/order_details_view.dart';

import '../../controllers/database/order_database.dart';
import '../../controllers/view_models/order_view_model.dart';
import '../../models/order_model.dart';

class ScheduledOrdersView extends StatefulWidget {
  static const String routeName = "ScheduledOrders";

  @override
  State<ScheduledOrdersView> createState() => _ScheduledOrdersViewState();
}

class _ScheduledOrdersViewState extends State<ScheduledOrdersView> {
  OrderViewModel viewModel = OrderViewModel();
  List<OrderModel> orders = [];

  initOrders() async {
    orders = await OrderDatabase.getuserScheduledOrders(
        FirebaseAuth.instance.currentUser?.uid ?? "");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initOrders();
    viewModel.getScheduledOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderViewModel>(
      create: (_) => viewModel,
      child: Scaffold(
          appBar: AppBar(
            title:  Text(
              "Schedule",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  ),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: BlocBuilder<OrderViewModel, OrderState>(
            builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } else if (state is LoadedState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    state.orders.isEmpty?const Center(child: Text("No Scheduled Orders"),):Expanded(
                      child: ListView.builder(
                        itemBuilder: (buildContext, index) {
                          return OrderDetailsView(order: state.orders[index]);
                        },
                        itemCount: state.orders.length,
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
