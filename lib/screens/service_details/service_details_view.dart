import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:homero/models/order_model.dart';
import 'package:homero/models/package_model.dart';
import 'package:homero/models/service_model.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/database/notification_database.dart';
import '../../controllers/database/order_database.dart';
import '../../models/notifications_model.dart';
import '../home_screen/home_screen_view.dart';
import '../shared/dialog_utils.dart';



class ServiceDetailsView extends StatefulWidget {
  static const String routeName = "serviceDetails";

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  var nameCont = TextEditingController();

  var numCont = TextEditingController();

  var locationCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var dateCont = TextEditingController();
  var selectedRoomArea;
  var selectedRoom;
  var selectedSchedule;

  var completeNum;
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRoomArea = areas[0];
    selectedRoom = rooms[0];
    selectedSchedule = schedules[0];
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final service = args['service'] as SubServiceModel?;
    final workerName = args['workerName'] as String;
    final package = args["package"] as PackageModel?;
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: Text(
          service==null?package!.title :service.title,
          style: Theme.of(context).appBarTheme.titleTextStyle,

        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 327,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black45)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 8,right:8,top: 7),
                          child: Text(
                            "Full name",
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 127, 131),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: nameCont,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter valid name";
                                } else {
                                  return null;
                                }
                              },
                              cursorHeight: 0,
                              cursorWidth: 0,
                              decoration:
                              const InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 8, right: 5,top: 12),
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                    width: 327,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color.fromARGB(255, 126, 127,
                          131)),
                      color: Colors.white
                    ),
                    child: Container(
                      //margin: const EdgeInsets.only(top: 12),
                      child: IntlPhoneField(

                        controller: numCont,
                        validator: (value) {
                          if (value == null) {
                            return "Please enter valid name";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          counterText: "",
                          //helperText: "",
                          helperStyle: TextStyle(
                            color: Colors.grey
                          ),
                          hintStyle: TextStyle(

                          ),
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                        ),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          completeNum = phone.completeNumber;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(

                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: const Text(
                      "Enter location",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color.fromARGB(255, 126, 127, 131),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color.fromARGB(255, 126, 127,
                            131)),
                        color: Colors.white
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: SizedBox(
                      height: 60,
                      child: TextFormField(
                        onEditingComplete: () {
                          if (locationCont.text != null &&
                              locationCont.text != "") {

                          }
                        },


                        controller: locationCont,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter valid location";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          focusColor: Colors.transparent,
                          hintText: "location",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          filled: true,
                          enabled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: const Text(
                      "Enter Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color.fromARGB(255, 126, 127, 131),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color.fromARGB(255, 126, 127, 131),
                      ),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: GestureDetector(
                      onTap: () {
                        showTaskDatePicker();
                      },
                      child: SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat.yMMMEd().format(selectedDate),
                                style:const  TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: const Text(
                              "Area",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 127, 131),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.only(left: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton(
                                underline: const SizedBox(),
                                value: selectedRoomArea,
                                items: areas
                                    .map((room) =>
                                    DropdownMenuItem<String>(
                                        value: room,
                                        child: Row(
                                          children: [
                                            Text(room),
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  } else {
                                    setState(() {
                                      selectedRoomArea = value;
                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            child: const Text(
                              "Rooms",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Color.fromARGB(255, 126, 127, 131),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: DropdownButton(
                                underline: const SizedBox(),
                                value: selectedRoom,
                                items: rooms
                                    .map((room) =>
                                    DropdownMenuItem<int>(
                                        value: room,
                                        child: Row(
                                          children: [
                                            Text("$room"),
                                          ],
                                        )))
                                    .toList(),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  } else {
                                    setState(() {
                                      selectedRoom = value;
                                    });
                                  }
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    height: 1,
                    color: const Color.fromARGB(255, 217, 217, 217),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          child: const Text(
                            "Schedule Service",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color.fromARGB(255, 126, 127, 131),
                            ),
                          ),
                        ),
                        Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: const Color.fromARGB(255, 52, 205, 196),
                          activeTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.black12,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: 270,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isSwitched ? Colors.white : const Color.fromARGB(
                            255, 234, 234, 234)),
                    child: DropdownButton(
                        underline: const SizedBox(),
                        value: selectedSchedule,
                        items: schedules
                            .map((schedule) =>
                            DropdownMenuItem<String>(
                                value: schedule,
                                child: Row(
                                  children: [
                                    Text(schedule),
                                  ],
                                )))
                            .toList(),
                        onChanged: isSwitched ? (value) {
                          if (value == null) {
                            return;
                          } else {
                            setState(() {
                              selectedSchedule = value;
                            });
                          }
                        } : null),
                  ),

                ],
              ),
            ),),

            Container(
              alignment: Alignment.center,
              height: 127,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 84, 84, 84),
              ),
              child: InkWell(
                // onTap: () {
                //   buttonClicked = !buttonClicked;
                //   setState(() {});
                // },
                onTap: () async{
                  if (formKey.currentState!.validate()) {
                    OrderModel order = OrderModel(
                      cost: service==null?package!.cost:service.cost,
                      uId: FirebaseAuth.instance.currentUser!.uid,
                        serviceName:service==null?package!.title:service.title, location: locationCont.text,
                        date: selectedDate,
                        area: selectedRoomArea,
                        fullName: nameCont.text,
                        isFinished: false,
                        isScheduled: isSwitched,
                        mobileNum: completeNum,
                        numOfRoom: selectedRoom,
                        workerName:workerName,
                        scheduling: selectedSchedule);
                    //await OrderDatabase.addOrder(order);
                    OrderDatabase.addOrder(order);
                    NotificationModel notification = NotificationModel(content: "You Successfully Ordered ${order.serviceName} from worker ${order.workerName} and your order will be delivered within 2 days ", date: order.date);
                    NotificationDatabase.addNotification(FirebaseAuth.instance.currentUser!.uid, notification);
                    MyDialogUtils.showAnotherMessage(context, "Your Order has been placed successfuly ", "Ok",posAction: (){
                      Navigator.pushNamed(context, HomeScreenView.routeName);
                    });
                  }
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.7,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color.fromARGB(255, 52, 205, 196),
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
          ],
        ),
      ),
    );
  }



  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var userSelecteDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (userSelecteDate == null) {
      return;
    } else {
      setState(() {
        selectedDate = userSelecteDate;
        dateCont.text = DateFormat.yMMMEd().format(selectedDate);
        print("inside date set state");
        print(dateCont.text);
      });
    }
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  List<String> areas = ["80-120 sqm", "120-200 sqm", "200-400 sqm"];
  List<int> rooms = [1, 2, 3, 4, 5, 6, 7, 8];
  List<String>schedules = ["Every Week", "Every Month", "Every Year"];
}
