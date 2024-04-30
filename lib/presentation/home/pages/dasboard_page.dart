import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_fic14/core/core.dart';
import 'package:resto_fic14/data/datasources/auth_local_datasource.dart';
import 'package:resto_fic14/data/models/response/auth_response_model.dart';
import 'package:resto_fic14/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:resto_fic14/presentation/auth/login_pages.dart';
import 'package:resto_fic14/presentation/settings/pages/sync_data_page.dart';

import '../widgets/nav_item.dart';
import 'home_page.dart';

class DasboardPage extends StatefulWidget {
  const DasboardPage({super.key});

  @override
  State<DasboardPage> createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DasboardPage> {
  User? user;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    // const Center(child: Text('This is page 1')),
    const Center(child: Text('This is page 2')),
    const Center(child: Text('This is page 3')),
    // const Center(child: Text('This is page 4')),
    // const Center(child: Text('This is page 5')),
    const SyncDataPage(),
    // const ManagePrinterPage(),
    // const SettingsPage(),
  ];
  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    // AuthLocalDataSource().getAuthData().then((value) => setState(() {
    //       user = value.user;
    //     }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(16.0)),
                child: SizedBox(
                  height: context.deviceHeight - 20.0,
                  child: ColoredBox(
                    color: AppColors.primary,
                    child: Column(
                      children: [
                        NavItem(
                          iconPath: Assets.icons.homeResto.path,
                          isActive: _selectedIndex == 0,
                          onTap: () => _onItemTapped(0),
                        ),
                        NavItem(
                          iconPath: Assets.icons.discount.path,
                          isActive: _selectedIndex == 1,
                          onTap: () => _onItemTapped(1),
                        ),
                        NavItem(
                          iconPath: Assets.icons.dashboard.path,
                          isActive: _selectedIndex == 2,
                          onTap: () => _onItemTapped(2),
                        ),
                        NavItem(
                          iconPath: Assets.icons.setting.path,
                          isActive: _selectedIndex == 3,
                          onTap: () => _onItemTapped(3),
                        ),
                        BlocListener<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: () {
                                AuthLocalDataSource().removeAuthData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Logout Success'),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginPage();
                                }), (route) => false);
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                  ),
                                );
                              },
                            );
                            // TODO: implement listener
                          },
                          child: NavItem(
                            iconPath: Assets.icons.logout.path,
                            isActive: false,
                            onTap: () {
                              context
                                  .read<LogoutBloc>()
                                  .add(const LogoutEvent.logout());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _pages[_selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
