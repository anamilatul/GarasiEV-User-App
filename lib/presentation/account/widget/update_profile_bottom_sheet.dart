import 'package:flutter/material.dart';

import '../../../utils/color_resources.dart';

class UpdateProfileBottomSheet extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController bioController;
  final VoidCallback onUpdateProfile;

  UpdateProfileBottomSheet({
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.bioController,
    required this.onUpdateProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Update Profile',
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(
                labelText: 'Bio',
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorResources.primaryMaterial,
                borderRadius: BorderRadius.circular(25),
              ),
              child: MaterialButton(
                onPressed: onUpdateProfile,
                child: Text(
                  'Updates',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
