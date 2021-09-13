import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phonebuyertask/base/di/locator.dart';
import 'package:phonebuyertask/ui/device_details/controller/device_details_controller.dart';
import 'package:phonebuyertask/ui/device_details/model/res/device_model.dart';
import 'package:phonebuyertask/ui/device_listing/model/res/res_device_listing.dart';
import 'package:phonebuyertask/utils/const/font_size_utils.dart';
import 'package:phonebuyertask/utils/localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class DeviceDetailsScreen extends StatefulWidget {
  DeviceData devideData;
  DeviceDetailsScreen({required this.devideData});

  @override
  _DeviceDetailsScreenState createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  int _index = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<DeviceDetailsController>(context, listen: false)
        .getDeviceImages(widget.devideData.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Consumer<DeviceDetailsController>(
        builder: (context, deviceDetailsController, snapshot) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.devideData.name ?? ""),
            centerTitle: true,
          ),
          body: deviceDetailsController.isLoading
              ? Container(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: screenSize.height / 3.5,
                              color: Colors.white,
                            ),
                            SizedBox(height: 36),
                            Container(
                              width: double.infinity,
                              height: 12.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 12.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 12.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              height: 12.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      itemCount: 1,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Column(
                    children: [
                      Container(
                        height: screenSize.height / 3.5,
                        child: PageView.builder(
                          itemCount: deviceDetailsController
                              .resDeviceImages.deviceImages.length,
                          controller: PageController(viewportFraction: 0.7),
                          onPageChanged: (int index) =>
                              setState(() => _index = index),
                          itemBuilder: (context, index) {
                            return Transform.scale(
                              scale: index == _index ? 1 : 0.9,
                              child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.contain,
                                            imageUrl: deviceDetailsController
                                                    .resDeviceImages
                                                    .deviceImages[index]
                                                    ?.url ??
                                                "",
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$ " +
                                                    widget.devideData.price
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                widget.devideData.rating
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                widget.devideData.name ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (widget.devideData.isFavProduct) {
                                  Provider.of<DeviceDetailsController>(context,
                                          listen: false)
                                      .removeDeviceFromFav(
                                          widget.devideData.id ?? "", context);
                                  setState(() {
                                    widget.devideData.isFavProduct = false;
                                  });
                                } else {
                                  Provider.of<DeviceDetailsController>(context,
                                          listen: false)
                                      .markDeviceAsFav(
                                          widget.devideData, context);
                                  setState(() {
                                    widget.devideData.isFavProduct = true;
                                  });
                                }
                              },
                              icon: Icon(
                                !(widget.devideData.isFavProduct)
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                size: 24,
                                color: !(widget.devideData.isFavProduct)
                                    ? Colors.black
                                    : Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                        child: Text(
                          widget.devideData.description ?? "",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              wordSpacing: 5),
                        ),
                      )
                    ],
                  ),
                ));
    });
  }
}
