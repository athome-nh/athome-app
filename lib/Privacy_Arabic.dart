import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';

class PrivacyScreen_AR extends StatefulWidget {
  const PrivacyScreen_AR({super.key});

  @override
  State<PrivacyScreen_AR> createState() => _PrivacyScreen_ARState();
}

class _PrivacyScreen_ARState extends State<PrivacyScreen_AR> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('سياسة الخصوصية'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سياسة الخصوصية لتطبيق دلی لاس للبقالة',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'تاريخ النفاذ: 24/12/2023',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '1. المقدمة\n'
                  'مرحبًا بك في دلی لاس، تطبيق البقالة الموثوق به! تم تصميم هذه السياسة الخصوصية لمساعدتك في فهم '
                  'كيفية جمعنا واستخدمنا وحمينا معلوماتك الشخصية عند استخدام تطبيقنا الجوال. '
                  'من خلال تحميل أو تثبيت أو استخدام تطبيق دلی لاس، فإنك توافق على الممارسات الموصوفة في هذه السياسة الخصوصية.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '2. المعلومات التي نجمعها\n'
                  'لتوفير أفضل تجربة للتسوق من البقالة، نقوم بجمع البيانات التالية عند إنشاء حساب:\n'
                  'الاسم: لتخصيص تجربتك ومعالجتك بشكل مناسب.\n'
                  'المدينة: للمساعدة في اختيار موقع التوصيل.\n'
                  'العمر والجنس: لفهم أفضل لديموغرافية المستخدمين وتخصيص خدماتنا وفقًا لذلك.\n'
                  'نوع هاتفك الجوال: لحل جميع الأخطاء التي نواجهها من جميع الأجهزة',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '3. الأذونات\n'
                  'الموقع: نطلب الوصول إلى موقع جهازك لمساعدتك في اختيار موقع التوصيل بدقة وتوفير خدمة توصيل فعّالة لك.\n'
                  'التخزين: نطلب الإذن للوصول إلى تخزين جهازك لتحميل وتخزين صورة ملفك الشخصي، مما يعزز تجربتك المخصصة.\n'
                  'الإشعار: نطلب إذنًا لإرسال إشعارات لك تتعلق بتحديثات الطلب، والعروض الترويجية، والمعلومات الهامة.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '4. استخدام المعلومات\n'
                  'نستخدم المعلومات التي تم جمعها لتحقيق الأغراض التالية:\n'
                  '• إنشاء وإدارة حسابك.\n'
                  '• تيسير معالجة الطلب والتسليم.\n'
                  '• تخصيص تجربتك.\n'
                  '• إرسال إشعارات وتحديثات ذات صلة.\n'
                  '• تحسين خدماتنا وتلبية تفضيلات المستخدمين.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '5. إلغاء الطلب\n'
                  'لدى المستخدمين الحق في إلغاء طلباتهم قبل بدء عملية اختيار الطلب. بمجرد بدء عملية الاختيار، قد لا يكون '
                  'الإلغاء ممكنًا. يمكن للمستخدمين بدء عملية الإلغاء من خلال التطبيق.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '6. أمان البيانات\n'
                  'نعتبر أمان معلوماتك أمرًا مهمًا. نقوم بتنفيذ إجراءات أمان قياسية في الصناعة لحماية ضد الوصول غير المصرح به، '
                  'أو التغيير، أو الكشف، أو تدمير بياناتك الشخصية.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '7. الخدمات من جهات خارجية\n'
                  'قد نستعين بخدمات من جهات خارجية للتحليلات ومعالجة الدفع والتوصيل. هذه الكيانات ملزمة بحماية معلوماتك والالتزام '
                  'بقوانين حماية البيانات ذات الصلة.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '8. التغييرات في سياسة الخصوصية\n'
                  'نحتفظ بحقنا في تحديث سياسة الخصوصية لتعكس التغييرات في ممارساتنا. سيتم إشعار المستخدمين بأي تغييرات كبيرة. '
                  'يُفضل مراجعة سياسة الخصوصية بشكل دوري.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  '9. اتصل بنا\n'
                  'إذا كان لديك أي أسئلة أو مخاوف أو تعليقات بخصوص سياسة الخصوصية لدينا، يرجى الاتصال بنا على '
                  '[info@dllylas.com].\n'
                  'شكرًا لاختيارك دلی لاس لاحتياجاتك من البقالة!',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
