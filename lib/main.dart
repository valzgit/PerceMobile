import 'package:flutter/material.dart';
import 'package:percemobile/Components/Basic/comment.dart';
import 'package:percemobile/Hive/boxes.dart';
import 'package:percemobile/Routing/route_generator.dart';
import "package:hive_flutter/hive_flutter.dart";

import 'Hive/transaction.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LoggedUserAdapter());
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(UserBookRelationAdapter());
  Hive.registerAdapter(StoredBookAdapter());
  Hive.registerAdapter(BookCommentedAdapter());
  await Hive.openBox<User>("users");
  await Hive.openBox<LoggedUser>("loggedUser");
  await Hive.openBox<Book>("books");
  await Hive.openBox<UserBookRelation>("userbookrelations");
  await Hive.openBox<StoredBook>("storedbooks");
  await Hive.openBox<BookCommented>("bookcomments");
  final usersBox = Boxes.getUsers();
  final shelf = Boxes.getBooks();
  final commentBox = Boxes.getCommentsForBook();
  final buyer = User()
    ..name = "user"
    ..password = "Password123!"
    ..lastName = "user"
    ..userName = "user"
    ..phoneNumber = "64245624624"
    ..email = "user@user.com"
    ..buyer = true;
  final buyer2 = User()
    ..name = "ana"
    ..password = "Password123!"
    ..lastName = "ana"
    ..userName = "ana"
    ..phoneNumber = "64245624624"
    ..email = "ana@user.com"
    ..buyer = true;
  final buyer3 = User()
    ..name = "milan"
    ..password = "Password123!"
    ..lastName = "milan"
    ..userName = "milan"
    ..phoneNumber = "64245624624"
    ..email = "milan@user.com"
    ..buyer = true;
  final seller = User()
    ..name = "prod"
    ..password = "Password123!"
    ..lastName = "prod"
    ..userName = "prod"
    ..phoneNumber = "46265262356"
    ..email = "prod@prod.com"
    ..buyer = false;
  final comment1 = Comment(5, "Svakome ko voli psiholoske romane bih preporucio ovaj!", "user");
  final comment2 = Comment(5, "Divna!", "prod");
  final comment3 = Comment(4, "Dobraa", "ana");
  final comment4 = Comment(5, "Raskoljnikov znaci raskol kao sto Razumihin znaci razum", "milan");
  List<Comment> commentList = [];
  commentList.add(comment1);
  commentList.add(comment2);
  commentList.add(comment3);
  commentList.add(comment4);
  List<String> userNamesCommented = [];
  List<String> commentsFromUsers = [];
  List<int> starsUsersLeft = [];
  for (int i = 0; i < commentList.length; ++i) {
    Comment comment = commentList[i];
    userNamesCommented.add(comment.userName);
    commentsFromUsers.add(comment.comment);
    starsUsersLeft.add(comment.numberOfStars);
  }
  final bookComments = BookCommented()
    ..bookUrl = "crimeandpunishment.png"
    ..comments = commentsFromUsers
    ..starsGiven = starsUsersLeft
    ..userNames = userNamesCommented;
  commentBox.put("crimeandpunishment.png", bookComments);
  List<Book> bookList = new List<Book>();
  bookList.add(Book()
    ..name = "Zlocin i kazna"
    ..writer = "Fjodor Dostojevski"
    ..bookUrl = "crimeandpunishment.png"
    ..promoted = true
    ..placeYear = "Beograd, 2016."
    ..pageNumber = 654
    ..genre = "Svaki"
    ..details =
        '"Zlocin i kazna" predstavlja sintezu raznih osobina romanesknog zanra. Ovo je kriminalni roman, jer govori o junaku ubici i o traganju policije za njim. Takodje je i psiholoski roman, jer se likovi u romanu razotkrivaju analizom psihickih stanja i njihovih ponasanja i to uz pomoc unutrasnjih monologa, diskusija i snova. Ima elemente i filozofskog romana, jer nosi ideju glavnog junaka objasnjenu u clanku „O zlocinu“. Obuhvata zivot u sirotinjskim cetvrtima, prostituciju, alkoholizam i socijalnu obespravljenost, pa je ovo i socijalni roman.');
  bookList.add(Book()
    ..name = "Ana Karenjina"
    ..writer = "Lav Tolstoj"
    ..bookUrl = "anakarenjina.jpg"
    ..promoted = false
    ..placeYear = "Beograd, 2018."
    ..pageNumber = 890
    ..genre = "Svaki"
    ..details =
        'Sve srecne porodice lice jedna na drugu, svaka nesrecna porodica nesrecna je na svoj nacin. Roman koji je Fjodor Dostojevski smatrao besprekornim, a Vilijam Fokner nazvao najboljim romanom koji je ikada napisan, Ana Karenjina je monumentalno delo Lava Tolstoja koji daje sveobuhvatan prikaz ruskog drustva devetnaestog veka, od aristokratskih salona do seoskih gazdinstava. Uvodeci dva narativna toka, prvi koji prati ljubavnu pricu izmedju Ane i Vronskog i drugi koji prati odnos izmedju Kiti i Ljevina, Lav Tolstoj ispisuje svevremene stranice o porodici, gubitku, ljubavi, izdaji, veri i prijateljstvu.');
  var bookCommentsEmpty = BookCommented()
    ..bookUrl = "anakarenjina.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Betmen"
    ..writer = "Bob Kejn"
    ..bookUrl = "batman.png"
    ..promoted = true
    ..placeYear = "Beograd, 2016."
    ..pageNumber = 34
    ..genre = "Svaki"
    ..details = 'Napeta saga u kojoj se novi Betmenom protivnik "Bejn" pojavljuje se nastavlja...');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "batman.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Braca Karamazovi"
    ..writer = "Fjodor Dostojevski"
    ..bookUrl = "bracakaramazovi.jpg"
    ..promoted = true
    ..placeYear = "Beograd, 2016."
    ..pageNumber = 1100
    ..genre = "Svaki"
    ..details =
        "Roman Braca Karamazovi Fjodora Dostojevskog po misljenju mnogih kriticara i proucavalaca njegovog dela smatra se krunom autorove spisateljske karijere. Prica o porodici Karamazov Dostojevskom je posluzila kao okosnica za izuzetan filozofski roman koji istrazuje hriscansku etiku, slobodnu volju, otudjenost, suparnistvo i moral. Vecita borba dobra i zla svevremeno je otelotvorena u likovima Fjodora Pavlovica i njegovih sinova Mitje, Ivana, Aljose i vanbracnog sina Smerdjakova. Nakon vise od jednog veka od objavljivanja ovog romana, autenticnost i psiholoska rafiniranost njihovih karaktera ne prestaju da nas intrigiraju i fasciniraju. „Porodica Karamazov predocava se kao jedan mikrokosmos, u kojem se reflektuju najvaznije protivrecnosti covekovog bica.“ Maksimilijan Braun");
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "bracakaramazovi.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Cica Gorio"
    ..writer = "Onore de Balzak"
    ..bookUrl = "cicagorio.jpg"
    ..promoted = false
    ..placeYear = "Beograd, 2016."
    ..pageNumber = 342
    ..genre = "Svaki"
    ..details =
        "Cica Gorio je remek-delo Balzakova stvaralastva i njegov najpoznatiji i najcitaniji roman. Istorija romana pocinje u malogradjanskom pansionu, u kvartu cije su zbijene ulice puste, kuce sumorne, a zidovi podsecaju na tamnicu. Sopstvenica, udovica Voker, ziva je slika tog pansiona u kom se ogleda nevolja. Tu gde vlada beda bez poezije obitava siromasni svet na cijem se dotrajalom odelu ponavlja ocajni unutrasnji izgled ove tuzne i prljave kuce, svet koji je doziveo mnoga zivotna iskusenja i svet koji tek ulazi u zivot. U takvu sredinu upao je mladi student prava Ezen de Rastinjak...");
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "cicagorio.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Na Drini cuprija"
    ..writer = "Ivo Andric"
    ..bookUrl = "cuprija.png"
    ..promoted = false
    ..placeYear = "Beograd, 2014."
    ..pageNumber = 334
    ..genre = "Svaki"
    ..details =
        'Najpoznatiji roman Ive Andrica, "Na Drini curpija" (1945), hronoloski prati cetiri veka zbivanja oko velikog mosta preko reke Drine u Visegradu, koji je izgradio veliki vezir Mehmed pasa Sokolovic, poreklom iz tih krajeva. ');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "cuprija.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Divergence"
    ..writer = "S. J. Serih"
    ..bookUrl = "divergence.png"
    ..promoted = false
    ..placeYear = "Beograd, 2013."
    ..pageNumber = 212
    ..genre = "Svaki"
    ..details = "The twenty-first book in the beloved Foreigner saga continues the adventures of diplomat Bren Cameron, advisor to the atevi head of state.");
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "divergence.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Hari Poter i kamen mudrosti"
    ..writer = "J.K. Rouling"
    ..bookUrl = "hariputer.png"
    ..promoted = false
    ..placeYear = "Beograd, 2012."
    ..pageNumber = 354
    ..genre = "Svaki"
    ..details =
        'Ostavljen kao beba na pragu kuce u Simsirovoj ulici broj 4, Hari Poter odrasta u ostavi ispod stepenista, kao meta stalnih maltretiranja tetke, tece i njihovog Dadlija. Ali kada sove pocnu da opsedaju njihov dom, noseci na njega adresirana pisma, zivot mu se iz korena menja. Od poludzina Hagrida saznaje za svoje carobnjacko nasledje i magijski svet skriven iza kulisa svakidasnjice, poput perona devet i tri cetvrtine, pocetne stanice carobnog voza koji Harija void do Hogvortsa, skole za vesticarenje i carobnjastvo, srca sveta magije! ');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "hariputer.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Hari Poter i relikvije smrti"
    ..writer = "J. K. Rouling"
    ..bookUrl = "harrypotter.png"
    ..promoted = false
    ..placeYear = "Beograd, 2011."
    ..pageNumber = 654
    ..genre = "Svaki"
    ..details =
        "Hari Poter i relikvije Smrti je konacno razresenje drame, toliko zeljeno cekani odgovor na pitanje ko ce preziveti i ko je konacni pobednik u epskoj borbi dobra i zla. U toj borbi Hari Poter nije ni najmanje usamljen, ali i mracni gospodar Voldemor ima silu jacu nego ikad pre. Dambldor je Hariju poverio kljucni zadatak za opstanak i prevagu dobra, ali je tolike tajne poneo sa sobom, u svet s one strane zivota. Naseg junaka stoga razdiru sumnje i izneverena ocekivanja, koja samo rastu sa priblizavanjem zavrsnog sukoba – rata oko Hogvortsa i svih tajni koje su u njemu pohranjene.");
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "harrypotter.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Hobit"
    ..writer = "Dz. R. R. Tolkin"
    ..bookUrl = "hobbit.png"
    ..promoted = false
    ..placeYear = "Beograd, 2017."
    ..pageNumber = 371
    ..genre = "Svaki"
    ..details =
        'Hobit je jedan u nizu Tolkinovih romana o Srednjoj zemlji koji je zavrsen 1936. godine, a cije se prvo izdanje pojavilo 1937. godine. Prvobitno je bio napisan kao decja knjiga, koja je sadrzala elemente mitologije iz Silmariliona koji su kasnije iskoristeni da povezu Hobita sa Gospodarom Prstenova. Radnja romana se odigrava u Trecem dobu (po Tolkinovom racunanju vremena), nakon radnje zbirke prica Silmarilion, a pre Gospodara Prstenova i govori o hobitu Bilbu Baginsu i njegovim saputnicima na putovanju do Samotne planine, sukobu sa zmajem Smaugom, i povratku kuci.');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "hobbit.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Mali princ"
    ..writer = "Sant de Sent Egziperi"
    ..bookUrl = "littleprince.jpg"
    ..promoted = false
    ..placeYear = "Beograd, 2016."
    ..pageNumber = 155
    ..genre = "Svaki"
    ..details =
        '...Kazete li im: „Dokaz da je mali princ postojao jeste to sto je bio divan, sto se smejao, sto je zeleo ovcu. Kad covek zeli ovcu, to je dokaz da postoji“, oni ce slegnuti ramenima i smatrace vas detetom! Medjutim, ukoliko im saopstite: „Planeta s koje je dosao mali princ jeste asteroid B612“, bice zadovoljni i nece vam vise dosadjivati pitanjima. Takvi su oni. Ne valja se zato na njih ljutiti. Deca moraju mnogo toga da prastaju odraslima.');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "littleprince.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Tri musketara"
    ..writer = "Aleksandar Dima"
    ..bookUrl = "musketari.png"
    ..promoted = false
    ..placeYear = "Beograd, 2015."
    ..pageNumber = 450
    ..genre = "Svaki"
    ..details =
        'Uvek u potrazi za dobrom avanturom, siromasni plemic D’Artanjan, bez mane i straha, iz provincije stize u Pariz da ostricom maca stekne slavu i bogatstvo. Hrabar, okretan i spreman na sve, ubrzo postaje zapazen, ali zbog svog neobuzdanog karaktera upada u razne nevolje. Kroz neocekivani splet okolnosti, mladi D’Artanjan nailazi na tri elitna ratnika u sluzbi kralja Francuske.');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "musketari.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Starac i more"
    ..writer = "Ernest Hemingvej"
    ..bookUrl = "staracimore.jpg"
    ..promoted = false
    ..placeYear = "Beograd, 2020."
    ..pageNumber = 287
    ..genre = "Svaki"
    ..details =
        "Knjiga “Starac i more” predstavlja pricu o epskoj borbi izmedju starog prekaljenog ribara i najveceg ulova njegovog zivota. Citavih osamdeset i cetiri dana, Santijago, ostareli kubanski ribar, otisnuo se na more i vratio se praznih saka. Njegov neuspeh u ribarenju je toliko ocit da su roditelji njegovog mladog, posvecenog segrta i prijatelja, Manolina, primorali decaka da napusti starca kako bi ribario na unosnijem brodu.");
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "staracimore.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Teorija svega"
    ..writer = "Stiven Hoking"
    ..bookUrl = "stivenhoking.jpg"
    ..promoted = false
    ..placeYear = "Beograd, 2015."
    ..pageNumber = 654
    ..genre = "Svaki"
    ..details =
        'Seven lectures by the brilliant theoretical physicist have been compiled into this book to try to explain to the common man, the complex problems of mathematics and the question that has been gripped everyone all for centuries, the theory of existence. Undeniably intelligent, witty and childlike in his explanations, the narrator describes every detail about the beginning of the universe. He describes what a theory that can state the initiation of everything would encompass.');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "stivenhoking.jpg"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  bookList.add(Book()
    ..name = "Prasko groblje"
    ..writer = "Umberto Eko"
    ..bookUrl = "umbertoeco.png"
    ..promoted = false
    ..placeYear = "Beograd, 2013."
    ..pageNumber = 462
    ..genre = "Svaki"
    ..details =
        'Istrazujuci prirodu lazi, neponovljivi Umberto Eko vodi nas u Evropu XIX veka, prepunu misterija i zavera. Jednog jutra, kapetan Simone Simonini budi se sa amnezijom, sve mu je mutno u glavi i ne može da sagleda proslost. Osetivsi neobicno zadovoljstvo dok pusta pero da klizi po hartiji, on pocinje da pise dnevnik, a mi na taj nacin otkrivamo kompleksnu prirodu njegovog identiteta');
  bookCommentsEmpty = BookCommented()
    ..bookUrl = "umbertoeco.png"
    ..comments = []
    ..starsGiven = []
    ..userNames = [];
  commentBox.put(bookCommentsEmpty.bookUrl, bookCommentsEmpty);
  usersBox.put("user", buyer);
  usersBox.put("ana", buyer2);
  usersBox.put("milan", buyer3);
  usersBox.put("prod", seller);
  bookList.forEach((element) {
    shelf.put(element.bookUrl, element);
  });
  final relations = Boxes.getUserBookRelations();
  relations.put(
      "user",
      UserBookRelation()
        ..username = "user"
        ..bookUrls = ["umbertoeco.png", "littleprince.jpg"]);
  relations.put(
      "ana",
      UserBookRelation()
        ..username = "ana"
        ..bookUrls = []);
  relations.put(
      "milan",
      UserBookRelation()
        ..username = "milan"
        ..bookUrls = []);
  relations.put(
      "prod",
      UserBookRelation()
        ..username = "prod"
        ..bookUrls = []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
