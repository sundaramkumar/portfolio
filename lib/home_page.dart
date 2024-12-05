import 'package:flutter/material.dart';
import '../constants/fonts.dart';
import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../constants/assets.dart';
// import './utils/screen/screen_utils.dart';
import './widgets/responsive_widget.dart';
import 'models/experience.dart';
import 'utils/utils.dart';
import './widgets/bullet_widget.dart';

final Color themeColor = Color(0xFFF7D86A);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 5), // padding on left & right
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppbar(context),
        drawer: _buildDrawer(context),
        body: LayoutBuilder(builder: (context, constraints) {
          return _buildBody(context, constraints);
        }),
      ),
    ));
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: RichText(
          text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
            TextSpan(text: "${Strings.firstName} ", style: TextStyles.logo),
            TextSpan(
              text: Strings.lastName,
              style: TextStyles.logo.copyWith(
                color: const Color(0xFF50AFC0),
              ),
            ),
          ])),
      backgroundColor: Colors.transparent,
    );
  }

  Widget? _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: _buildActions(),
            ),
          )
        : null;
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menuHome,
          style: TextStyles.menuItem.copyWith(
            color: const Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menuAbout,
          style: TextStyles.menuItem,
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menuContact,
          style: TextStyles.menuItem,
        ),
        onPressed: () {
          Utils.getInstance().launchURL('mailto:${Strings.contactEmail}');
        },
      ),
    ];
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(flex: 1, child: _buildIllustration(context)),
                  Expanded(flex: 1, child: _buildContent(context)),
                ],
              )),
              _buildFooter(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0.0),
        _buildAboutMe(context),
        const SizedBox(height: 4.0),
        _buildHeadline(context),
        const SizedBox(height: 24.0),
        _buildSummary(),
        const SizedBox(height: 48.0),
        _buildSillsAndExperience(context),
      ],
    );
  }

  Widget _buildIllustration(context) {
    return Column(
      children: [
        Image.network(
          Assets.programmer3,
          color: Colors.transparent,
          colorBlendMode: BlendMode.darken,
          // height: ScreenUtil.getInstance().setWidth(345), //480.0
        ),
        RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),

            children: <TextSpan>[
              TextSpan(
                text: "A Flutter WebApp ",
                style: TextStyles.heading.copyWith(
                  fontFamily: Fonts.nexaLight,
                  color: const Color(0xFF50AFC0),
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
                ),
              ),
              TextSpan(
                text: "for My PortFolio",
                style: TextStyles.heading.copyWith(
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _buildCopyRightText(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _buildSocialIcons(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return Row(children: [
      Image.network(
        Assets.kumar,
        height: 50.0,
        width: 50.0,
      ),
      RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),

          children: <TextSpan>[
            TextSpan(
              text: Strings.about,
              style: TextStyles.heading.copyWith(
                fontFamily: Fonts.nexaLight,
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
              ),
            ),
            TextSpan(
              text: Strings.me,
              style: TextStyles.heading.copyWith(
                color: const Color(0xFF50AFC0),
                fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildHeadline(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              ResponsiveWidget.isSmallScreen(context)
                  ? Strings.headline
                  : Strings.headline.replaceFirst(RegExp(r' f'), '\nf'),
              style: TextStyles.subHeading,
            )),
        const SizedBox(width: 40.0),
        Expanded(flex: 1, child: _buildContactSection(context)),
      ],
    );
  }

  Widget _buildContactSection(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0.0),
        _buildContactPhone(context),
        // const SizedBox(height: 10.0),
        _buildContactEmail(context),
      ],
    );
  }

  Widget _buildContactPhone(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Utils.getInstance().launchURL('tel:${Strings.contactPhone}');
        },
        child: RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black,
            ),

            children: <TextSpan>[
              TextSpan(
                text: Strings.phone,
                style: TextStyles.body1.copyWith(
                  fontFamily: Fonts.nexaLight,
                  fontSize: 15.0,
                  color: const Color(0xFF50AFC0),
                ),
              ),
              TextSpan(
                text: Strings.contactPhone,
                style: TextStyles.body1.copyWith(
                  fontFamily: Fonts.nexaLight,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildContactEmail(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.getInstance().launchURL('mailto:${Strings.contactEmail}');
      },
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: const TextStyle(
            fontSize: 10.0,
            color: Colors.black,
          ),

          children: [
            TextSpan(
              text: Strings.email,
              style: TextStyles.body1.copyWith(
                color: const Color(0xFF50AFC0),
                fontSize: 15.0,
              ),
            ),
            TextSpan(
              text: Strings.contactEmail,
              style: TextStyles.body1.copyWith(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildCareerSummaryContainerHeading(),
        ),
        const SizedBox(width: 40.0),
        Expanded(flex: 1, child: _buildCareerSummary()),
      ],
    );
  }

  Widget _buildCareerSummaryContainerHeading() {
    return Text(
      Strings.careerSummary,
      style: TextStyles.body,
    );
  }

  Widget _buildCareerSummary() {
    return Text(
      Strings.careerSummary2,
      style: TextStyles.body,
    );
  }

  Widget _buildSillsAndExperience(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildExperience(),
        ),
        const SizedBox(width: 40.0),
        Expanded(flex: 1, child: _buildSkills(context)),
      ],
    );
  }

  Widget _buildExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildExperienceContainerHeading(),
        _buildExperienceSummary(),
        const SizedBox(height: 8.0),
        _buildExperienceTimeline(),
      ],
    );
  }

  Widget _buildExperienceContainerHeading() {
    return Row(children: [
      Image.network(
        Assets.experience,
        height: 25.0,
        width: 25.0,
      ),
      Text(Strings.experience, style: TextStyles.subHeading),
    ]);
  }

  Widget _buildExperienceSummary() {
    return Text(
      Strings.experieneSummary,
      style: TextStyles.body,
    );
  }

  Widget _buildExperienceTimeline() {
    final List<Widget> widgets = workingExperienceList
        .map((experience) => _buildExperienceTile(experience))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildExperienceTile(Experience experience) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            experience.post,
            style: TextStyles.company,
          ),
          Text(
            experience.organization,
            style: TextStyles.body.copyWith(
              color: const Color(0xFF45405B),
            ),
          ),
          Text(
            '${experience.from}-${experience.to}',
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    final List<Widget> widgets = skills
        .map((skill) => Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: _buildSkillChip(context, skill),
            ))
        .toList();

    final List<Widget> certs = certifications
        .map((skill) => Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              child: _buildCertChip(context, skill),
            ))
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSkillsContainerHeading(context),
        Wrap(children: widgets),
        const SizedBox(height: 20),
        _buildCertificationsContainerHeading(context),
        Wrap(children: certs),
//        _buildNavigationArrows(),
      ],
    );
  }

  Widget _buildSkillsContainerHeading(BuildContext context) {
    return Row(children: [
      Image.network(
        Assets.skill,
        height: 25.0,
        width: 25.0,
      ),
      Text(Strings.skillsIHave, style: TextStyles.subHeading),
    ]);
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      elevation: 5,
      backgroundColor: Colors.blue[100],
      label: Text(
        label,
        style: TextStyles.chip.copyWith(fontSize: 11.0),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xffE7E8EC)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      shadowColor: const Color.fromARGB(255, 177, 175, 175),
    );
  }

  Widget _buildCertChip(BuildContext context, String label) {
    return Chip(
      elevation: 5,
      backgroundColor: Colors.blueGrey,
      label: Text(
        label,
        style: TextStyles.certChip.copyWith(fontSize: 11.0),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Color(0xffE7E8EC)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      shadowColor: const Color.fromARGB(255, 177, 175, 175),
    );
  }

  // certifications
  Widget _buildCertificationsContainerHeading(BuildContext context) {
    return Row(children: [
      Image.network(
        Assets.certificate,
        height: 25.0,
        width: 25.0,
      ),
      const SizedBox(width: 10),
      Text(Strings.certificationsIHave, style: TextStyles.subHeading),
    ]);
  }
}

Widget _buildCopyRightText(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Utils.getInstance().launchURL(Strings.website);
    },
    child: Text(
      Strings.rightsReserved,
      style: TextStyles.footer.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 12.0,
          color: const Color(0xFF50AFC0)),
    ),
  );
}

Widget _buildSocialIcons() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          Utils.getInstance().launchURL(Strings.linkedIn);
        },
        child: Image.network(
          Assets.linkedin,
          color: const Color(0xFF45405B),
          height: 20.0,
          width: 20.0,
        ),
      ),
      const SizedBox(width: 16.0),
      GestureDetector(
        onTap: () {
          Utils.getInstance().launchURL('mailto:${Strings.contactEmail}');
        },
        child: Image.network(
          Assets.mail,
          color: const Color(0xFF45405B),
          height: 20.0,
          width: 20.0,
        ),
      ),
      const SizedBox(width: 16.0),
      GestureDetector(
        onTap: () {
          Utils.getInstance().launchURL(Strings.gitHub);
        },
        child: Image.network(
          Assets.github,
          color: const Color(0xFF45405B),
          height: 20.0,
          width: 20.0,
        ),
      ),
      const SizedBox(width: 16.0),
      GestureDetector(
        onTap: () {
          Utils.getInstance().launchURL(Strings.twitter);
        },
        child: Image.network(
          Assets.twitter,
          color: const Color(0xFF45405B),
          height: 20.0,
          width: 20.0,
        ),
      ),
    ],
  );
}
