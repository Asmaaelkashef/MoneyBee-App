import 'package:MoneyBee/Pages/Login_Screen.dart';
import 'package:MoneyBee/Services/API_Service.dart';
import 'package:MoneyBee/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedCurrency = "USD";
  bool isDarkMode = false;
  double? usdToEgp;
  bool isLoadingRate = false;
  String? lastUpdated;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchRate() async {
    setState(() => isLoadingRate = true);

    try {
      final result = await ExchangeRateService.fetchRate();

      setState(() {
        usdToEgp = result.rate;
        lastUpdated = result.updatedAt;
      });
    } catch (e) {
      print('Error fetching rate: $e');
    } finally {
      if (mounted) {
        setState(() => isLoadingRate = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Profile Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: SecondaryColor),
                  title: Text(
                    user?.displayName ?? 'User',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    user?.email ?? '',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: SecondaryColor,
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.security, color: SecondaryColor),
                  title: Text(
                    "Account Security",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    "Two-factor authentication",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: SecondaryColor,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Currency Selection',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 238, 219, 245),
                    child: Text(
                      "USD",
                      style:GoogleFonts.poppins(color: PrimaryColor, fontSize: 14),
                    ),
                  ),
                  title: Text(
                    "United States Dollar",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400 , fontSize: 14),
                  ),
                  subtitle: Text(
                    "ACTIVE CURRENCY",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: ThirdColor,
                    ),
                  ),
                  trailing: Radio(
                    value: "USD",
                    groupValue: selectedCurrency,
                    activeColor: SecondaryColor,
                    onChanged: (value) =>
                        setState(() => selectedCurrency = value!),
                  ),
                ),

                if (selectedCurrency == "USD")
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: isLoadingRate
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "EXCHANGE RATE INFO",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        lastUpdated != null
                                            ? "Updated: $lastUpdated"
                                            : "",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: _fetchRate,
                                        child: const Icon(
                                          Icons.refresh,
                                          size: 16,
                                          color: PrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Text(
                                  usdToEgp != null
                                      ? "USD / EGP   ${usdToEgp!.toStringAsFixed(2)}"
                                      : "USD / EGP   --",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'General Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.language, color: SecondaryColor),
                  title: Text("Language", style: GoogleFonts.poppins()),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const Divider(),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: SecondaryColor),
                  title: Text("Dark Mode", style: GoogleFonts.poppins()),
                  value: isDarkMode,
                  onChanged: (value) => setState(() => isDarkMode = value),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: PrimaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: Text("Logout", style: GoogleFonts.poppins()),
            onPressed: _showLogoutDialog,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:const Color.fromARGB(255, 247, 235, 252),
        title:Text("Logout" , style: GoogleFonts.poppins(fontWeight: FontWeight.bold)) ,
        content: Text("Are you sure you want to logout?" , style: GoogleFonts.poppins()) ,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel" , style: GoogleFonts.poppins(color: Colors.grey)) ,
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Login()),
                (route) => false,
              );
            },
            child: Text("Logout", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
