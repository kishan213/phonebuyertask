import 'package:flutter/material.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/base/navigation/navigation_utils.dart';
import 'package:phonebuyertask/ui/device_listing/controller/device_listing_controller.dart';
import 'package:phonebuyertask/utils/const/color_utils.dart';
import 'package:phonebuyertask/utils/const/font_size_utils.dart';
import 'package:phonebuyertask/utils/localization/localization.dart';
import 'package:provider/provider.dart';

import 'all_devices.dart';
import 'fav_devices.dart';

class DeviceListingScreen extends StatefulWidget {
  @override
  _DeviceListingScreenState createState() => _DeviceListingScreenState();
}

class _DeviceListingScreenState extends State<DeviceListingScreen> {
  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).appName),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          height: screenSize.height / 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: screenSize.height / 15,
                                child: Center(
                                    child: Text(
                                  Localization.of(context).short,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                              InkWell(
                                onTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  Provider.of<DeviceListingController>(context,
                                          listen: false)
                                      .sortByPrice(false);
                                },
                                child: Container(
                                  height: screenSize.height / 15,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                    top: BorderSide(color: Colors.grey),
                                  )),
                                  child: Center(
                                      child: Text(Localization.of(context)
                                          .priceLowToHigh)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  Provider.of<DeviceListingController>(context,
                                          listen: false)
                                      .sortByPrice(true);
                                },
                                child: Container(
                                  height: screenSize.height / 15,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                    top: BorderSide(color: Colors.grey),
                                  )),
                                  child: Center(
                                      child: Text(Localization.of(context)
                                          .priceHighToLow)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<DeviceListingController>(context,
                                          listen: false)
                                      .sortByRating();
                                  locator<NavigationUtils>().pop(context);
                                },
                                child: Container(
                                  height: screenSize.height / 15,
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                    top: BorderSide(color: Colors.grey),
                                  )),
                                  child: Center(
                                      child: Text(Localization.of(context)
                                          .deviceRating)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  locator<NavigationUtils>().pop(context);
                                  Provider.of<DeviceListingController>(context,
                                          listen: false)
                                      .cleanFilter();
                                },
                                child: Container(
                                  height: screenSize.height / 15,
                                  color: primaryColor,
                                  child: Center(
                                      child: Text(
                                    Localization.of(context).clear,
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child:
                    Provider.of<DeviceListingController>(context, listen: false)
                            .isFilterApply
                        ? Icon(Icons.filter_alt_rounded)
                        : Icon(Icons.filter_alt_outlined),
              ),
            )
          ],
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.phone_android)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        body: TabBarView(children: [AllDevices(), FavDevices()]),
      ),
    );
  }
}
