import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';

class SearchResultsScreen extends StatefulWidget {
  final List<dynamic> cars;

  const SearchResultsScreen({super.key, required this.cars});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool isGrid = true; // للتبديل بين Grid و List

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Results (${widget.cars.length})",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body:
          widget.cars.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 60.sp,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      translate.noCarsFound,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      translate.tryAdjustingSearchOrFilters,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
              : isGrid
              ? GridView.builder(
                padding: EdgeInsets.all(12.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: widget.cars.length,
                itemBuilder: (context, index) {
                  final car = widget.cars[index];
                  return _CarCard(car: car);
                },
              )
              : ListView.builder(
                padding: EdgeInsets.all(12.w),
                itemCount: widget.cars.length,
                itemBuilder: (context, index) {
                  final car = widget.cars[index];
                  return _CarTile(car: car);
                },
              ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final dynamic car;

  const _CarCard({required this.car});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: CachedNetworkImage(
              imageUrl: car.mainImage ?? "https://via.placeholder.com/150",
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => const Center(child: LoadingIndicator()),
              errorWidget:
                  (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.name ?? car.model ?? "Unknown Car",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  "${car.rentalPrice} / ${translate.day}",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CarTile extends StatelessWidget {
  final dynamic car;

  const _CarTile({required this.car});

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CachedNetworkImage(
            imageUrl: car.mainImage ?? "https://via.placeholder.com/60",
            width: 60.w,
            height: 60.h,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          car.name ?? car.model ?? "Unknown Car",
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "${car.rentalPrice} / ${translate.day}",
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.green.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, "/car-details", arguments: car.id);
        },
      ),
    );
  }
}
