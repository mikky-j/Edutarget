import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_edutarget/constants/const.dart';
import 'package:new_edutarget/models/shared_prefrences_helper.dart';
import 'package:new_edutarget/models/theme_notifier.dart';
import 'package:new_edutarget/models/user.dart' as localUser;
import 'package:new_edutarget/pages/complete_account_page.dart';
import 'package:new_edutarget/pages/upgrade_page.dart';
import 'package:new_edutarget/widgets/change_password_page.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  void _showDialog(BuildContext context, Widget widget) {
    showDialog(
      context: context,
      builder: (context) {
        return widget;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context).textTheme.headline4,
                ),
                columnPadding,
                UpgradeBanner(
                  backgroundColor: Colors.yellow,
                ),
                columnPadding,
                SettingsHeading(heading: "General"),
                DarkModeSettingsTile(),
                ListTile(
                  onTap: () => _showDialog(context, ColorDialog()),
                  title: Text("Theme Color"),
                ),
                BasicSettingListTile(
                  title: "Notifications",
                ),
                ListTile(
                  title: Text("Reset all Courses"),
                  onTap: () => _showDialog(
                    context,
                    AlertDialog(
                      title: Text("Reset all Your Courses"),
                      content: Text(
                          "Are you sure you want to reset all the progress in your courses"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            print("reset");
                            Navigator.pop(context);
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  ),
                ),
                columnPadding,
                SettingsHeading(heading: "Account"),
                ListTile(
                  title: Text("Edit your Account"),
                  onTap: () => Navigator.push(
                    context,
                    customTransition(
                      CompleteAccountPage(
                        edit: true,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Change your Password"),
                  onTap: () => Navigator.of(context).push(
                    customTransition(ChangePasswordPage(forgot: false)),
                  ),
                ),
                ListTile(
                  title: Text("Connected Accounts"),
                ),
                ListTile(
                  title: Text("Terms and Conditions"),
                ),
                ListTile(
                  title: Text("Sign out"),
                  onTap: () => _showDialog(context, SignOutDialog()),
                ),
                BasicSettingListTile(
                  title: "Show primary color Saved",
                  onChanged: (value) async {
                    String color = await SharedPreferencesHelper()
                        .readString("color-value");
                    print(color);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BasicSettingListTile extends StatefulWidget {
  final String title;
  final void Function(bool value) onChanged;
  const BasicSettingListTile({
    Key key,
    this.title,
    this.onChanged,
  }) : super(key: key);

  @override
  _BasicSettingListTileState createState() => _BasicSettingListTileState();
}

class _BasicSettingListTileState extends State<BasicSettingListTile> {
  bool _toggled = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(widget.title),
      value: _toggled,
      activeColor: colors[Provider.of<ThemeNotifier>(context).colorIndex],
      onChanged: (value) {
        setState(() {
          _toggled = value;
        });
        if (widget.onChanged != null) widget.onChanged(value);
      },
    );
  }
}

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<localUser.User>(
      builder: (context, user, child) => AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          Consumer<ThemeNotifier>(
            builder: (context, theme, child) => TextButton(
              onPressed: () async {
                user.signOut();
                theme.theme = ThemeMode.dark;
                theme.colorIndex = "purple";
                await SharedPreferencesHelper()
                    .saveString("color-value", "purple");
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text("Yes"),
            ),
          ),
        ],
      ),
    );
  }
}

class DarkModeSettingsTile extends StatefulWidget {
  const DarkModeSettingsTile({
    Key key,
  }) : super(key: key);

  @override
  _DarkModeSettingsTileState createState() => _DarkModeSettingsTileState();
}

class _DarkModeSettingsTileState extends State<DarkModeSettingsTile> {
  bool _dark = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) {
        _dark = (theme.theme == ThemeMode.dark);
        return SwitchListTile.adaptive(
          value: _dark,
          activeColor: Theme.of(context).primaryColor,
          title: Text("Dark Mode"),
          onChanged: (val) {
            setState(() {
              _dark = val;
            });
            theme.theme = _dark ? ThemeMode.dark : ThemeMode.light;
          },
          controlAffinity: ListTileControlAffinity.platform,
        );
      },
    );
  }
}

class ColorDialog extends StatefulWidget {
  ColorDialog({
    Key key,
  }) : super(key: key);

  @override
  _ColorDialogState createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  int activeIndex = 0;

  final prefsInstance = SharedPreferencesHelper();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, value, child) {
      activeIndex = colorKeys.indexOf(value.colorIndex);
      return AlertDialog(
        title: Text("Pick a Primary Color"),
        content: Wrap(
          spacing: 20.0,
          runSpacing: 20.0,
          children: List.generate(
            colors.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    value.colorIndex = colorKeys[index];
                  });
                },
                child: ColorContainer(
                  active: (index == activeIndex),
                  color: colors[colorKeys[index]],
                ),
              );
            },
          ),
        ),
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, theme, child) => TextButton(
              onPressed: () async {
                theme.primaryColor = colors[colorKeys[activeIndex]];
                await prefsInstance.saveString(
                    "color-value", colorKeys[activeIndex]);
                Navigator.pop(context);
              },
              child: Text(
                "Done",
                style: TextStyle(
                  color: colors[theme.colorIndex],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}

class ColorContainer extends StatelessWidget {
  final Color color;
  final bool active;
  const ColorContainer({
    Key key,
    this.color,
    this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: active
          ? Container(
              child: Icon(Icons.check),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            )
          : SizedBox(),
    );
  }
}

class UpgradeBanner extends StatelessWidget {
  final Color backgroundColor;
  const UpgradeBanner({Key key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => UpgradePage(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        color: backgroundColor ?? Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: Text(
          "Upgrade to the Premuim Plan today",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class SettingsHeading extends StatelessWidget {
  final String heading;
  const SettingsHeading({Key key, this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headline6,
            ),
            Divider(),
          ],
        ));
  }
}
