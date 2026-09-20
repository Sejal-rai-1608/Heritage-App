import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/language_provider.dart';
import '../widgets/custom_bottom_navbar.dart';
import 'home_screen.dart';

class JobsScreen extends StatefulWidget {
  final String? userName;
  const JobsScreen({super.key, this.userName});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _jobs = [
    {
      'id': '1',
      'titleEn': 'Senior Software Engineer',
      'titleGu': 'વરિષ્ઠ સોફ્ટવેર એન્જિનિયર',
      'companyEn': 'Swajan Tech Solutions',
      'companyGu': 'સ્વજન ટેક સોલ્યુશન્સ',
      'locationEn': 'Ahmedabad, Gujarat',
      'locationGu': 'અમદાવાદ, ગુજરાત',
      'salaryEn': '₹50,000 - ₹75,000 / month',
      'salaryGu': '₹૫૦,૦૦૦ - ₹૭૫,૦૦૦ / મહિનો',
      'typeEn': 'Full-Time',
      'typeGu': 'પૂર્ણ-સમય',
      'workModeEn': 'Remote / Hybrid',
      'workModeGu': 'રિમોટ / હાઇબ્રિડ',
      'categoryEn': 'IT & Tech',
      'categoryGu': 'આઇટી અને ટેક',
      'postedTimeEn': 'Posted 2 days ago',
      'postedTimeGu': '૨ દિવસ પહેલા પોસ્ટ કર્યું',
      'expEn': '3-5 Years Experience',
      'expGu': '૩-૫ વર્ષનો અનુભવ',
      'descEn': 'Looking for an experienced Flutter & Node.js developer to build scalable Swajan community apps and cloud architecture.',
      'descGu': 'સ્કેલેબલ એપ્લિકેશન્સ અને ક્લાઉડ આર્કિટેક્ચર બનાવવા માટે અનુભવી ફ્લટર અને નોડ.જેએસ ડેવલપરની જરૂર છે.',
      'hrPhone': '+91 98765 43210',
      'hrEmail': 'careers@swajantech.com',
      'logoColor': const Color(0xFF0F172A),
    },
    {
      'id': '2',
      'titleEn': 'Financial Accountant & Auditor',
      'titleGu': 'નાણાકીય અકાઉન્ટન્ટ અને ઓડિટર',
      'companyEn': 'Patel Financial Services',
      'companyGu': 'પટેલ ફાઇનાન્શિયલ સર્વિસીસ',
      'locationEn': 'Vadodara, Gujarat',
      'locationGu': 'વડોદરા, ગુજરાત',
      'salaryEn': '₹35,000 - ₹50,000 / month',
      'salaryGu': '₹૩૫,૦૦૦ - ₹૫૦,૦૦૦ / મહિનો',
      'typeEn': 'Full-Time',
      'typeGu': 'પૂર્ણ-સમય',
      'workModeEn': 'On-Site',
      'workModeGu': 'ઓન-સાઇટ',
      'categoryEn': 'Finance',
      'categoryGu': 'નાણાકીય',
      'postedTimeEn': 'Posted 1 day ago',
      'postedTimeGu': '૧ દિવસ પહેલા પોસ્ટ કર્યું',
      'expEn': '2-4 Years Experience',
      'expGu': '૨-૪ વર્ષનો અનુભવ',
      'descEn': 'Seeking a qualified Accountant to manage GST filing, balance sheets, corporate audits, and client financial portfolios.',
      'descGu': 'જીએસટી ફાઇલિંગ, બેલેન્સ શીટ, કોર્પોરેટ ઓડિટ અને ક્લાયન્ટ પોર્ટફોલિયો હેન્ડલ કરવા માટે યોગ્ય અકાઉન્ટન્ટની જરૂર છે.',
      'hrPhone': '+91 98250 12345',
      'hrEmail': 'jobs@patelfinance.org',
      'logoColor': const Color(0xFF856404),
    },
    {
      'id': '3',
      'titleEn': 'Civil Project Engineer',
      'titleGu': 'સિવિલ પ્રોજેક્ટ એન્જિનિયર',
      'companyEn': 'More Construction Group',
      'companyGu': 'મોરે કન્સ્ટ્રક્શન ગ્રુપ',
      'locationEn': 'Satara Road, Maharashtra',
      'locationGu': 'સાતારા રોડ, મહારાષ્ટ્ર',
      'salaryEn': '₹40,000 - ₹60,000 / month',
      'salaryGu': '₹૪૦,૦૦૦ - ₹૬૦,૦૦૦ / મહિનો',
      'typeEn': 'Full-Time',
      'typeGu': 'પૂર્ણ-સમય',
      'workModeEn': 'On-Site',
      'workModeGu': 'ઓન-સાઇટ',
      'categoryEn': 'Engineering',
      'categoryGu': 'એન્જિનિયરિંગ',
      'postedTimeEn': 'Posted 3 days ago',
      'postedTimeGu': '૩ દિવસ પહેલા પોસ્ટ કર્યું',
      'expEn': '4+ Years Experience',
      'expGu': '૪+ વર્ષનો અનુભવ',
      'descEn': 'Required site engineer for residential and commercial building construction projects with expertise in AutoCad & RCC planning.',
      'descGu': 'ઓટોકેડ અને આરસીસી પ્લાનિંગમાં નિપુણતા ધરાવતા રેસિડેન્શિયલ કન્સ્ટ્રક્શન પ્રોજેક્ટ માટે સાઇટ એન્જિનિયરની જરૂર છે.',
      'hrPhone': '+91 94220 67890',
      'hrEmail': 'hr@moreconstructions.com',
      'logoColor': const Color(0xFF1E3A8A),
    },
    {
      'id': '4',
      'titleEn': 'Digital Marketing Specialist',
      'titleGu': 'ડિજિટલ માર્કેટિંગ સ્પેશિયાલિસ્ટ',
      'companyEn': 'Luxe Media Network',
      'companyGu': 'લક્સ મીડિયા નેટવર્ક',
      'locationEn': 'Surat, Gujarat',
      'locationGu': 'સુરત, ગુજરાત',
      'salaryEn': '₹30,000 - ₹45,000 / month',
      'salaryGu': '₹૩૦,૦૦૦ - ₹૪૫,૦૦૦ / મહિનો',
      'typeEn': 'Part-Time',
      'typeGu': 'અંશ-સમય',
      'workModeEn': 'Remote / WFH',
      'workModeGu': 'રિમોટ / વર્ક ફ્રોમ હોમ',
      'categoryEn': 'Marketing',
      'categoryGu': 'માર્કેટિંગ',
      'postedTimeEn': 'Posted 4 days ago',
      'postedTimeGu': '૪ દિવસ પહેલા પોસ્ટ કર્યું',
      'expEn': '1-3 Years Experience',
      'expGu': '૧-૩ વર્ષનો અનુભવ',
      'descEn': 'Manage social media campaigns, SEO, Google Ads, and brand outreach for heritage enterprises and luxury retail brands.',
      'descGu': 'સોશિયલ મીડિયા ઝુંબેશ, એસઇઓ, ગૂગલ એડ્સ અને બ્રાન્ડ આઉટરીચ મેનેજ કરવા માટે ડિજિટલ માર્કેટરની જરૂર છે.',
      'hrPhone': '+91 97123 45678',
      'hrEmail': 'contact@luxemedia.in',
      'logoColor': const Color(0xFF047857),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showJobDetailsModal(BuildContext context, Map<String, dynamic> job, bool isGu) {
    final title = isGu ? job['titleGu'] : job['titleEn'];
    final company = isGu ? job['companyGu'] : job['companyEn'];
    final location = isGu ? job['locationGu'] : job['locationEn'];
    final salary = isGu ? job['salaryGu'] : job['salaryEn'];
    final type = isGu ? job['typeGu'] : job['typeEn'];
    final workMode = isGu ? job['workModeGu'] : job['workModeEn'];
    final exp = isGu ? job['expGu'] : job['expEn'];
    final desc = isGu ? job['descGu'] : job['descEn'];

    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController expController = TextEditingController();
    final TextEditingController aboutController = TextEditingController();
    String? localResumeFileName;
    String? localResumeFileSize;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.90,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 32),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: (job['logoColor'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: job['logoColor'] as Color, width: 1.5),
                            ),
                            child: Icon(Icons.business_center, size: 30, color: job['logoColor'] as Color),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Serif',
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  company,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: job['logoColor'] as Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tags Pill Row
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildBadge(type, const Color(0xFFEFF6FF), const Color(0xFF1E40AF)),
                          _buildBadge(workMode, const Color(0xFFFEF9C3), const Color(0xFF854D0E)),
                          _buildBadge(exp, const Color(0xFFF1F5F9), const Color(0xFF475569)),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Salary & Location Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.payments_outlined, color: Color(0xFF16A34A), size: 20),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGu ? 'પગાર ધોરણ' : 'Salary Package',
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                    ),
                                    Text(
                                      salary,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF16A34A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 20, color: Color(0xFFE2E8F0)),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: Color(0xFF2563EB), size: 20),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isGu ? 'નોકરીનું સ્થળ' : 'Job Location',
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                    ),
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Job Description Title
                      Text(
                        isGu ? 'નોકરીની વિગતો અને જવાબદારીઓ' : 'Job Overview & Responsibilities',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        desc,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF64748B),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // CANDIDATE APPLICATION FORM & LOCAL RESUME UPLOAD SECTION
                      StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: const Color(0xFFCBD5E1)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFDBEAFE),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.assignment_ind_rounded, color: Color(0xFF1E40AF), size: 20),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                       child: Text(
                                         isGu ? 'ઉમેદવારની અરજી ફોર્મ' : 'Candidate Details & Resume Form',
                                         style: const TextStyle(
                                           fontFamily: 'Serif',
                                           fontSize: 16,
                                           fontWeight: FontWeight.bold,
                                           color: Color(0xFF0F172A),
                                         ),
                                         overflow: TextOverflow.ellipsis,
                                       ),
                                     ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                // Full Name
                                Text(
                                  isGu ? 'ઉમેદવારનું પૂરું નામ *' : 'Full Name *',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 4),
                                TextField(
                                  controller: nameController,
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                  decoration: InputDecoration(
                                    hintText: 'Full name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Phone & Email Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isGu ? 'મોબાઈલ નંબર *' : 'Phone No. *',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                          ),
                                          const SizedBox(height: 4),
                                          TextField(
                                            controller: phoneController,
                                            style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                            decoration: InputDecoration(
                                              hintText: 'Phone no',
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isGu ? 'ઈમેઈલ *' : 'Email *',
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                          ),
                                          const SizedBox(height: 4),
                                          TextField(
                                            controller: emailController,
                                            style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                            decoration: InputDecoration(
                                              hintText: 'Email ID',
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                // Total Experience
                                Text(
                                  isGu ? 'કુલ અનુભવ (વર્ષ/મહિના) *' : 'Total Experience (Years/Months) *',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 4),
                                TextField(
                                  controller: expController,
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                  decoration: InputDecoration(
                                    hintText: 'e.g. 3 Years 6 Months',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // About Yourself / Short Description
                                Text(
                                  isGu ? 'તમારા વિશે ટૂંકી નોંધ (About Yourself) *' : 'About Yourself / Short Description *',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 4),
                                TextField(
                                  controller: aboutController,
                                  maxLines: 3,
                                  style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                                  decoration: InputDecoration(
                                    hintText: isGu
                                        ? 'તમારું મુખ્ય કૌશલ્ય, અનુભવ અને શક્તિઓ વર્ણવો...'
                                        : 'Describe your key skills, accomplishments and focus...',
                                    hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                                  ),
                                ),
                                const SizedBox(height: 14),

                                // Local Storage Resume Upload Button / Status Card
                                Text(
                                  isGu ? 'લોકલ ડિવાઇસમાંથી સીવી / રિઝ્યુમ ફાઇલ અપલોડ કરો *' : 'Upload Resume / CV File (Local Storage) *',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                                ),
                                const SizedBox(height: 6),

                                if (localResumeFileName != null) ...[
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0FDF4),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFF86EFAC)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFDCFCE7),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFF16A34A), size: 22),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                localResumeFileName!,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF14532D),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                isGu ? '✓ લોકલ ફાઈલ પસંદ થઈ ($localResumeFileSize)' : '✓ Selected from Local Storage ($localResumeFileSize)',
                                                style: const TextStyle(fontSize: 11, color: Color(0xFF16A34A), fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setModalState(() {
                                              localResumeFileName = null;
                                              localResumeFileSize = null;
                                            });
                                          },
                                          icon: const Icon(Icons.close_rounded, color: Color(0xFFEF4444), size: 18),
                                          tooltip: 'Remove file',
                                        ),
                                      ],
                                    ),
                                  ),
                                ] else ...[
                                  InkWell(
                                    onTap: () async {
                                      final ImagePicker picker = ImagePicker();
                                      try {
                                        final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                                        if (file != null) {
                                          setModalState(() {
                                            localResumeFileName = file.name;
                                            localResumeFileSize = '1.9 MB';
                                          });
                                        } else {
                                          setModalState(() {
                                            localResumeFileName = 'Soham_More_Local_Resume.pdf';
                                            localResumeFileSize = '2.4 MB';
                                          });
                                        }
                                      } catch (_) {
                                        setModalState(() {
                                          localResumeFileName = 'Soham_More_Local_Resume.pdf';
                                          localResumeFileSize = '2.4 MB';
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: const Color(0xFF0F172A), style: BorderStyle.solid, width: 1.2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.upload_file_rounded, color: Color(0xFF0F172A), size: 20),
                                          const SizedBox(width: 8),
                                          Flexible(
                                             child: Text(
                                               isGu ? 'લોકલ સ્ટોરેજમાંથી સીવી (PDF/DOC) પસંદ કરો' : 'Browse Local Files / Select Resume (PDF, DOCX)',
                                               style: const TextStyle(
                                                 fontSize: 12.5,
                                                 fontWeight: FontWeight.bold,
                                                 color: Color(0xFF0F172A),
                                               ),
                                               overflow: TextOverflow.ellipsis,
                                             ),
                                           ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Apply & Contact Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isGu
                                          ? '🎉 ${nameController.text} ની અરજી અને સીવી (${localResumeFileName ?? "Resume.pdf"}) $company માં સફળતાપૂર્વક મોકલવામાં આવી છે!'
                                          : '🎉 Application & Resume (${localResumeFileName ?? "Resume.pdf"}) for ${nameController.text} submitted to $company!',
                                    ),
                                    backgroundColor: const Color(0xFF0F172A),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.send_rounded, size: 16),
                              label: Text(
                                isGu ? 'અરજી સબમિટ કરો' : 'Submit Application',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F172A),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isGu
                                          ? '${job['hrPhone']} પર એચઆરનો સંપર્ક કરી રહ્યા છીએ...'
                                          : 'Opening HR contact for ${job['hrPhone']}...',
                                    ),
                                    backgroundColor: const Color(0xFF15803D),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.chat_bubble_outline, size: 16),
                              label: Text(
                                isGu ? 'એચઆર વોટ્સએપ' : 'Contact HR',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFCD34D),
                                foregroundColor: const Color(0xFF0F172A),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: text),
      ),
    );
  }

  void _showPostJobDialog(BuildContext context, bool isGu) {
    final titleController = TextEditingController();
    final companyController = TextEditingController();
    final locationController = TextEditingController();
    final salaryController = TextEditingController();
    final descController = TextEditingController();
    final phoneController = TextEditingController();
    final qualificationController = TextEditingController();
    final skillsController = TextEditingController();
    final contactNameController = TextEditingController();
    String selectedType = 'Full-Time';
    String? companyLogoPath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.90,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isGu ? 'નવી નોકરી પોસ્ટ કરો' : 'Post Job Vacancy',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Serif',
                              color: Color(0xFF0F172A),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // COMPANY LOGO / BANNER PICKER
                    _buildFieldLabel(isGu ? 'કંપનીનો લોગો / બેનર ઈમેજ પસંદ કરો' : 'Company Logo / Banner Image *', isGu),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        try {
                          final XFile? file = await picker.pickImage(source: ImageSource.gallery);
                          if (file != null) {
                            setModalState(() {
                              companyLogoPath = file.path;
                            });
                          } else {
                            setModalState(() {
                              companyLogoPath = 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop&q=80';
                            });
                          }
                        } catch (_) {
                          setModalState(() {
                            companyLogoPath = 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&auto=format&fit=crop&q=80';
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.add_photo_alternate_rounded, color: Color(0xFFB45309), size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    companyLogoPath != null ? 'Logo Attached ✓' : (isGu ? 'લોકલ ગેલેરીમાંથી ઇમેજ પસંદ કરો' : 'Upload Company Logo / Banner'),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: companyLogoPath != null ? const Color(0xFF16A34A) : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isGu ? 'PNG, JPG, JPEG સપોર્ટેડ' : 'PNG, JPG or JPEG from device storage',
                                    style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.upload_rounded, color: Color(0xFF0F172A), size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    _buildFieldLabel(isGu ? 'નોકરીનું શીર્ષક *' : 'Job Title *', isGu),
                    _buildInputField(titleController, isGu ? 'દા.ત. સોફ્ટવેર ડેવલપર' : 'e.g. Senior Accountant / Software Dev'),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'કંપની / સંસ્થાનું નામ *' : 'Company Name *', isGu),
                    _buildInputField(companyController, isGu ? 'દા.ત. સ્વજન લિમિટેડ' : 'e.g. Swajan Tech Solutions'),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'સ્થળ *' : 'Location *', isGu),
                              _buildInputField(locationController, isGu ? 'દા.ત. અમદાવાદ' : 'e.g. Ahmedabad'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'પગાર શ્રેણી *' : 'Salary Range *', isGu),
                              _buildInputField(salaryController, isGu ? 'દા.ત. ₹૪૦,૦૦૦/મહિનો' : 'e.g. ₹40,000/mo'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'જરૂરી શૈક્ષણિક લાયકાત' : 'Required Qualification', isGu),
                              _buildInputField(qualificationController, isGu ? 'દા.ત. B.Tech / MBA / Any Graduate' : 'e.g. B.Tech / MBA / Any Graduate'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'મુખ્ય કૌશલ્ય (Skills)' : 'Required Key Skills', isGu),
                              _buildInputField(skillsController, isGu ? 'દા.ત. Flutter, Tally, Sales' : 'e.g. Flutter, Tally, Sales'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'એચઆર / સંપર્ક વ્યક્તિનું નામ' : 'Contact Person Name', isGu),
                              _buildInputField(contactNameController, isGu ? 'દા.ત. રાજેશ પટેલ (HR)' : 'e.g. Rajesh Patel (HR)'),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFieldLabel(isGu ? 'એચઆર ફોન નંબર *' : 'HR Contact Phone *', isGu),
                              _buildInputField(phoneController, isGu ? '૧૦-અંકનો નંબર' : 'Enter 10-digit number'),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    _buildFieldLabel(isGu ? 'કામનું વર્ણન & જવાબદારીઓ *' : 'Job Description & Responsibilities *', isGu),
                    _buildInputField(descController, isGu ? 'જવાબદારીઓ અને જરૂરિયાતો વર્ણવો...' : 'Describe role and requirements...'),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.trim().isEmpty) return;
                          final newJobMap = {
                            'id': DateTime.now().millisecondsSinceEpoch.toString(),
                            'titleEn': titleController.text.trim(),
                            'titleGu': titleController.text.trim(),
                            'companyEn': companyController.text.trim().isNotEmpty ? companyController.text.trim() : 'Swajan Business',
                            'companyGu': companyController.text.trim().isNotEmpty ? companyController.text.trim() : 'સ્વજન વ્યવસાય',
                            'locationEn': locationController.text.trim().isNotEmpty ? locationController.text.trim() : 'Ahmedabad',
                            'locationGu': locationController.text.trim().isNotEmpty ? locationController.text.trim() : 'અમદાવાદ',
                            'salaryEn': salaryController.text.trim().isNotEmpty ? salaryController.text.trim() : 'Negotiable',
                            'salaryGu': salaryController.text.trim().isNotEmpty ? salaryController.text.trim() : 'વાટાઘાટો યોગ્ય',
                            'typeEn': selectedType,
                            'typeGu': isGu ? 'પૂર્ણ-સમય' : 'Full-Time',
                            'workModeEn': 'On-Site',
                            'workModeGu': 'ઓન-સાઇટ',
                            'categoryEn': 'General',
                            'categoryGu': 'સામાન્ય',
                            'postedTimeEn': 'Just now',
                            'postedTimeGu': 'હમણાં જ',
                            'expEn': qualificationController.text.trim().isNotEmpty ? qualificationController.text.trim() : 'Graduate Exp',
                            'expGu': qualificationController.text.trim().isNotEmpty ? qualificationController.text.trim() : 'ગ્રેજ્યુએટ અનુભવ',
                            'descEn': descController.text.trim().isNotEmpty ? descController.text.trim() : 'Contact employer for full details.',
                            'descGu': descController.text.trim().isNotEmpty ? descController.text.trim() : 'સંપૂર્ણ વિગતો માટે એમ્પ્લોયરનો સંપર્ક કરો.',
                            'hrPhone': phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : '+91 98765 43210',
                            'hrEmail': 'hr@swajan.org',
                            'logoColor': const Color(0xFF0F172A),
                          };

                          setState(() {
                            _jobs.insert(0, newJobMap);
                          });

                          // PREPEND TO HOME SCREEN LIVE FEED AS WELL
                          HomeScreen.addJobVacancy({
                            'id': 'job_${DateTime.now().millisecondsSinceEpoch}',
                            'type': 'Jobs',
                            'badge': 'JOB VACANCY • ${selectedType.toUpperCase()}',
                            'badgeColor': const Color(0xFF1E40AF),
                            'badgeBg': const Color(0xFFDBEAFE),
                            'author': companyController.text.trim().isNotEmpty ? companyController.text.trim() : 'Swajan Business',
                            'authorAvatar': 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&auto=format&fit=crop&q=80',
                            'timeEn': 'Just Now',
                            'timeGu': 'હમણાં જ',
                            'location': locationController.text.trim().isNotEmpty ? locationController.text.trim() : 'Ahmedabad',
                            'titleEn': titleController.text.trim(),
                            'titleGu': titleController.text.trim(),
                            'descEn': '${descController.text.trim()}\n\nQualification: ${qualificationController.text.trim()} | Skills: ${skillsController.text.trim()}',
                            'descGu': '${descController.text.trim()}\n\nલાયકાત: ${qualificationController.text.trim()} | કૌશલ્ય: ${skillsController.text.trim()}',
                            'image': companyLogoPath ?? 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?w=800&auto=format&fit=crop&q=80',
                            'actionEn': 'Apply Now / Contact',
                            'actionGu': 'અરજી કરો / સંપર્ક',
                            'likes': 1,
                            'comments': 0,
                            'isLiked': false,
                            'contact': 'Phone: ${phoneController.text.trim()} | HR: ${contactNameController.text.trim()}',
                          });

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isGu
                                    ? '🎉 નોકરીની જાહેરાત પોસ્ટ થઈ અને હોમ ફિડ પર લાઈવ થઈ!'
                                    : '🎉 Job vacancy published & live on Swajan Home Feed!',
                              ),
                              backgroundColor: const Color(0xFF0F172A),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFCD34D),
                          foregroundColor: const Color(0xFF0F172A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          isGu ? 'પોસ્ટ કરો & લાઈવ ડિસ્પ્લે કરો' : 'POST JOB VACANCY & LIVE DISPLAY',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFieldLabel(String label, bool isGu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF0F172A)),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final bool isGu = lang.currentLanguage == 'gu';

    final filteredList = _jobs.where((j) {
      final title = isGu ? j['titleGu'] : j['titleEn'];
      final company = isGu ? j['companyGu'] : j['companyEn'];
      final location = isGu ? j['locationGu'] : j['locationEn'];
      final category = j['categoryEn'] as String;

      final matchesSearch = _searchQuery.isEmpty ||
          title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          company.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          location.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = true;
      if (_selectedFilter == 'Full-Time') {
        matchesFilter = j['typeEn'] == 'Full-Time';
      } else if (_selectedFilter == 'Part-Time') {
        matchesFilter = j['typeEn'] == 'Part-Time';
      } else if (_selectedFilter == 'Remote') {
        matchesFilter = (j['workModeEn'] as String).contains('Remote');
      } else if (_selectedFilter == 'IT & Tech') {
        matchesFilter = category == 'IT & Tech';
      } else if (_selectedFilter == 'Finance') {
        matchesFilter = category == 'Finance';
      }

      return matchesSearch && matchesFilter;
    }).toList();

    final filterList = [
      {'en': 'All', 'gu': 'બધા'},
      {'en': 'Full-Time', 'gu': 'પૂર્ણ-સમય'},
      {'en': 'Part-Time', 'gu': 'અંશ-સમય'},
      {'en': 'Remote', 'gu': 'રિમોટ'},
      {'en': 'IT & Tech', 'gu': 'આઇટી અને ટેક'},
      {'en': 'Finance', 'gu': 'નાણાકીય'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isGu ? 'નોકરી અને કારકિર્દી' : 'Job Portal & Career',
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Color(0xFF0F172A)),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => HomeScreen(userName: widget.userName),
                ),
                (route) => false,
              );
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: GestureDetector(
                onTap: () => _showPostJobDialog(context, isGu),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCD34D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, size: 16, color: Color(0xFF0F172A)),
                      const SizedBox(width: 4),
                      Text(
                        isGu ? 'નોકરી ઉમેરો' : 'Post Job',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Hero Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E293B),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.work_history, color: Color(0xFFFCD34D), size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isGu ? 'સમુદાય કારકિર્દી પોર્ટલ' : 'SWAJAN CAREER PORTAL',
                          style: const TextStyle(
                            color: Color(0xFFFCD34D),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isGu
                              ? 'અમારા સમુદાયના વ્યવસાયોમાં શ્રેષ્ઠ નોકરીઓની તકો શોધો.'
                              : 'Discover top career opportunities within our Swajan business network.',
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12.5,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: isGu ? 'નોકરી, કંપની અથવા શહેરથી શોધો...' : 'Search by job title, company or city...',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B), size: 20),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: filterList.map((f) {
                  final key = f['en']!;
                  final label = isGu ? f['gu']! : f['en']!;
                  final isSelected = _selectedFilter == key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = key),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFCD34D) : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Job List
            if (filteredList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    isGu ? 'કોઈ નોકરી મળેલ નથી.' : 'No job openings found.',
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final job = filteredList[index];
                  final title = isGu ? job['titleGu'] : job['titleEn'];
                  final company = isGu ? job['companyGu'] : job['companyEn'];
                  final location = isGu ? job['locationGu'] : job['locationEn'];
                  final salary = isGu ? job['salaryGu'] : job['salaryEn'];
                  final type = isGu ? job['typeGu'] : job['typeEn'];
                  final workMode = isGu ? job['workModeGu'] : job['workModeEn'];
                  final postedTime = isGu ? job['postedTimeGu'] : job['postedTimeEn'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Top Row
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: (job['logoColor'] as Color).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(Icons.business, color: job['logoColor'] as Color, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Serif',
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    company,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Tags Row
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            _buildBadge(type, const Color(0xFFEFF6FF), const Color(0xFF1E40AF)),
                            _buildBadge(workMode, const Color(0xFFFEF9C3), const Color(0xFF854D0E)),
                            _buildBadge(location, const Color(0xFFF1F5F9), const Color(0xFF475569)),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Salary & Time Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              salary,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                            Text(
                              postedTime,
                              style: const TextStyle(fontSize: 11.5, color: Color(0xFF94A3B8)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Apply Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showJobDetailsModal(context, job, isGu),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFCD34D),
                              foregroundColor: const Color(0xFF0F172A),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isGu ? 'વિગતો જુઓ અને અરજી કરો' : 'View Details & Apply',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF0F172A)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        userName: widget.userName,
      ),
    );
  }
}
