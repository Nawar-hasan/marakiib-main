import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marakiib_app/generated/app_localizations.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/upload_car/data/add_car_service.dart';
import 'package:marakiib_app/features/upload_car/data/model/add_car_model.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/dropdown_field.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/featuers.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/radio_group.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/show_congratulation_sheet.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/upload_images_section.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/upload_text_field.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/yes_no_question.dart';
import 'package:marakiib_app/features/upload_car/view_model/add_car_cubit.dart';
import 'package:marakiib_app/features/upload_car/view_model/add_car_state.dart';
import 'package:marakiib_app/features/upload_car/view_model/categories_cubit.dart';
import 'package:marakiib_app/features/upload_car/view_model/categories_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/themeing/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';

class UploadCarScreen extends StatefulWidget {
  const UploadCarScreen({super.key});

  @override
  State<UploadCarScreen> createState() => _UploadCarScreenState();
}

class _UploadCarScreenState extends State<UploadCarScreen> {
  // Text Controllers
  final _carNameEnController = TextEditingController();
  final _registrationController = TextEditingController();
  final _priceController = TextEditingController();
  final _pickupDeliveryPriceController = TextEditingController();
  final _feesController = TextEditingController();
  final _notesController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  final _imageAltEnController = TextEditingController();
  // final _availabilityStartController = TextEditingController();
  // final _availabilityEndController = TextEditingController();
  late DateTime availabilityStart;
  late DateTime availabilityEnd;

  @override
  void initState() {
    super.initState();
    availabilityStart = DateTime.now();
    availabilityEnd = DateTime.now().add(
      const Duration(days: 3650),
    ); // بعد 10 سنين
  }

  File? _mainImage;
  List<File> _extraImages = [];
  final ImagePicker _picker = ImagePicker();

  String? carCondition;
  bool dhamaan = true;
  bool pickupDelivery = true;
  bool termsAccepted = false;
  bool isActive = true;
  String? insuranceType; // Use non-localized key
  String? usageType; // Use non-localized key
  String? plateType; // Use non-localized key
  int? selectedCategoryId;

  // MyFeatures data
  Map<String, dynamic> selectedMyFeatures = {};
  List<int> selectedFeatureValueIds = [];

  @override
  void dispose() {
    _carNameEnController.dispose();
    _registrationController.dispose();
    _priceController.dispose();
    _pickupDeliveryPriceController.dispose();
    _feesController.dispose();
    _notesController.dispose();
    _descriptionEnController.dispose();
    _imageAltEnController.dispose();
    // _availabilityStartController.dispose();
    // _availabilityEndController.dispose();
    super.dispose();
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 12.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Future<Map<String, double>> _getStoredLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'latitude': prefs.getDouble('user_lat') ?? 24.7136,
      'longitude': prefs.getDouble('user_lng') ?? 46.6753,
    };
  }

  Future<void> _pickMainImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && await File(pickedFile.path).exists()) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.errorMainImage)),
      );
    }
  }

  Future<void> _pickExtraImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final validFiles = <File>[];
      for (var file in pickedFiles) {
        if (await File(file.path).exists()) {
          validFiles.add(File(file.path));
        }
      }
      if (validFiles.isNotEmpty) {
        setState(() {
          _extraImages = validFiles;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.errorNoValidExtraImages,
            ),
          ),
        );
      }
    }
  }

  // Future<void> _selectDate(BuildContext context, bool isStart) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2023),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       if (isStart) {
  //         _availabilityStartController.text =
  //             picked.toIso8601String().split('T').first;
  //       } else {
  //         _availabilityEndController.text =
  //             picked.toIso8601String().split('T').first;
  //       }
  //     });
  //   }
  // }

  void _showMyFeaturesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => MyFeaturesBottomSheet(
            locale:
                Localizations.localeOf(
                  context,
                ).languageCode, // Use current locale
            onFeaturesSelected: (features) {
              setState(() {
                selectedMyFeatures = features;
                selectedFeatureValueIds =
                    features.values
                        .where((value) => value != null)
                        .map<int>((value) => value['id'] as int)
                        .toList();
              });
            },
          ),
    );
  }

  Widget _buildSelectedMyFeaturesDisplay() {
    final l10n = AppLocalizations.of(context)!;
    if (selectedMyFeatures.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          l10n.noFeaturesSelected,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.primary),
        borderRadius: BorderRadius.circular(12.r),
        color: AppTheme.primary.withOpacity(0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.selectedFeatures,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
              GestureDetector(
                onTap: _showMyFeaturesBottomSheet,
                child: Icon(Icons.edit, size: 20.sp, color: AppTheme.primary),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...selectedMyFeatures.entries.map((featureEntry) {
            if (featureEntry.value != null) {
              final translations = featureEntry.value['translations'] as List;
              final currentLocale =
                  Localizations.localeOf(context).languageCode;
              final translation = translations.firstWhere(
                (t) => t['locale'] == currentLocale,
                orElse:
                    () =>
                        translations.isNotEmpty
                            ? translations.first as Map<String, dynamic>
                            : {'value': 'Unknown', 'locale': 'en'},
              );
              return Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  "• ${translation['value']}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return const SizedBox.shrink();
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoriesCubit()..getCategories()),
        BlocProvider(create: (_) => AddCarCubit(AddCarService(Dio()))),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.gray1,
          surfaceTintColor: Colors.transparent,
          title: Text(
            l10n.uploadCarTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 28.sp),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          left: false,
          right: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UploadImagesSection(
                  onPickMainImage: _pickMainImage,
                  mainImage: _mainImage,
                  onPickExtraImages: _pickExtraImages,
                  extraImages: _extraImages,
                ),
                _buildSectionTitle(l10n.basicCarInformation),
                CustomSearchTextField(
                  hint: l10n.carNameHint,
                  controller: _carNameEnController,
                ),
                SizedBox(height: 12.h),
                CustomSearchTextField(
                  hint: l10n.carModelRegistrationHint,
                  controller: _registrationController,
                ),
                SizedBox(height: 12.h),
                _buildSectionTitle(l10n.carFeatures),
                GestureDetector(
                  onTap: _showMyFeaturesBottomSheet,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.selectCarFeatures,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color:
                                selectedMyFeatures.isEmpty
                                    ? Colors.black
                                    : Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildSelectedMyFeaturesDisplay(),
                _buildSectionTitle(l10n.pricingInformation),
                CustomSearchTextField(
                  hint: l10n.pricePerDayHint,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.h),
                _buildSectionTitle(l10n.carStatusOptions),
                // RadioGroupWidget(
                //   title: l10n.carStatusOptions,
                //   options: [l10n.carConditionAvailable, l10n.carConditionReserved],
                //   selected: carCondition,
                //   onChanged: (val) => setState(() => carCondition = val),
                // ),
                SizedBox(height: 16.h),
                YesNoQuestionWidget(
                  question: l10n.longTermGuaranteeQuestion,
                  value: dhamaan,
                  onChanged: (val) => setState(() => dhamaan = val),
                ),
                SizedBox(height: 16.h),
                YesNoQuestionWidget(
                  question: l10n.pickupDeliveryQuestion,
                  value: pickupDelivery,
                  onChanged: (val) => setState(() => pickupDelivery = val),
                ),
                if (pickupDelivery) SizedBox(height: 12.h),
                if (pickupDelivery)
                  CustomSearchTextField(
                    hint: l10n.pickupDeliveryPriceHint,
                    controller: _pickupDeliveryPriceController,
                    keyboardType: TextInputType.number,
                  ),
                SizedBox(height: 16.h),
                YesNoQuestionWidget(
                  question: l10n.isCarActiveQuestion,
                  value: isActive,
                  onChanged: (val) => setState(() => isActive = val),
                ),
                _buildSectionTitle(l10n.additionalInformation),

                DropdownFieldWidget<String>(
                  hint: l10n.plateTypeHint,
                  items: [
                    {'value': 'green', 'label': l10n.plateTypePrivate},
                    {'value': 'white', 'label': l10n.plateTypeCommercial},
                  ],
                  selectedValue: plateType,
                  onChanged: (val) => setState(() => plateType = val),
                ),
                SizedBox(height: 12.h),
                DropdownFieldWidget<String>(
                  hint: l10n.insuranceTypeHint,
                  items: [
                    {
                      'value': 'comprehensive',
                      'label': l10n.insuranceTypeComprehensive,
                    },
                    {
                      'value': 'third_party',
                      'label': l10n.insuranceTypeThirdParty,
                    },
                    {
                      'value': 'full_coverage',
                      'label': l10n.insuranceTypeFullCoverage,
                    },
                  ],
                  selectedValue: insuranceType,
                  onChanged: (val) => setState(() => insuranceType = val),
                ),
                SizedBox(height: 12.h),
                DropdownFieldWidget<String>(
                  hint: l10n.usageTypeHint,
                  items: [
                    {'value': 'personal', 'label': l10n.usageTypePersonal},
                    {'value': 'commercial', 'label': l10n.usageTypeCommercial},
                    {'value': 'family', 'label': l10n.usageTypeFamily},
                    {'value': 'business', 'label': l10n.usageTypeBusiness},
                  ],
                  selectedValue: usageType,
                  onChanged: (val) => setState(() => usageType = val),
                ),
                _buildSectionTitle(l10n.categorySelection),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: LoadingIndicator());
                    } else if (state is CategoriesSuccess) {
                      return DropdownFieldWidget<int>(
                        hint: l10n.selectCategoryHint,
                        items:
                            state.categories
                                .map(
                                  (cat) => {'value': cat.id, 'label': cat.name},
                                )
                                .toList(),
                        selectedValue: selectedCategoryId,
                        onChanged:
                            (val) => setState(() => selectedCategoryId = val),
                      );
                    } else if (state is CategoriesFailure) {
                      return Text(
                        "Error: ${state.error}",
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                // _buildSectionTitle(l10n.availability),
                // Row(
                //   children: [
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () => _selectDate(context, true),
                //         child: AbsorbPointer(
                //           child: CustomSearchTextField(
                //             hint: l10n.availabilityStartHint,
                //             controller: _availabilityStartController,
                //           ),
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 12.w),
                //     Expanded(
                //       child: GestureDetector(
                //         onTap: () => _selectDate(context, false),
                //         child: AbsorbPointer(
                //           child: CustomSearchTextField(
                //             hint: l10n.availabilityEndHint,
                //             controller: _availabilityEndController,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                _buildSectionTitle(l10n.descriptions),
                CustomSearchTextField(
                  hint: l10n.descriptionHint,
                  controller: _descriptionEnController,
                  maxLines: 3,
                ),
                SizedBox(height: 12.h),
                _buildSectionTitle(l10n.termsAndSubmit),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppTheme.primary,
                      value: termsAccepted,
                      onChanged:
                          (val) => setState(() => termsAccepted = val ?? false),
                    ),
                    Expanded(
                      child: Text(
                        l10n.acceptTerms,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                BlocConsumer<AddCarCubit, AddCarState>(
                  listener: (context, state) {
                    if (state is AddCarSuccess) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder:
                            (_) => CongratulationsBottomSheet(
                              title: l10n.congratulationsTitle,
                              message: state.message,
                              buttonText: l10n.backToHome,
                              imagePath: 'assets/images/celebration.png',
                              onPressed: () {
                                Navigator.pop(context);
                                context.pop();
                              },
                            ),
                      );
                    } else if (state is AddCarFailure) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(message: state.error),
                      );
                    }
                  },
                  builder: (context, state) {
                    return MyCustomButton(
                      text:
                          state is AddCarLoading
                              ? l10n.uploading
                              : l10n.uploadNow,
                      voidCallback: () async {
                        if (!termsAccepted) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: l10n.errorTermsNotAccepted,
                            ),
                          );
                          return;
                        }

                        if (_mainImage == null || !await _mainImage!.exists()) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(message: l10n.errorMainImage),
                          );
                          return;
                        }

                        if (selectedFeatureValueIds.isEmpty) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: l10n.errorCarFeatures,
                            ),
                          );
                          return;
                        }

                        final validExtraImages =
                            _extraImages
                                .where((image) => image.existsSync())
                                .toList();
                        final location = await _getStoredLocation();
                        final latitude = location['latitude']!;
                        final longitude = location['longitude']!;

                        final slug =
                            "${_carNameEnController.text.toLowerCase().replaceAll(' ', '-')}-${DateTime.now().millisecondsSinceEpoch}";

                        final car = CarModel(
                          name: {
                            "en": _carNameEnController.text,
                            "ar": _carNameEnController.text,
                          },
                          model: _registrationController.text,
                          color:
                              selectedMyFeatures['color']?['translations']
                                  ?.firstWhere(
                                    (t) => t['locale'] == 'en',
                                    orElse: () => {'value': 'Black'},
                                  )['value'] ??
                              "Black",
                          mainImage: _mainImage,
                          extraImages: validExtraImages,
                          engineType:
                              selectedMyFeatures['engine_type']?['translations']
                                  ?.firstWhere(
                                    (t) => t['locale'] == 'en',
                                    orElse: () => {'value': 'Petrol'},
                                  )['value'] ??
                              "Petrol",
                          slug: slug,
                          plateType: plateType ?? "private",
                          rentalPrice:
                              int.tryParse(_priceController.text) ?? 100,
                          availabilityStart:
                              availabilityStart
                                  .toIso8601String()
                                  .split("T")
                                  .first,
                          availabilityEnd:
                              availabilityEnd
                                  .toIso8601String()
                                  .split("T")
                                  .first,
                          latitude: latitude,
                          longitude: longitude,
                          longTermGuarantee: dhamaan,
                          pickupDelivery: pickupDelivery,
                          pickupDeliveryPrice:
                              pickupDelivery
                                  ? int.tryParse(
                                    _pickupDeliveryPriceController.text,
                                  )
                                  : null,
                          isActive: isActive,
                          insuranceType: {
                            "en": l10n.insuranceTypeComprehensive,
                            "ar": l10n.insuranceTypeComprehensive,
                          },
                          usageNature: {
                            "en": l10n.usageTypePersonal,
                            "ar": l10n.usageTypePersonal,
                          },
                          description: {
                            "en": _descriptionEnController.text,
                            "ar": _descriptionEnController.text,
                          },
                          metaTitle: {
                            "en": _carNameEnController.text,
                            "ar": _carNameEnController.text,
                          },
                          metaDescription: {
                            "en": _descriptionEnController.text,
                            "ar": _descriptionEnController.text,
                          },
                          imageAlt: {
                            "en": _imageAltEnController.text,
                            "ar": _imageAltEnController.text,
                          },
                          carTypeId: 1,
                          categoryIds: [selectedCategoryId ?? 1],
                          featureValueIds: selectedFeatureValueIds,
                          optionIds: [1, 2],
                        );

                        try {
                          final formData = FormData.fromMap({
                            ...car.toJson(),
                            'main_image': await MultipartFile.fromFile(
                              car.mainImage!.path,
                              filename: car.mainImage!.path.split('/').last,
                            ),
                            'extra_images[]': await Future.wait(
                              car.extraImages.map(
                                (image) async => MultipartFile.fromFile(
                                  image.path,
                                  filename: image.path.split('/').last,
                                ),
                              ),
                            ),
                          });

                          context.read<AddCarCubit>().addCar(formData);
                        } catch (e) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: "Error preparing form data: $e",
                            ),
                          );
                        }
                      },
                      width: double.infinity,
                      height: 54.h,
                      fontSize: 16.sp,
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
