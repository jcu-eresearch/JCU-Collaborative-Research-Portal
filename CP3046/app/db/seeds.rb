# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Pre fill the researchers table
# The pre fill data contains all staff from the school of Business
researchers = Researcher.create([
  { :title => "Student", :email => "robert.pyke@my.jcu.edu.au", :name => "Robert Pyke",    :jc_number => "jc155857" },
  { :title => "Associate Professor; Associate Dean, Research and Training", :name => "Aprof Bruce Litow", :email => "bruce.litow@jcu.edu.au", :jc_number => "jc710327" },
  { :title => "Senior Lecturer", :name => "Dr Dmitry Konovalov", :email => "dmitry.konovalov@jcu.edu.au", :jc_number => "jc082078" },
  { :title => "Casual Teaching", :name => "Mr David Browning", :email => "david.browning2@jcu.edu.au", :jc_number => "jc367199" },
  { :title => "Lecturer", :name => "Mr Lindsay Ward", :email => "lindsay.ward@jcu.edu.au", :jc_number => "jc282638" },
  { :title => "Professor - Marketing and Tourism", :name => "Prof Bruce Prideaux", :email => "bruce.prideaux@jcu.edu.au", :jc_number => "jc929397" },

  { :title => "School Manager; Casual Teaching", :name => "Mrs Tracey Mahony", :email => "tracey.mahony1@jcu.edu.au", :jc_number => "jc394716" },
  { :title => "Manager - Postgraduate Programs", :name => "Mr George Nicopoulos", :email => "george.nicopoulos@jcu.edu.au", :jc_number => "jc713497" },
  { :title => "Senior Lecturer; Director of Undergraduate Programs", :name => "Dr Janelle Rose", :email => "janelle.rose@jcu.edu.au", :jc_number => "jc489276" },
  { :title => "Manager, External Programs", :name => "Mrs Carmel Store", :email => "carmel.store@jcu.edu.au", :jc_number => "jc619350" },
  { :title => "Administrative Officer", :name => "Mrs Patricia Adams", :email => "patricia.adams@jcu.edu.au", :jc_number => "jc254613" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Ms Zulgerel Altai", :email => "zulgerel.altai1@jcu.edu.au", :jc_number => "jc031478" },
  { :title => "Adjunct Professor", :name => "Dr Sajid Anwar", :email => "sajid.anwar@jcu.edu.au", :jc_number => "jc495309" },
  { :title => "Admin Officer-Program Liaison", :name => "Ms Donna Barrett", :email => "donna.barrett@jcu.edu.au", :jc_number => "jc378193" },
  { :title => "Adjunct Associate Professor; Casual Teaching", :name => "Dr Frank Bartels", :email => "frank.bartels@jcu.edu.au", :jc_number => "jc650274" },
  { :title => "Casual Admin Assist; Casual External Exam Supervisor; Casual Internal Exam Supervisor; Casual Exams Supervisor", :name => "Mr Bill Beard", :email => "bill.beard@jcu.edu.au", :jc_number => "jc682175" },
  { :title => "Adjunct Senior Lecturer", :name => "Dr Pierre Benckendorff", :email => "pierre.benckendorff@jcu.edu.au", :jc_number => "jc586310" },
  { :title => "Casual Research Officer; Casual Teaching; Casual Research Fellow", :name => "Dr Boaz Bernstein", :email => "boaz.bernstein@jcu.edu.au", :jc_number => "jc866299" },
  { :title => "Casual Research Officer; CAS LECTURER A; Casual Teaching", :name => "Miss Ashleigh Bilbe", :email => "ashleigh.bilbe1@jcu.edu.au", :jc_number => "jc757029" },
  { :title => "Casual Teaching; Casual Research Fellow", :name => "Dr Julie Carmody", :email => "julie.carmody@jcu.edu.au", :jc_number => "jc232207" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Miss Diana Castorina", :email => "diana.castorina@jcu.edu.au", :jc_number => "jc222311" },
  { :title => "Casual Exam Supervisor; Casual Exams Supervisor; Casual Exams Supervisor-Business", :name => "Mrs Marilyn Christ", :email => "marilyn.christ@jcu.edu.au", :jc_number => "jc238667" },
  { :title => "Casual Admin Officer", :name => "Ms Kristen Corrie", :email => "kristen.corrie@jcu.edu.au", :jc_number => "jc470672" },
  { :title => "Casual Personal Assistant; Casual Admin Officer", :name => "Mrs Del Corrie", :email => "del.corrie@jcu.edu.au", :jc_number => "jc517722" },
  { :title => "Administrative Officer External Pro; Casual Admin Officer", :name => "Mrs Fiona Davies", :email => "fiona.davies@jcu.edu.au", :jc_number => "jc208436" },
  { :title => "Casual Research Worker; Casual Faculty marketing Coordinator; Casual Teaching; Casual Admin Officer; Administrative Officer", :name => "Mrs Jodie Derrick", :email => "jodie.derrick@jcu.edu.au", :jc_number => "jc351414" },
  { :title => "Casual Teaching", :name => "Ms Kathryn Edwards", :email => "kathryn.edwards@jcu.edu.au", :jc_number => "jc474731" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Mrs Marina Farr", :email => "marina.farr@jcu.edu.au", :jc_number => "jc032920" },
  { :title => "Admin Officer, Examinations Cairns; Casual Exams Super/Sim Patient; Casual Admin Assist; Casual Exams Supervisor; Casual Admin Officer; Casual Internal Exams Supervisor", :name => "Mrs Lesley Fraser", :email => "lesley.fraser@jcu.edu.au", :jc_number => "jc476331" },
  { :title => "Casual External Exams Supervisor; Casual Internal Exam Supervisor; Casual Admin Assistant; Casual Exams Supervisor; Casual Admin Officer", :name => "Miss Josie Fraser", :email => "josie.fraser1@jcu.edu.au", :jc_number => "jc583080" },
  { :title => "Adjunct Professor", :name => "Prof Vasant Gandhi", :email => "vasant.gandhi1@jcu.edu.au", :jc_number => "jc047572" },
  { :title => "Casual Teaching", :name => "Mr Dave Gleeson", :email => "david.gleeson@jcu.edu.au", :jc_number => "jc984661" },
  { :title => "Casual Teaching", :name => "Miss Naomi Gothard", :email => "naomi.gothard1@jcu.edu.au", :jc_number => "jc822036" },
  { :title => "Casual Teaching", :name => "Mr Amal Karunaratna", :email => "amal.karunaratna@jcu.edu.au", :jc_number => "jc075501" },
  { :title => "Casual Teaching", :name => "Ms Elena Konovalov", :email => "elena.konovalov1@jcu.edu.au", :jc_number => "jc351566" },
  { :title => "Adjunct Professor", :name => "Prof Eric Laws", :email => "eric.laws@jcu.edu.au", :jc_number => "jc279719" },
  { :title => "Casual Research Officer; Casual Teaching", :name => "Mr Paul Lynch", :email => "paul.lynch@jcu.edu.au", :jc_number => "jc068490" },
  { :title => "Casual Student Ambassador; Casual Facilitator - Writing Workshops; Casual Unistart Facilitator; Casual Teaching", :name => "Miss Lisa Mannering", :email => "lisa.mannering1@jcu.edu.au", :jc_number => "jc134912" },
  { :title => "Casual Examination Supervisor; Casual Exam Supervisor; Casual Internal Exam Supervisor; Casual Admin Officer", :name => "Ms Lee Miller", :email => "lee.miller@jcu.edu.au", :jc_number => "jc701868" },
  { :title => "Casual Exams Supervisor Chemistry; Casual Sim Pat/Exam Supervisor; Casual Exams Super/Sim Patient; Casual Examination Supervisors", :name => "Ms Rita Molloy", :email => "rita.molloy@jcu.edu.au", :jc_number => "jc953316" },
  { :title => "Casual Exams Supervisor Law; Casual Exam Supervisor; Casual Exams Supervisor", :name => "Mrs Heather Mulville", :email => "annie.mulville@jcu.edu.au", :jc_number => "jc436185" },
  { :title => "Casual Examination Supervisor; Casual Exams Supervisor", :name => "Mr Dennis Mulville", :email => "mervyn.mulville@jcu.edu.au", :jc_number => "jc154439" },
  { :title => "Casual Exams Super/Sim Patient; Casual Internal Exam Supervisor; Casual Exams Supervisor Business; Casual Exams Supervisor Internal", :name => "Ms Sandra Nawell", :email => "sandra.nawell@jcu.edu.au", :jc_number => "jc999274" },
  { :title => "Casual Exams Supervisor Chemistry; Casual Exams Super/Sim Patient; Casual Exam Supervisor", :name => "Mrs Maureen Norman", :email => "maureen.norman@jcu.edu.au", :jc_number => "jc028921" },
  { :title => "Adjunct Professor", :name => "Prof Brendan O'Connell", :email => "brendan.oconnell@jcu.edu.au", :jc_number => "jc753745" },
  { :title => "Casual Exams Super/Sim Patient; Casual Internal Exam Supervisor", :name => "Mrs Patricia O'Connor", :email => "patricia.oconnor@jcu.edu.au", :jc_number => "jc196273" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Miss Anja Pabel", :email => "anja.pabel1@jcu.edu.au", :jc_number => "jc091223" },
  { :title => "Casual Administrative Officer; Casual Teaching; Casual Exams Supervisor; Project Officer", :name => "Ms Annette Panzera", :email => "annette.panzera@jcu.edu.au", :jc_number => "jc622154" },
  { :title => "Foundation Professor of Tourism", :name => "Prof Philip Pearce", :email => "philip.pearce@jcu.edu.au", :jc_number => "jc647993" },
  { :title => "Adjunct Professor", :name => "Prof Glenn Ross", :email => "glenn.ross@jcu.edu.au", :jc_number => "jc666404" },
  { :title => "Casual Exams Super/Sim Patient; CasuaExternal Exam Supervisor; Casual Exams Supervisor- Law; Casual Internal Exam Supervisor", :name => "Mrs Janelle Sharpe", :email => "janelle.sharpe@jcu.edu.au", :jc_number => "jc531094" },
  { :title => "Administrative Officer", :name => "Ms Wendy Sibthorpe", :email => "wendy.sibthorpe@jcu.edu.au", :jc_number => "jc656688" },
  { :title => "Casual External Exams Supervisor; Casual Research Worker; Casual Chief Exam Supervisor; Casual External Exam Supervisor; Casual Exams Supervisor; Casual Internal Exams Supervisor; Casual Admin Officer", :name => "Ms Irene Tenni", :email => "irene.tenni@jcu.edu.au", :jc_number => "jc837982" },
  { :title => "Casual Exams Super/Sim Patient; Casual Internal Exams Supervisor", :name => "Mrs Dorothy Turner", :email => "dorothy.turner@jcu.edu.au", :jc_number => "jc801144" },
  { :title => "Casual Exam Supervisor; Casual MD2020 Quiz 3 Invigilator; Casual Internal Exam Supervisor", :name => "Mrs Ann Vigorelli", :email => "ann.vigorelli@jcu.edu.au", :jc_number => "jc484302" },
  { :title => "Casual Research Worker; Casual Research Assistant", :name => "Mr Peter Wood", :email => "peter.wood@jcu.edu.au", :jc_number => "jc920423" },
  { :title => "Visiting Scholar", :name => "Aprof Jiang Wu", :email => "jiang.wu@jcu.edu.au", :jc_number => "jc332396" },
  { :title => "Administrative Officer", :name => "Mrs Robyn Yesberg", :email => "robyn.yesberg@jcu.edu.au", :jc_number => "jc543620" },
  { :title => "Lecturer", :name => "Mr Rafiuddin Ahmed", :email => "rafiuddin.ahmed@jcu.edu.au", :jc_number => "jc819049" },
  { :title => "Lecturer", :name => "Mr Ian Burnett", :email => "ian.burnett@jcu.edu.au", :jc_number => "jc150676" },
  { :title => "Lecturer", :name => "Mrs Sue Ciccotosto", :email => "susan.ciccotosto@jcu.edu.au", :jc_number => "jc704484" },
  { :title => "Professor - Accounting", :name => "Prof Lyndal Drennan", :email => "lyndal.drennan@jcu.edu.au", :jc_number => "jc154468" },
  { :title => "Associate Professor - accounting", :name => "Dr Chris Durden", :email => "chris.durden@jcu.edu.au", :jc_number => "jc981416" },
  { :title => "Casual Teaching", :name => "Mr Jason Harris", :email => "jason.harris1@jcu.edu.au", :jc_number => "jc290134" },
  { :title => "Associate Professor - Accounting", :name => "Aprof Chris Hunt", :email => "chris.hunt@jcu.edu.au", :jc_number => "jc266708" },
  { :title => "Lecturer", :name => "Mr Ben Jacobsen", :email => "ben.jacobsen@jcu.edu.au", :jc_number => "jc673560" },
  { :title => "Casual Teaching", :name => "Mrs Wendy Kerr", :email => "wendy.kerr@jcu.edu.au", :jc_number => "jc048792" },
  { :title => "Lecturer - Accounting and Finance", :name => "Mr Richard Lane", :email => "richard.lane@jcu.edu.au", :jc_number => "jc349430" },
  { :title => "Lecturer", :name => "Ms Siqiwen Li", :email => "siqiwen.li@jcu.edu.au", :jc_number => "jc381698" },
  { :title => "Lecturer", :name => "Ms Jodie Maxfield", :email => "jodie.maxfield1@jcu.edu.au", :jc_number => "jc722241" },
  { :title => "Casual Teaching", :name => "Ms Karen McPherson", :email => "karen.mcpherson@jcu.edu.au", :jc_number => "jc026507" },
  { :title => "Senior Lecturer", :name => "Ms Karen Ness", :email => "karen.ness@jcu.edu.au", :jc_number => "jc928221" },
  { :title => "Lecturer - Accounting and Finance", :name => "Ms Pauline Pender", :email => "pauline.pender@jcu.edu.au", :jc_number => "jc296366" },
  { :title => "Senior Lecturer", :name => "Mr David Smorfitt", :email => "david.smorfitt@jcu.edu.au", :jc_number => "jc559501" },
  { :title => "Professor - Accounting", :name => "Prof John Staunton", :email => "john.staunton@jcu.edu.au", :jc_number => "jc038884" },
  { :title => "Senior Lecturer", :name => "Dr Singwhat Tee", :email => "singwhat.tee@jcu.edu.au", :jc_number => "jc890689" },
  { :title => "Lecturer - Accounting and Finance", :name => "Ms Michelle Warrington", :email => "michelle.warrington@jcu.edu.au", :jc_number => "jc951194" },
  { :title => "Senior Lecturer", :name => "Dr Rabiul Beg", :email => "rabiul.beg@jcu.edu.au", :jc_number => "jc710874" },
  { :title => "Lecturer", :name => "Dr Taha Chaiechi", :email => "taha.chaiechi@jcu.edu.au", :jc_number => "jc885744" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Miss Tingzhen Chen", :email => "tingzhen.chen@jcu.edu.au", :jc_number => "jc544728" },
  { :title => "Casual Research Worker;", :name => "Miss Michelle Esparon", :email => "michelle.esparon@jcu.edu.au", :jc_number => "jc908422" },
  { :title => "Lecturer", :name => "Dr Hong-Bo Liu", :email => "hongbo.liu@jcu.edu.au", :jc_number => "jc727328" },
  { :title => "Senior Lecturer", :name => "Dr Breda McCarthy", :email => "breda.mccarthy@jcu.edu.au", :jc_number => "jc913487" },
  { :title => "Adjunct Associate Professor", :name => "Aprof Richard Monypenny", :email => "richard.monypenny@jcu.edu.au", :jc_number => "jc313462" },
  { :title => "Research Officer", :name => "Mrs Barbara Neil", :email => "barbara.neil1@jcu.edu.au", :jc_number => "jc185413" },
  { :title => "Associate Professor", :name => "Aprof Natalie Stoeckl", :email => "natalie.stoeckl@jcu.edu.au", :jc_number => "jc475635" },
  { :title => "Lecturer", :name => "Mr Sizhong Sun", :email => "sizhong.sun@jcu.edu.au", :jc_number => "jc378457" },
  { :title => "Senior Lecturer", :name => "Dr Riccardo Welters", :email => "riccardo.welters@jcu.edu.au", :jc_number => "jc332545" },
  { :title => "Professor - Business Studies", :name => "Prof Zhang-Yue Zhou", :email => "zhangyue.zhou@jcu.edu.au", :jc_number => "jc039705" },
  { :title => "Acting Head Of School", :name => "Aprof John Hamilton", :email => "john.hamilton@jcu.edu.au", :jc_number => "jc507487" },
  { :title => "Senior Lecturer; Associate Dean - Research", :name => "Dr Alastair Birtles", :email => "alastair.birtles@jcu.edu.au", :jc_number => "jc704042" },
  { :title => "Research Worker; Associate Lecturer; Casual Teaching", :name => "Mr Matthew Curnock", :email => "matthew.curnock@jcu.edu.au", :jc_number => "jc974274" },
  { :title => "Casual Research Worker", :name => "Miss Marta Espinheira", :email => "marta.espinheira1@jcu.edu.au", :jc_number => "jc887193" },
  { :title => "Senior Lecturer", :name => "Dr Tracey Harrison-Hill", :email => "tracey.harrisonhill@jcu.edu.au", :jc_number => "jc948247" },
  { :title => "Casual Research Officer; Lecturer", :name => "Dr Sharon Harwood", :email => "sharon.harwood1@jcu.edu.au", :jc_number => "jc890520" },
  { :title => "Project Development Officer; Casual Consultant; Casual Project Development Officer", :name => "Mr Ben Menadue", :email => "ben.menadue@jcu.edu.au", :jc_number => "jc312074" },
  { :title => "Professor Personal Chair", :name => "Prof Gianna Moscardo", :email => "gianna.moscardo@jcu.edu.au", :jc_number => "jc755933" },
  { :title => "Senior Lecturer", :name => "Dr Laurie Murphy", :email => "laurie.murphy@jcu.edu.au", :jc_number => "jc088297" },
  { :title => "Casual Research Worker; Casual Teaching", :name => "Mrs Jenny Panchal", :email => "jenny.panchal@jcu.edu.au", :jc_number => "jc296752" },
  { :title => "Casual Teaching; Postgrad Admin Officer", :name => "Ms Andrea Schurmann", :email => "andrea.schurmann1@jcu.edu.au", :jc_number => "jc702232" },
  { :title => "Casual Research Worker; Research Worker; Casual Teaching", :name => "Ms Susan Sobtzick", :email => "susan.sobtzick@jcu.edu.au", :jc_number => "jc862459" },
  { :title => "Associate Lecturer", :name => "Mr Christian Ware", :email => "christian.ware@jcu.edu.au", :jc_number => "jc076933" },
  { :title => "School Manager; Casual Teaching", :name => "Mrs Shirley Jones", :email => "shirley.jones@jcu.edu.au", :jc_number => "jc874606" },
  { :title => "Lecturer - Management", :name => "Dr Anna Blackman", :email => "anna.blackman@jcu.edu.au", :jc_number => "jc596774" },
  { :title => "Casual Teaching", :name => "Ms Adrienne Brooks", :email => "adrienne.brooks@jcu.edu.au", :jc_number => "jc953977" },
  { :title => "Casual Teaching", :name => "Ms Julie Edwards", :email => "julie.edwards@jcu.edu.au", :jc_number => "jc511404" },
  { :title => "Lecturer", :name => "Ms Vera Girgenti", :email => "vera.girgenti@jcu.edu.au", :jc_number => "jc236755" },
  { :title => "Lecturer - Management", :name => "Mrs Kylie Hoffensetz", :email => "kylie.hoffensetz@jcu.edu.au", :jc_number => "jc671797" },
  { :title => "Casual Research Worker; Research; Casual Teaching", :name => "Mr Lars Kalland", :email => "lars.kalland@jcu.edu.au", :jc_number => "jc786100" },
  { :title => "Lecturer", :name => "Mr Alf Kuilboer", :email => "alf.kuilboer1@jcu.edu.au", :jc_number => "jc358504" },
  { :title => "Senior Lecturer", :name => "Dr Stephane Le Queux", :email => "stephane.lequeux@jcu.edu.au", :jc_number => "jc638351" },
  { :title => "Associate Professor", :name => "Aprof Darren Lee-Ross", :email => "darren.leeross@jcu.edu.au", :jc_number => "jc975637" },
  { :title => "Casual Teaching", :name => "Mr Chris Leggett", :email => "chris.leggett@jcu.edu.au", :jc_number => "jc707893" },
  { :title => "Lecturer", :name => "Mr Dwight Lemke", :email => "dwight.lemke@jcu.edu.au", :jc_number => "jc080006" },
  { :title => "Casual Teaching; Adjunct Senior Lecturer", :name => "Mrs Moina Lettice", :email => "moina.lettice@jcu.edu.au", :jc_number => "jc051973" },
  { :title => "Casual Teaching", :name => "Mr Ken Miller", :email => "kenneth.miller@jcu.edu.au", :jc_number => "jc394421" },
  { :title => "Lecturer", :name => "Dr Murray Prideaux", :email => "murray.prideaux@jcu.edu.au", :jc_number => "jc820433" },
  { :title => "Senior Lecturer", :name => "Dr Josephine Pryce", :email => "josephine.pryce@jcu.edu.au", :jc_number => "jc836932" },
  { :title => "Casual Research Worker;", :name => "Mrs Michelle Thompson", :email => "michelle.thompson@jcu.edu.au", :jc_number => "jc063962" },
  { :title => "Lecturer", :name => "Mr Roy Wybrow", :email => "roy.wybrow1@jcu.edu.au", :jc_number => "jc093219" },
  { :title => "Casual Teaching; CAS LECTURER A", :name => "Mr Trevor Andersen", :email => "trevor.andersen@jcu.edu.au", :jc_number => "jc533416" },
  { :title => "Casual Teaching", :name => "Mr Tristan Davey", :email => "tristan.davey1@jcu.edu.au", :jc_number => "jc683425" },
  { :title => "Casual Teaching", :name => "Mr Jess Farber", :email => "jess.farber1@jcu.edu.au", :jc_number => "jc510364" },
  { :title => "Senior Lecturer", :name => "Dr Hossein Ghodosi", :email => "hossein.ghodosi@jcu.edu.au", :jc_number => "jc006299" },
  { :title => "Lecturer", :name => "Dr Jason Holdsworth", :email => "jason.holdsworth@jcu.edu.au", :jc_number => "jc622831" },
  { :title => "Lecturer", :name => "Dr Kim Ku", :email => "kim.ku@jcu.edu.au", :jc_number => "jc368848" },
  { :title => "Casual Teaching", :name => "Mr Scott Lahney", :email => "scott.lahney@jcu.edu.au", :jc_number => "jc000996" },
  { :title => "Associate Professor", :name => "Aprof Ickjai Lee", :email => "ickjai.lee@jcu.edu.au", :jc_number => "jc543019" },
  { :title => "Senior Lecturer", :name => "Dr Joanne Lee", :email => "joanne.lee@jcu.edu.au", :jc_number => "jc565571" },
  { :title => "Lecturer", :name => "Mr Colin Lemmon", :email => "colin.lemmon@jcu.edu.au", :jc_number => "jc985606" },
  { :title => "Senior Lecturer", :name => "Dr Carrie Lui", :email => "carrie.lui@jcu.edu.au", :jc_number => "jc517482" },
  { :title => "Casual Teaching; CAS LECTURER A", :name => "Mr Eugene McArdle", :email => "eugene.mcardle@jcu.edu.au", :jc_number => "jc690068" },
  { :title => "Casual Teaching", :name => "Ms Angela McCarthy", :email => "angela.mccarthy1@jcu.edu.au", :jc_number => "jc032476" },
  { :title => "Casual Computer Systems Officer; Casual Admin Assistant; Casual Teaching; Casual Admin Officer", :name => "Mr Barry Mitchell", :email => "barry.mitchell@jcu.edu.au", :jc_number => "jc153969" },
  { :title => "Lecturer", :name => "Dr Trina Myers", :email => "trina.myers@jcu.edu.au", :jc_number => "jc028320" },
  { :title => "Computer Systems Officer; Casual Client Service Officer", :name => "Mr Mahendra Patel", :email => "mahendrakumaramratlal.patel@jcu.edu.au", :jc_number => "jc547791" },
  { :title => "Research Fellow", :name => "Dr Jarrod Trevathan", :email => "jarrod.trevathan@jcu.edu.au", :jc_number => "jc050641" },
])

posts = Post.create([
  { :title => "Addition of SEED Cipher Suites to Transport Layer Security (TLS)", :content => 
%{
SEED is easily implemented in various software and hardware because
it is designed to increase the efficiency of memory storage and the
simplicity of generating keys without degrading the security of the
algorithm.  In particular, it can be effectively adopted in a
computing environment that has a restricted resources such as mobile
devices, smart cards, and so on.

SEED is a national industrial association standard [TTASSEED] and is
widely used in South Korea for electronic commerce and financial
services operated on wired & wireless PKI.

The algorithm specification and object identifiers are described in
[SEED-ALG].  The SEED homepage,
http://www.kisa.or.kr/seed/seed_eng.html, contains a wealth of
information about SEED, including detailed specification, evaluation
report, test vectors, and so on.
}, :researcher => researchers[1]
  },
  
  { :title => "IPv4 Run-Out and IPv4-IPv6 Co-Existence Scenarios", :content =>
%{
When IPv6 was designed, it was expected that the transition from IPv4
to IPv6 would occur more smoothly and expeditiously than experience
has revealed.  The growth of the IPv4 Internet and predicted
depletion of the free pool of IPv4 address blocks on a foreseeable
horizon has highlighted an urgent need to revisit IPv6 deployment
models.  This document provides an overview of deployment scenarios
with the goal of helping to understand what types of additional tools
the industry needs to assist in IPv4 and IPv6 co-existence and
transition.

This document was originally created as input to the Montreal co-
existence interim meeting in October 2008, which led to the
rechartering of the Behave and Softwire working groups to take on new
IPv4 and IPv6 co-existence work.  This document is published as a
historical record of the thinking at the time, but hopefully will
also help readers understand the rationale behind current IETF tools
for co-existence and transition.
}, :researcher => researchers[2]
  },
])
   
