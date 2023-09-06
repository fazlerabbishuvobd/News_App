import 'package:english_news_app/model/category_model.dart';
import 'package:english_news_app/resources/assets/app_icons_name.dart';

class AppConstant {
  static const String news = '''World leaders from around the globe have converged in New York City for the 78th annual United Nations General Assembly (UNGA) meeting, a pivotal event on the international diplomatic calendar. This year's UNGA comes amidst a backdrop of ongoing global challenges, including the COVID-19 pandemic, climate change, and regional conflicts, prompting urgent discussions on a wide range of pressing issues.
The UNGA's opening session featured speeches from numerous heads of state, each highlighting their nation's priorities and concerns. United States President, in his address, underscored the importance of multilateral cooperation in addressing global challenges. He announced new commitments to combat climate change and reaffirmed the U.S. commitment to human rights and democracy.
Russian President, in a somewhat conciliatory tone, expressed willingness to engage in dialogue with Western nations, emphasizing the need for international stability and cooperation. This signaled a potential thaw in relations strained by recent geopolitical tensions.
China's President delivered a speech centered on economic development, advocating for a multipolar world and economic globalization. He announced China's intention to contribute to global vaccine distribution efforts and promote sustainable development.
The Iranian President, in a passionate address, called for a revitalized nuclear agreement and the lifting of sanctions. He emphasized the importance of diplomacy and peaceful resolution of conflicts in the Middle East.
Climate change took center stage during the UNGA, with numerous leaders pledging to take more significant actions to combat the climate crisis. The Secretary-General of the United Nations urged countries to accelerate their emissions reduction efforts and provide support to vulnerable nations grappling with climate-related challenges.
In a landmark development, several nations announced their commitment to a global carbon pricing mechanism to incentivize emissions reduction. This initiative aims to establish a fair and effective way to curb greenhouse gas emissions and drive the transition to a sustainable, low-carbon economy.
The ongoing COVID-19 pandemic remained a top priority, with leaders discussing vaccine equity, access, and distribution. Calls for vaccine donations to poorer nations resonated throughout the assembly, highlighting the ongoing disparities in global healthcare.
Several regional conflicts also featured prominently in discussions. The situation in Afghanistan drew significant attention, with leaders expressing concerns about human rights, humanitarian aid access, and the stability of the region. Calls for international engagement and support for the Afghan people were prevalent.
On the African continent, leaders discussed efforts to address conflicts in regions such as the Sahel and the Horn of Africa, emphasizing the need for conflict resolution, peacekeeping missions, and humanitarian assistance.
The UNGA also saw discussions on cybersecurity and the increasing threat of cyberattacks on critical infrastructure. Leaders stressed the importance of international norms and cooperation to combat cyber threats and protect national security.
Throughout the assembly, there were numerous bilateral meetings on the sidelines, showcasing diplomacy in action. Leaders engaged in discussions aimed at resolving bilateral disputes, strengthening trade relations, and advancing regional cooperation.
In conclusion, the 78th United Nations General Assembly brought together world leaders to address a wide array of global challenges, ranging from climate change and the COVID-19 pandemic to regional conflicts and cybersecurity. While the outcomes of the assembly will unfold in the coming months, the event served as a platform for dialogue and cooperation on critical issues that impact the world's future. As leaders return to their respective nations, the international community watches closely to see how these discussions will translate into concrete actions and progress on the world stage.
 ''';

  static List<CategoryModel> categoryList = [
    CategoryModel(categoryName: "Business", categoryImage: AppIconsName.business),
    CategoryModel(categoryName: "Entertainment", categoryImage: AppIconsName.entertainment),
    CategoryModel(categoryName: "General", categoryImage: AppIconsName.general),
    CategoryModel(categoryName: "Health", categoryImage: AppIconsName.health),
    CategoryModel(categoryName: "Sciences", categoryImage: AppIconsName.science),
    CategoryModel(categoryName: "Sports", categoryImage: AppIconsName.sports),
    CategoryModel(categoryName: "Technology", categoryImage: AppIconsName.technology),
  ];

}
