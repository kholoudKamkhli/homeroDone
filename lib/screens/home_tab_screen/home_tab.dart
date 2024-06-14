import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homero/controllers/view_models/package_view_model.dart';
import 'package:homero/controllers/view_models/settings/settings_provider.dart';
import 'package:homero/screens/services/selected_service_view.dart';
import 'package:searchfield/searchfield.dart';
import "dart:math";
import '../../controllers/database/service_database.dart';
import '../../controllers/view_models/ads_view_model.dart';
import '../../controllers/view_models/recommendations_view_model.dart';
import '../../controllers/view_models/service_view_model.dart';
import '../shared/widgets/ad_widget.dart';
import '../shared/widgets/more_service_widget.dart';
import '../shared/widgets/package_widget.dart';
import '../shared/widgets/recommended_widget.dart';
import '../shared/widgets/service_widget.dart';
class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> servicesNames = [];
  final _random =  Random();
  var searchCont = TextEditingController();
  HomeViewModel homeViewModel = HomeViewModel();
  AdsViewModel adsViewModel = AdsViewModel();
  RecommendationViewModel recommendationViewModel = RecommendationViewModel();
  ServiceViewModel serviceViewModel=ServiceViewModel();
  PackageViewModel packageViewModel = PackageViewModel();
  SettingsProvider settingsProvider = SettingsProvider();
  List<Color> colors = [
    const Color.fromARGB(255, 52, 205, 196),
    const Color.fromARGB(255, 52, 168, 205),
    const Color.fromARGB(255, 52, 132, 205),
    const Color.fromARGB(255, 205, 181, 52),
  ];


  initServices() async {
      homeViewModel.initServices();
    adsViewModel.initAds();
    recommendationViewModel.initRecommends();
    serviceViewModel.initServicesNames();
    packageViewModel.getPackages();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocProvider<ServiceViewModel>(
                create:(_)=> serviceViewModel,
                child: BlocBuilder<ServiceViewModel,ServiceState>(
                  builder:(context,state){
                    if(state is LoadingServiceState){
                      return Container(
                        height: 72,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: const Center(child: CircularProgressIndicator(),),
                      );
                    }
                    else if(state is LoadedServiceState){
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent),
                          height: 72,
                          alignment: Alignment.topCenter,
                          child: Card(
                            color: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                            child: SearchField(
                              maxSuggestionsInViewPort: 4,
                              controller: searchCont,
                              onSubmit: (value) {
                                print(value);
                              },
                              // suggestionsDecoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(12),
                              //   color: Theme.of(context).scaffoldBackgroundColor,
                              // ),
                              itemHeight: 40,
                              suggestions: state.services
                                  .map((item) => SearchFieldListItem<String>(item.title))
                                  .toList(),
                              onSuggestionTap:
                                  (SearchFieldListItem<String> suggestion) async {
                                print(searchCont.text);
                                var serviceRes =
                                await ServiceDatabase.searchServiceByTitle2(
                                    searchCont.text);
                                var service = serviceRes[0];
                                Navigator.pushNamed(
                                    context, SelectedServiceView.routeName,
                                    arguments: service);
                              },
                              searchInputDecoration: InputDecoration(
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
                      );
                    }
                    else{
                      return const Center(child: Text("Something went wrong"),);
                    }
                  } ,
                ),
              ),
              BlocProvider<AdsViewModel>(
                create: (_)=>adsViewModel,
                child: Container(
                  height: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<AdsViewModel, AdsState>(
                    builder: (context, state) {
                      if (state is AdsErrorState) {
                        return Center(
                          child: Text(state.errorMessage),
                        );
                      } else if (state is AdsloadedState) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (buildContext, index) {
                            return AdWidget(ad: state.ads[index]);
                          },
                          itemCount: state.ads.length,
                        );
                      } else if (state is LoadingAdsState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Text("Something went wrong");
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Packages",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              BlocProvider<PackageViewModel>(
                  create:(_)=> packageViewModel,
                child: BlocBuilder<PackageViewModel,PackageState>(
                  builder: (context,state){
                    if(state is ErrorPackagesState){
                      return SizedBox(
                        height: 40,
                        child: Center(child: Text(state.errorMessage),),
                      );
                    }
                    else if(state is LoadedPackagesState){
                      return SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (buildContext, index) {
                            return PackageWidget(package: state.packages[index],color: colors[_random.nextInt(colors.length)],);
                          },
                          itemCount: state.packages.length,
                        ),
                      );
                    }
                    else {
                      return const SizedBox(height: 40,child: Center(
                        child: CircularProgressIndicator(),
                      ),);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Services",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider<HomeViewModel>(
                create: (_)=>homeViewModel,
                child: BlocBuilder<HomeViewModel, HomeState>(
                  builder: (context, state) {
                    if (state is ServicesErrorState) {
                      return Container(
                        height: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Center(
                          child: Container(
                              height: 200,
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(state.errorMessage)),
                        ),
                      );
                    } else if (state is ServicesloadedState) {
                      return Container(
                          height: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.services.length < 8
                                ? state.services.length + 1
                                : 8,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (context, index) {
                              return state.services.isNotEmpty
                                  ? index == 8 || index == state.services.length
                                      ? MoreServiceWidget(
                                          service: state.services[0],
                                          title: state.services[0].title,
                                          imagePath: state.services[0].imageUrl)
                                      : ServiceWidget(
                                          service: state.services[index],
                                          imagePath:
                                              state.services[index].imageUrl,
                                          title: state.services[index].title,
                                        )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Recommended",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocProvider<RecommendationViewModel>(
                create: (_)=>recommendationViewModel,
                child: BlocBuilder<RecommendationViewModel, RecommendsState>(builder: (context, state) {
                  if (state is ErrorRecommendsState) {
                    return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  } else if (state is RecommendsLoadedState) {
                    return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (buildContext, index) {
                          return RecommendedWidget(
                              recommendationModel: state.recommends[index]);
                        },
                        itemCount: state.recommends.length,
                      ),
                    );
                  } else {
                    return Container(
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

