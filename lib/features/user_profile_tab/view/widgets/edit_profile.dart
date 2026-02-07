import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marakiib_app/core/widgets/custom_button.dart';
import 'package:marakiib_app/core/widgets/custom_textFild.dart';
import 'package:marakiib_app/core/widgets/loading_indicator.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/profile_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/profile_state.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_cubit.dart';
import 'package:marakiib_app/features/user_profile_tab/view_model/user_state.dart';
import '../../../../core/themeing/app_theme.dart';
import 'package:marakiib_app/generated/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().fetchUser();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void fillUserData(UserSuccess state) {
    nameController.text = state.user.name;
    emailController.text = state.user.email;
    phoneController.text = state.user.phoneNumber ?? '';

    if (state.user.image != null) {
      selectedImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(translate.profile),
        centerTitle: true,
        backgroundColor: AppTheme.white,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                fillUserData(state);
              } else if (state is UserFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              } else if (state is ProfileSuccess) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: LoadingIndicator());
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage:
                              selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : (context.watch<UserCubit>().state
                                          is UserSuccess &&
                                      (context.watch<UserCubit>().state
                                                  as UserSuccess)
                                              .user
                                              .image !=
                                          null)
                                  ? NetworkImage(
                                    (context.watch<UserCubit>().state
                                            as UserSuccess)
                                        .user
                                        .image!,
                                  )
                                  : const AssetImage(
                                        'assets/images/0260ba5cc140e59e77706f147401bc2e1f26f094.png',
                                      )
                                      as ImageProvider,
                        ),
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.gray1010,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(4.r),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: AppTheme.gray2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    nameController.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    taskController: nameController,
                    hint: translate.nameHint,
                    showPrefixIcon: false,
                    showFillColor: false,
                    showLabelText: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    hintTextStyle: const TextStyle(color: Colors.transparent),
                    validate:
                        (value) =>
                            value == null || value.isEmpty
                                ? translate.pleaseEnterName
                                : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    taskController: emailController,
                    hint: translate.email,
                    showPrefixIcon: false,
                    showFillColor: false,
                    showLabelText: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    hintTextStyle: const TextStyle(color: Colors.transparent),
                    validate:
                        (value) =>
                            value == null || !value.contains('@')
                                ? translate.invalidEmail
                                : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    taskController: phoneController,
                    hint: translate.phoneNumber,
                    showPrefixIcon: false,
                    showLabelText: false,
                    showFillColor: false,
                    borderColor: AppTheme.gray1010,
                    focusedBorderColor: AppTheme.gray1010,
                    errorBorderColor: Colors.red,
                    hintTextStyle: const TextStyle(color: Colors.transparent),
                    validate:
                        (value) =>
                            value == null || value.length < 10
                                ? translate.invalidNumber
                                : null,
                  ),
                  SizedBox(height: 40.h),

                  MyCustomButton(
                    text: translate.saveEdit,
                    voidCallback: () {
                      context.read<ProfileCubit>().updateProfile(
                        name: nameController.text,
                        email: emailController.text,
                        phoneNumber: phoneController.text,
                        image: selectedImage,
                      );
                    },
                    height: 48.h,
                    width: 342.w,
                    radius: 4.r,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
