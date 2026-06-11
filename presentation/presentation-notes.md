# Motivation

- projekt je zadan spolecnosti embraer, ktera dela systemy do letadel
- idea je takova, ze lidi z embraeru vyprodukuji kod a k nemu requirementy a k tomu test casy
- a potom requirementy a test casy do naseho systemu a system jim rekne, jak moc test casy pokryvaji requirement, pripadne ktere test casy chybi

# Pipeline

- pozadavky na tento system explicitne zminuji pouziti LLM
- protoze jak vime, tak LLM neumi zatim uplne spolehlive pracovat s logikou a asi by nebylo uplne dobre a spolehlive, kdybychom po nich chteli vyprodukovat primo chybejici test casy, tak jsme usoudili, ze by bylo dobre mit nejaky formalismus, do ktereho by se napred ty pozadavky a test casy prevedly, nasledne toto by se pripadne prevedlo do nejake LTL logiky nebo automatu a pouzily by se standartni metody na analyzu toho, ktere test casy chybi a jake je pokryti
- tady je ta pipelina znazornena -- ostatni budou mit asi jeste detailnejsi obrazek -- ale tady je to high level
  - mame tedy requirement v natural language
  - mame test case v natural language
  - a mame specifikaci formalismu
  - toto vsechno nasypeme do LLM, ktery to zpracuje a doufejme, ze vyprodukuje requirement a k nemu i test casy zapsane v tom formalismu
  - tento formalismus se teda nasledne prevede do nejakeho inputu podporovaneho coverage checkerem nebo podobnymi nastroji
- vyhodou toho formalismu je, za jakmile mame ten zapis, tak to ma jasnou semantiku a lze to deterministicky prevest teda na nejaky ten input do coverage checkeru
- moje prace se zamerovala prave na definici tohoto formalismu

# Proc si myslime, ze je dulezite mit ten formalismus

- teoreticky protoze je to bliz anglictine, nez nejake implikace a operatory v LTL logice, tak by to LLMko mohlo prevest do formalismu s vetsi presnosti
- pomoci toho formalismu muzeme definovat nejake abstrakce, se kterymi se tomu LLMku bude lepe pracovat
- je to jasne definovane, takze s tim muzeme dale deterministicky pracovat
- je to citelne i pro lidi
- spojuje requirementy a test casy spolecnymi prvky
- existuji clanky, kde se requirementy snazili prevadet primo do LTL, ale delalo to semanticke chyby

# Requirement example

- motivacni priklad
- software ma spadnout do emergency modu, pokud nastanou failures dvakrat v 10 sekundach behem 20 ms
- temporalni konstrukt -- 20 zabezpecuje dusledek, 20 ms
- pricina, dusledek
- pokud v nejakem case -- ktery se dosadi -- nastane nejaky event a v poslednich 10 sekundach je to podruhe, tak ma platit dusledek temporalniho konstruktu

# Test case example

- trojice
  - setup
  - stimuli
  - assertions
- vyprodukuje nejaky konkretni trace
  - kazdy stimulus ma za nasledek nejaky effect predicate -- tedy predikat, co plati po vykonani stimulu
- stimulus je n-tice
  - cas vykonani
  - operace
    - vzdycky vykonana na nejake entite (event trigger)
    - funkce s argumenty entita a dalsimi argumenty

# Ideas behind coverage checking

- jak teoreticky muzeme zkontrolovat, kterou cast requirementu test case pokryva?
- musime si uvedomit, ze vnitrni cast requirementu se musi zkontrolovat pro vsechny casy t
- kvuli stimuli v test casu plati cervene oznaceny predikat v case 10
  - vime tedy, ze tento test case manipuluje s touto casti requirementu, protoze se jeho hodnota meni v case, takze vime, ze urcita kombinace predikatu na leve strane requirementu je pokryta timto test casem
  - muzeme zkontrolovat, jestli existuji i dalsi test casy, ktere by nastavily ostatni casti klauzule do true
  - muzeme se divat na hranicni hodnoty podle toho, jak jsou definovane jednotlive predikaty a zkoumat, jestli mame test casy pro vsechny hranicni hodnoty
  - ------------
  - dale muzeme zkontrolovat, jestli test case obsahuje spravnou aserci
    - CausesWithin je v podstate definovano jako implikace
    - lze videt, ze HasHappened implikuje to, ze existuje cas mensi nez 10.019, kde Happening na tomto eventu je true
    - tento konkretni predikat v aserci tedy implikuje tento konkretni dusledek v CausesWithin
    - takze pokud by byl predikat v aserci true, tak potom kvuli teto implikaci plati i prava strana temporalniho konstruktu
    - a to nam rika, ze tento test case spravne kontroluje dusledek v requirementu
  
# Formalism layers

- diskretni, spojity cas
- entita je trojice
  - id pro referencovani uvnitr predikatu
  - typ -- spojene s urcitymi typy operaci
  - funkce mapujici modifiers (atributy) na jejich hodnoty
    - mame nejakou entitu typu storage
    - tak jestli je storage volatile, nebo jakou ma adresu
  - entity maji hodnotu v kazdem case
  - eventy -- entity, ktere maji hodnotu boolean podle toho, jestli se v nejakem case deji
  - valuation -- stav vsech entity v nejakem case
  - trace -- mapuje cas na konkretni valuace
  - operace
    - pouzite stimuli
    - produkuji effect predikaty -- predikaty, platici po nejakem case
  - predikaty
  - funkce
  - temporalni konstrukty
  - requirement
  - test case

