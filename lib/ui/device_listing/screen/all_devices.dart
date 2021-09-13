import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/base/navigation/navigation_utils.dart';
import 'package:phonebuyertask/ui/device_details/model/res/device_model.dart';
import 'package:phonebuyertask/ui/device_listing/controller/device_listing_controller.dart';
import 'package:phonebuyertask/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phonebuyertask/utils/const/font_size_utils.dart';
import 'package:phonebuyertask/utils/const/navigation_param.dart';
import 'package:phonebuyertask/utils/localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllDevices extends StatefulWidget {
  @override
  _AllDevicesState createState() => _AllDevicesState();
}

class _AllDevicesState extends State<AllDevices> {
  @override
  void initState() {
    super.initState();
    Provider.of<DeviceListingController>(context, listen: false)
        .getDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceListingController>(
        builder: (context, deviceListingController, snapshot) {
      return deviceListingController.isLoading
          ? noItemBuilder()
          : deviceListingController.resDeviceListing.devices.length == 0
              ? Container(
                  child: Center(
                      child: Text(Localization.of(context).noDeviceFound)),
                )
              : Container(
                  child: ListView.builder(
                    itemCount:
                        deviceListingController.resDeviceListing.devices.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await locator<NavigationUtils>().push(
                              context, routeDeviceDetails, arguments: {
                            "deviceData": deviceListingController
                                .resDeviceListing.devices[index]
                          });
                          Provider.of<DeviceListingController>(context,
                                  listen: false)
                              .getDeviceList();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Material(
                            elevation: 8,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 0, top: 12, bottom: 12),
                                      height: 128,
                                      width: 92,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: deviceListingController
                                                .resDeviceListing
                                                .devices[index]
                                                .thumbImageURL ??
                                            "",
                                      )),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        deviceListingController.resDeviceListing
                                                .devices[index].name ??
                                            "".trim(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Container(
                                        width: screenSize.width / 1.6,
                                        child: new Text(
                                          deviceListingController
                                                  .resDeviceListing
                                                  .devices[index]
                                                  .description ??
                                              "",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: new TextStyle(
                                            fontSize: 13.0,
                                            fontFamily: 'Roboto',
                                            color: new Color(0xFF212121),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            Localization.of(context)
                                                    .devicePrice +
                                                " : ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "\$" +
                                                deviceListingController
                                                    .resDeviceListing
                                                    .devices[index]
                                                    .price
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            Localization.of(context).brandName +
                                                " : ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            deviceListingController
                                                    .resDeviceListing
                                                    .devices[index]
                                                    .brand ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: screenSize.width / 1.6,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  Localization.of(context)
                                                          .deviceRating +
                                                      " : ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  deviceListingController
                                                      .resDeviceListing
                                                      .devices[index]
                                                      .rating
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (deviceListingController
                                                    .resDeviceListing
                                                    .devices[index]
                                                    .isFavProduct) {
                                                  deviceListingController
                                                      .removeDeviceFromFav(
                                                          deviceListingController
                                                                  .resDeviceListing
                                                                  .devices[
                                                                      index]
                                                                  .id ??
                                                              "",
                                                          context);
                                                } else {
                                                  deviceListingController
                                                      .markDeviceAsFav(
                                                          deviceListingController
                                                              .resDeviceListing
                                                              .devices[index],
                                                          index,
                                                          context);
                                                }
                                              },
                                              child: Icon(
                                                !(deviceListingController
                                                        .resDeviceListing
                                                        .devices[index]
                                                        .isFavProduct)
                                                    ? Icons.favorite_border
                                                    : Icons.favorite,
                                                size: 24,
                                                color: !deviceListingController
                                                        .resDeviceListing
                                                        .devices[index]
                                                        .isFavProduct
                                                    ? Colors.black
                                                    : Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
    });
  }

  Widget noItemBuilder() => Container(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          enabled: true,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 64.0,
                    height: 64.0,
                    color: Colors.white,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                        ),
                        Container(
                          width: 40.0,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 6,
          ),
        ),
      );
}
