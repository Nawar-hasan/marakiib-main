import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

import 'package:image_picker/image_picker.dart';
import 'package:marakiib_app/core/themeing/app_theme.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/upload_car/data/model/add_car_model.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/drob_filde2.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/dropdown_field.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/featuers.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/radio_group.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/show_congratulation_sheet.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/upload_images_section.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/upload_text_field.dart';
import 'package:marakiib_app/features/upload_car/view/widgets/yes_no_question.dart';
import 'package:marakiib_app/features/upload_car/view_model/categories_cubit.dart';
import 'package:marakiib_app/features/upload_car/view_model/categories_state.dart';
import 'package:marakiib_app/features/vendor_home/data/my_car_model.dart';
import 'package:marakiib_app/features/vendor_home/view_model/delete_car.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCarScreen extends StatefulWidget {
  final VendorCarModel car;

  const EditCarScreen({super.key, required this.car});

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  // Text Controllers initialized with VendorCarModel data
  late final TextEditingController _carNameEnController;
  late final TextEditingController _registrationController;
  late final TextEditingController _priceController;
  late final TextEditingController _pickupDeliveryPriceController;
  late final TextEditingController _feesController;
  late final TextEditingController _notesController;
  late final TextEditingController _descriptionEnController;
  late final TextEditingController _imageAltEnController;
  // late final TextEditingController _availabilityStartController;
  // late final TextEditingController _availabilityEndController;
  late DateTime availabilityStart;
  late DateTime availabilityEnd;

  // Image picker variables
  File? _mainImage;
  List<File> _extraImages = [];
  final ImagePicker _picker = ImagePicker();

  // Other form fields initialized with VendorCarModel data
  String carCondition = "Available";
  bool dhamaan = true;
  bool pickupDelivery = true;
  bool termsAccepted = true;
  bool isActive = true;
  String? insuranceTypeEn;
  String? usageTypeEn;
  String? plateType;
  int? selectedCategoryId = 1;

  // MyFeatures data
  Map<String, dynamic> selectedMyFeatures = {};
  List<int> selectedFeatureValueIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with VendorCarModel data
    availabilityStart = DateTime.now();
    availabilityEnd = DateTime.now().add(const Duration(days: 3650));
    _carNameEnController = TextEditingController(text: widget.car.nameEn ?? '');
    _registrationController = TextEditingController(
      text: widget.car.model ?? '',
    );
    _priceController = TextEditingController(
      text: widget.car.rentalPrice?.toString() ?? '',
    );
    _feesController = TextEditingController(text: '50');
    _notesController = TextEditingController(
      text: widget.car.description ?? '',
    );
    _descriptionEnController = TextEditingController(
      text: widget.car.description ?? '',
    );
    _imageAltEnController = TextEditingController(
      text: widget.car.imageAlt ?? '',
    );
    // _availabilityStartController = TextEditingController(text: widget.car.availabilityStart ?? '');
    // _availabilityEndController = TextEditingController(text: widget.car.availabilityEnd ?? '');

    // Initialize other fields
    carCondition = widget.car.isActive == 1 ? 'Available' : 'Reserved';
    dhamaan = widget.car.longTermGuarantee == 1;
    pickupDelivery = widget.car.pickupDelivery == 1;
    isActive = widget.car.isActive == 1;
    insuranceTypeEn = _mapInsuranceType(widget.car.insuranceType);
    usageTypeEn = _mapUsageType(widget.car.usageNature);
    plateType = _mapPlateType(widget.car.plateType) ?? 'green';
    selectedCategoryId =
        widget.car.categories?.isNotEmpty == true
            ? widget.car.categories![0]['id']
            : 1;

    // Initialize pickup delivery price controller
    _pickupDeliveryPriceController = TextEditingController(
      text: widget.car.pickupDeliveryPrice?.toString() ?? '',
    );
  }

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
        const SnackBar(content: Text("Failed to select main image")),
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
          const SnackBar(content: Text("No valid extra images selected")),
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
  //         _availabilityStartController.text = picked.toIso8601String().split('T').first;
  //       } else {
  //         _availabilityEndController.text = picked.toIso8601String().split('T').first;
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
            locale: 'en',
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
    if (selectedMyFeatures.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          "No features selected - Tap to select",
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
                "Selected Features:",
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
              final enTranslation = translations.firstWhere(
                (t) => t['locale'] == 'en',
                orElse:
                    () =>
                        translations.isNotEmpty
                            ? translations.first as Map<String, dynamic>
                            : {'value': 'Unknown', 'locale': 'en'},
              );
              return Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  "• ${enTranslation['value']}",
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
        BlocProvider(create: (_) => UpdateCarCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.gray1,
          surfaceTintColor: Colors.transparent,
          title: Text(
            l10n.editCarTitle,
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
                DropdownFieldWidget1<String>(
                  hint: "Plate Type",
                  items: [
                    {'value': 'green', 'label': l10n.plateTypePrivate},
                    {'value': 'white', 'label': l10n.plateTypeCommercial},
                  ],
                  selectedValue: plateType,
                  onChanged: (val) => setState(() => plateType = val),
                ),
                SizedBox(height: 12.h),
                DropdownFieldWidget1<String>(
                  hint: "Insurance Type",
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
                  selectedValue: insuranceTypeEn,
                  onChanged: (val) => setState(() => insuranceTypeEn = val),
                ),
                SizedBox(height: 12.h),
                DropdownFieldWidget1<String>(
                  hint: "Nature of use",
                  items: [
                    {'value': 'personal', 'label': l10n.usageTypePersonal},
                    {'value': 'commercial', 'label': l10n.usageTypeCommercial},
                    {'value': 'family', 'label': l10n.usageTypeFamily},
                    {'value': 'business', 'label': l10n.usageTypeBusiness},
                  ],
                  selectedValue: usageTypeEn,
                  onChanged: (val) => setState(() => usageTypeEn = val),
                ),

                _buildSectionTitle("Category Selection"),
                BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: LoadingIndicator());
                    } else if (state is CategoriesSuccess) {
                      return DropdownFieldWidget1<int>(
                        hint: "Select Category",
                        items: state.categories,
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
                BlocConsumer<UpdateCarCubit, UpdateCarState>(
                  listener: (context, state) {
                    if (state is UpdateCarState && state.isSuccess) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder:
                            (_) => CongratulationsBottomSheet(
                              title: l10n.congratulationsTitle,
                              message:
                                  state.message ?? l10n.carUpdatedSuccessfully,
                              buttonText: l10n.backToHome,
                              imagePath: 'assets/images/celebration.png',
                              onPressed: () {
                                Navigator.pop(context);
                                context.pop();
                              },
                            ),
                      );
                    } else if (state is UpdateCarState && state.error != null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error!)));
                    }
                  },
                  builder: (context, state) {
                    return MyCustomButton(
                      text: state.isLoading ? l10n.updating : l10n.updateCar,
                      voidCallback: () async {
                        if (!termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.errorTermsNotAccepted)),
                          );
                          return;
                        }
                        if (_mainImage != null && !await _mainImage!.exists()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.errorMainImage)),
                          );
                          return;
                        }
                        if (selectedFeatureValueIds.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.errorCarFeatures)),
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
                          plateType: plateType ?? "green",
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
                            "en": insuranceTypeEn ?? "comprehensive",
                            "ar": insuranceTypeEn ?? "comprehensive",
                          },
                          usageNature: {
                            "en": usageTypeEn ?? "personal",
                            "ar": usageTypeEn ?? "personal",
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
                          final Map<String, dynamic> formDataMap = {
                            ...car.toJson(),
                          };

                          // Add main image if selected
                          if (_mainImage != null) {
                            formDataMap['main_image'] =
                                await MultipartFile.fromFile(
                                  _mainImage!.path,
                                  filename: _mainImage!.path.split('/').last,
                                );
                          }

                          // Add extra images only if new ones were selected
                          if (_extraImages.isNotEmpty) {
                            formDataMap['extra_images[]'] = await Future.wait(
                              _extraImages.map(
                                (image) async => MultipartFile.fromFile(
                                  image.path,
                                  filename: image.path.split('/').last,
                                ),
                              ),
                            );
                          }

                          final formData = FormData.fromMap(formDataMap);

                          context.read<UpdateCarCubit>().updateCar(
                            widget.car.id,
                            formData,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error preparing form data: $e"),
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
// ✅ حط الدوال دي جوه ملف update_car.dart تحت كلاس _EditCarScreenState

String? _mapInsuranceType(String? value) {
  switch (value) {
    case 'شامل':
    case 'comprehensive':
      return 'comprehensive';
    case 'طرف ثالث':
    case 'third_party':
      return 'third_party';
    case 'تغطية كاملة':
    case 'full_coverage':
      return 'full_coverage';
    default:
      return null;
  }
}

String? _mapUsageType(String? value) {
  switch (value) {
    case 'شخصي':
    case 'personal':
      return 'personal';
    case 'تجاري':
    case 'commercial':
      return 'commercial';
    case 'عائلي':
    case 'family':
      return 'family';
    case 'أعمال':
    case 'business':
      return 'business';
    default:
      return null;
  }
}

String? _mapPlateType(String? value) {
  switch (value?.toLowerCase()) {
    case 'green':
    case 'private':
    case 'خضراء':
      return 'green';
    case 'white':
    case 'commercial':
    case 'بيضاء':
      return 'white';
    default:
      return 'green';
  }
}
