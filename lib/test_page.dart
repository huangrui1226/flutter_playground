import 'package:flutter/material.dart';

void main() {
  runApp(const PTEFighterApp());
}

class PTEFighterApp extends StatelessWidget {
  const PTEFighterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PTE Fighter',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'PingFang SC',
      ),
      home: const PTEFighterLandingPage(),
    );
  }
}

class PTEFighterLandingPage extends StatelessWidget {
  const PTEFighterLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildHeroBanner(),
            _buildPTEIntroSection(),
            _buildWhyPTESection(),
            _buildPTEvsIELTSSection(),
            _buildPricingSection(),
            _buildTeamSection(),
            _buildFeatureCardsSection(),
            _buildLearningPathSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school, color: Colors.orange),
              ),
              const SizedBox(width: 10),
              const Text(
                'PTE FIGHTER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildNavItem('首页', true),
          _buildNavItem('备考', false),
          _buildNavItem('PTE题库', false),
          _buildNavItem('常见问题', false),
          _buildNavItem('关于我们', false),
          _buildNavItem('OG', false),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {},
            child: const Text('登录'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('注册'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: isActive ? Colors.orange : Colors.black87,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade300,
            Colors.orange.shade200,
            Colors.yellow.shade100,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Diagonal stripes pattern
          Positioned.fill(
            child: CustomPaint(
              painter: DiagonalStripesPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'PTEFIGHTER',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '搞懂PTE模板大全',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '扫码领取',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.qr_code,
                          size: 120,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Cartoon character placeholder
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sentiment_very_satisfied,
                        size: 80,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Decorative clouds
          Positioned(
            top: 30,
            right: 50,
            child: Icon(Icons.cloud, size: 60, color: Colors.white.withOpacity(0.5)),
          ),
          Positioned(
            top: 50,
            right: 150,
            child: Icon(Icons.cloud, size: 40, color: Colors.white.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildPTEIntroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const Text(
            'PTE机考流程',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '3种方法发达过考试，找着各国人名单报考技能才考试',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProcessCard(
                Icons.edit_note,
                '口语',
                'PTE口语部分考试时间',
                Colors.blue.shade100,
              ),
              _buildProcessCard(
                Icons.edit,
                '写作',
                'PTE写作部分考试时间',
                Colors.pink.shade100,
              ),
              _buildProcessCard(
                Icons.hearing,
                '听力',
                'PTE听力部分考试时间',
                Colors.purple.shade100,
              ),
              _buildProcessCard(
                Icons.menu_book,
                '阅读',
                'PTE阅读部分考试时间',
                Colors.orange.shade100,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProcessCard(IconData icon, String title, String description, Color color) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {},
            child: const Text('了解更多 →'),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyPTESection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PTE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const Text(
                ' 考试有什么',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                '优势？',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            children: [
              _buildAdvantageCard(
                Icons.speed,
                '超快速评定结果，1-2天出分',
                '通用考试最快出分，最快24小时内就能拿到成绩单。相比雅思的13个工作日，PTE大大缩短了等待时间。',
                Colors.blue,
              ),
              _buildAdvantageCard(
                Icons.computer,
                '纯机考',
                '全程采用电脑机考形式，避免人为主观因素影响，评分更加客观公正。',
                Colors.orange,
              ),
              _buildAdvantageCard(
                Icons.calendar_today,
                'PTE考试场次多，每周20场以上',
                '相比雅思，PTE考试场次更多，预约更灵活方便，考生可以根据自己的时间安排选择。',
                Colors.pink,
              ),
              _buildAdvantageCard(
                Icons.security,
                '全球认可度高，无黑名单风险',
                'PTE成绩被全球3000多所大学和机构认可，包括英国、澳大利亚、新西兰等国家的移民局。',
                Colors.purple,
              ),
              _buildAdvantageCard(
                Icons.auto_awesome,
                'PTE题型更加规律，易掌握技巧',
                'PTE题型相对固定，通过练习更容易掌握答题技巧和模板，提分效率更高。',
                Colors.green,
              ),
              _buildAdvantageCard(
                Icons.trending_up,
                '在澳洲和移民界认可度逐年提升',
                '近年来PTE在澳洲移民和留学申请中的认可度持续提升，成为越来越多考生的首选。',
                Colors.teal,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantageCard(IconData icon, String title, String description, Color color) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPTEvsIELTSSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'PTE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const Text(
                '  vs  ',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const Text(
                'IELTS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                _buildComparisonHeader(),
                _buildComparisonRow('考试形式', 'PTE: 纯机考', 'IELTS: 笔试+口试', true),
                _buildComparisonRow('考试时间', 'PTE: 约2-3小时', 'IELTS: 约2小时45分', false),
                _buildComparisonRow('出分时间', 'PTE: 1-2个工作日', 'IELTS: 13个工作日', true),
                _buildComparisonRow('考试场次', 'PTE: 每周20+场次', 'IELTS: 每月4场左右', false),
                _buildComparisonRow('评分方式', 'PTE: AI机器评分', 'IELTS: 人工评分', true),
                _buildComparisonRow('考试费用', 'PTE: ¥275左右', 'IELTS: ¥2170', false),
                _buildComparisonRow('成绩有效期', 'PTE: 2年', 'IELTS: 2年', true),
                _buildComparisonRow('全球认可', 'PTE: 3000+所院校', 'IELTS: 10000+所院校', false),
                _buildComparisonRow('口语考试', 'PTE: 对着电脑说', 'IELTS: 真人考官面试', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonHeader() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                '对比项目',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.orange.shade50,
              child: const Center(
                child: Text(
                  'PTE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue.shade50,
              child: const Center(
                child: Text(
                  'IELTS',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String category, String pte, String ielts, bool isOdd) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isOdd ? Colors.white : Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Center(
                child: Text(
                  pte.replaceAll('PTE: ', ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Center(
                child: Text(
                  ielts.replaceAll('IELTS: ', ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text(
            'PTE考试套餐',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '选择适合你的学习方案，快速提升PTE成绩',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _buildPricingCard(
                '基础版',
                '¥1,999',
                [
                  '30天有效期',
                  'PTE全题型练习',
                  '在线题库访问',
                  '基础答疑支持',
                  '学习进度跟踪',
                ],
                Colors.blue,
                false,
              ),
              _buildPricingCard(
                '进阶版',
                '¥3,999',
                [
                  '60天有效期',
                  'PTE全题型练习',
                  '在线题库访问',
                  '1对1答疑辅导',
                  '模拟考试3次',
                  'AI智能批改',
                  '学习进度跟踪',
                ],
                Colors.green,
                true,
              ),
              _buildPricingCard(
                '高分冲刺版',
                '¥5,999',
                [
                  '90天有效期',
                  'PTE全题型练习',
                  '无限题库访问',
                  '专属1对1辅导',
                  '模拟考试无限次',
                  'AI智能批改',
                  '专属学习规划',
                  '考前冲刺课程',
                ],
                Colors.orange,
                false,
              ),
              _buildPricingCard(
                'VIP保分版',
                '¥9,999',
                [
                  '180天有效期',
                  'PTE全题型练习',
                  '无限题库访问',
                  'VIP 1对1辅导',
                  '模拟考试无限次',
                  'AI智能批改',
                  '专属学习规划',
                  '考前冲刺课程',
                  '保分承诺',
                  '不过重修',
                ],
                Colors.red,
                false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingCard(String title, String price, List<String> features, Color color, bool isRecommended) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isRecommended ? Border.all(color: color, width: 3) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isRecommended ? 0.15 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isRecommended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '推荐',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price.split(',')[0],
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              if (price.contains(','))
                Text(
                  ',${price.split(',')[1]}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 25),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 20, color: color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '立即购买',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const Text(
            '名师团队',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 60),
          // Founder card
          Container(
            width: 600,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Johnny Wu',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '创始人兼首席讲师，拥有8分+',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '澳洲麦考瑞大学金融硕士，7年PTE教学经验。帮助超过3000名学生成功通过PTE考试，其中80%的学生在3个月内达到目标分数。擅长口语和写作板块教学，独创"模板记忆法"深受学生好评。',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Teacher cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildTeacherCard('Lisa Chen', '口语讲师', Icons.person),
              _buildTeacherCard('Michael Lee', '写作讲师', Icons.person_outline),
              _buildTeacherCard('Sarah Wang', '听力讲师', Icons.person),
              _buildTeacherCard('David Zhang', '阅读讲师', Icons.person_outline),
              _buildTeacherCard('Emma Liu', '助教', Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherCard(String name, String role, IconData icon) {
    return Container(
      width: 150,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 50, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            role,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCardsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.grey.shade50,
      child: Column(
        children: [
          const Text(
            '发展历程评估',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureCircleCard(
                '在线题库',
                '海量真题题库\n随时随地练习',
                Colors.orange.shade100,
                Icons.library_books,
              ),
              const SizedBox(width: 40),
              _buildFeatureCircleCard(
                '一对一辅导',
                '专业老师指导\n针对性提升',
                Colors.pink.shade100,
                Icons.person,
              ),
              const SizedBox(width: 40),
              _buildFeatureCircleCard(
                '高效测试',
                '模拟真实考试\n检验学习成果',
                Colors.blue.shade100,
                Icons.assessment,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCircleCard(String title, String description, Color color, IconData icon) {
    return Container(
      width: 220,
      child: Column(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: Colors.black87),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPathSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Column(
        children: [
          const Text(
            '学习交流',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPathCard(
                '线下回忆',
                '考场真题回忆\n最新考题分享',
                Colors.orange.shade100,
                Icons.assignment,
              ),
              const SizedBox(width: 15),
              Icon(Icons.arrow_forward, size: 40, color: Colors.grey.shade400),
              const SizedBox(width: 15),
              _buildPathCard(
                '口语',
                '口语练习技巧\n发音矫正训练',
                Colors.pink.shade100,
                Icons.mic,
              ),
              const SizedBox(width: 15),
              Icon(Icons.arrow_forward, size: 40, color: Colors.grey.shade400),
              const SizedBox(width: 15),
              _buildPathCard(
                '听力',
                '听力提升训练\n真题精听精练',
                Colors.blue.shade100,
                Icons.headphones,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPathCard(String title, String description, Color color, IconData icon) {
    return Container(
      width: 280,
      height: 180,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.black87),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '关于我们',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFooterLink('公司简介'),
                  _buildFooterLink('联系我们'),
                  _buildFooterLink('加入我们'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PTE题库',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFooterLink('口语题库'),
                  _buildFooterLink('写作题库'),
                  _buildFooterLink('听力题库'),
                  _buildFooterLink('阅读题库'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '在线服务',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFooterLink('在线题库'),
                  _buildFooterLink('模拟考试'),
                  _buildFooterLink('一对一辅导'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PTE机经',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFooterLink('最新机经'),
                  _buildFooterLink('高频题目'),
                  _buildFooterLink('考场回忆'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '联系方式',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFooterLink('客服微信'),
                  _buildFooterLink('QQ群'),
                  _buildFooterLink('官方邮箱'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.grey.shade700),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.school, color: Colors.orange),
              ),
              const SizedBox(width: 10),
              const Text(
                'PTE FIGHTER',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'ICP 证书号: XXX-XXXX-XXXX-XXX  |  电话: 187-8888-8888  |  地址: XXX省XXX市XXX区XXX号',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, size: 80),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, size: 80),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.qr_code, size: 80),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}

class DiagonalStripesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange.shade400.withOpacity(0.3)
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke;

    const spacing = 60.0;
    for (double i = -size.height; i < size.width + size.height; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
