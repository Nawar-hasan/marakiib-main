import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/custom_textFild.dart';
import 'package:marakiib_app/features/search_home/data/repository/search_repo.dart';
import 'package:marakiib_app/features/search_home/view_model/cubit/search_cubit.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/features/user_home/view/widgets/price_field.dart';
import 'package:marakiib_app/features/user_home/view/widgets/search_results_page.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class SearchFilterPage extends StatefulWidget {
  const SearchFilterPage({super.key});

  @override
  State<SearchFilterPage> createState() => _SearchFilterPageState();
}

class _SearchFilterPageState extends State<SearchFilterPage> {
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  double? _minPrice;
  double? _maxPrice;
  int? _carTypeId;
  bool _nearest = false;
  String? _usageNature; // ✅ جديد
  bool _longTermGuarantee = false;

  @override
  void dispose() {
    _queryController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.lightTheme.textTheme;
    final translate = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => SearchCubit(CarSearchRepo(dio: Dio())),
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate.searchFilter, style: textTheme.titleMedium),
          backgroundColor: AppTheme.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  taskController: _queryController,
                  hint: translate.searchForCar,
                  labelText: translate.searchKeyword,
                  icon: Icons.search,
                  hintTextStyle: const TextStyle(),
                  borderColor: AppTheme.gray1010,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.h),
                PriceField(
                  header: translate.minPrice,
                  hintText: translate.enterMinPrice,
                  controller: _minPriceController,
                  onChanged: (v) => _minPrice = double.tryParse(v),
                ),
                SizedBox(height: 16.h),
                PriceField(
                  header: translate.maxPrice,
                  hintText: translate.enterMaxPrice,
                  controller: _maxPriceController,
                  onChanged: (v) => _maxPrice = double.tryParse(v),
                ),
                SizedBox(height: 16.h),

                // ✅ Dropdown usageNature
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppTheme.gray1,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppTheme.gray1010, width: 1.5),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: translate.usageTypeHint,
                    ),
                    value: _usageNature,
                    items: [
                      {'value': 'personal', 'label': translate.usageTypePersonal},
                      {'value': 'commercial', 'label': translate.usageTypeCommercial},
                      {'value': 'family', 'label': translate.usageTypeFamily},
                      {'value': 'business', 'label': translate.usageTypeBusiness},
                    ].map((item) {
                      return DropdownMenuItem<String>(
                        value: item['value'],
                        child: Text(item['label']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _usageNature = value;
                      });
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: () {
                    setState(() {
                      _nearest = !_nearest;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppTheme.gray1,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppTheme.gray1010, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translate.nearestToMyLocation,
                          style: textTheme.titleSmall,
                        ),
                        Switch(
                          value: _nearest,
                          onChanged: (v) => setState(() => _nearest = v),
                          activeColor: AppTheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: () {
                    setState(() {
                      _longTermGuarantee = !_longTermGuarantee;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 0.w),
                    decoration: BoxDecoration(
                      color: AppTheme.gray1,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: AppTheme.gray1010, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            translate.longTermGuarantee,
                            style: textTheme.titleSmall?.copyWith(fontSize: 10.sp),
                          ),
                        ),
                        Switch(
                          value: _longTermGuarantee,
                          onChanged: (v) => setState(() => _longTermGuarantee = v),
                          activeColor: AppTheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
                Builder(
                  builder: (BuildContext innerContext) {
                    return Center(
                      child: MyCustomButton(
                        text: translate.search,
                        width: 200.w,
                        height: 52.h,
                        radius: 14.r,
                        fontSize: 16.sp,
                        color: AppTheme.primary,
                        textColor: AppTheme.white,
                        borderColor: AppTheme.primary,
                        voidCallback: () {
                          innerContext.read<SearchCubit>().applyFilters(
                            query: _queryController.text,
                            priceMin: _minPrice,
                            priceMax: _maxPrice,
                            carTypeId: _carTypeId,
                            nearest: _nearest,
                            usageNature: _usageNature, // ✅ جديد
                            longTermGuarantee: _longTermGuarantee, // ✅ جديد

                          );
                          Navigator.push(
                            innerContext,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: innerContext.read<SearchCubit>(),
                                child: const SearchResultsPage(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
