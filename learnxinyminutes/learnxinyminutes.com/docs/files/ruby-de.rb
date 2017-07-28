
3.class #=> Fixnum
3.to_s #=> "3"

1 + 1 #=> 2
8 - 1 #=> 7
10 * 2 #=> 20
35 / 5 #=> 7
2**5 #=> 32

1.+(3) #=> 4
10.* 5 #=> 50

nil # Nothing to see here
true # truth
false # falsehood

nil.class #=> NilClass
true.class #=> TrueClass
false.class #=> FalseClass

1 == 1 #=> true
2 == 1 #=> false

1 != 1 #=> false
2 != 1 #=> true

!nil   #=> true
!false #=> true
!0     #=> false

1 < 10 #=> true
1 > 10 #=> false
2 <= 2 #=> true
2 >= 2 #=> true

true && false #=> false
true || false #=> true
!true #=> false

'I am a string'.class #=> String
"I am a string too".class #=> String


platzhalter = 'Ruby'
"Ich kann in #{placeholder} Platzhalter mit doppelten Anführungsstrichen füllen."

'hello ' + 'world'  #=> "hello world"
'hello ' + 3 #=> TypeError: can't convert Fixnum into String

'hello ' + 3.to_s #=> "hello 3"

puts "I'm printing!"

x = 25 #=> 25
x #=> 25

x = y = 10 #=> 10
x #=> 10
y #=> 10

snake_case = true

path_to_project_root = '/good/name/'
path = '/bad/name/'

:pending.class #=> Symbol
status = :pending
status == :pending #=> true
status == 'pending' #=> false
status == :approved #=> false

array = [1, 2, 3, 4, 5] #=> [1, 2, 3, 4, 5]

[1, 'hello', false] #=> [1, "hello", false]

array.[] 0 #=> 1
array.[] 12 #=> nil

array[0] #=> 1
array[12] #=> nil

array[-1] #=> 5

array[2, 3] #=> [3, 4, 5]

array[1..3] #=> [2, 3, 4]

array << 6 #=> [1, 2, 3, 4, 5, 6]
array.push(6) #=> [1, 2, 3, 4, 5, 6]

array.include?(1) #=> true


## Ein Hash anlegen


## Wert per key herausfinden


##  Symbols können auch keys sein


## Testen ob ein Key oder ein Value existiert


### Tip:  Arrays und Hashes sind Enumerable
### Und haben gemeinsame, hilfreiche Methoden wie:
### each, map, count, and more

# Kontrolstrukturen
## if

## for - Allerdings werden for Schleifen nicht oft vewendet.

## Stattdessen: "each" Methode und einen Bloch übergeben
Ein Block ist ein Codeteil, den man einer Methode übergeben kann  
Ähnelt stark lambdas, anonymen Funktionen oder Closures in anderen  
Programmiersprachen.



Die each Methode einer Range führt den Block für jedes Element der Range aus.

Dem Block wird ein "counter" parameter übergeben.

### Den Block kann man auch in geschweiften Klammern schreiben


### Each kann auch über den Inhalt von Datenstrukturen iterieren


## case


### Case können auch ranges


# exception handling:

# Funktionen

## Funktionen (und Blocks) 
## geben implizit den Wert des letzten Statements zurück


### Klammern sind optional wenn das Ergebnis nicht mehdeutig ist


### Methoden Parameter werden per Komma getrennt


## yield
### Alle Methoden haben einen impliziten, optionalen block Parameter
### Dieser wird mit dem Schlüsselword "yield" aufgerufen


## Einen Block kann man auch einer Methoden übergeben
### "&" kennzeichnet die Referenz zum übergebenen Block


### Eine Liste von Parametern kann man auch übergeben,
### Diese wird in ein Array konvertiert
### "*" kennzeichnet dies.

# Klassen
## Werden mit dem class Schlüsselwort definiert


### Konstruktor bzw. Initializer


### setter Methode

### getter Methode


#### getter können mit der attr_accessor Methode vereinfacht definiert werden


## Eine Klasse instanziieren


## Methodenaufrufe


## Eine Klassenmethode aufrufen


## Variable Gültigkeit
### Variablen die mit "$" starten, gelten global


### Variablen die mit "@" starten, gelten für die Instanz


### Variablen die mit "@@" starten, gelten für die Klasse


### Variablen die mit einem Großbuchstaben anfangen, sind Konstanten


## Class ist auch ein Objekt
### Hat also auch Instanzvariablen
### Eine Klassenvariable wird innerhalb der Klasse und Ableitungen geteilt.

### Basis Klasse


### Abgeleitete Klasse


### Eine Klasseninstanzvariable wird nicht geteilt




### Module einbinden, heisst ihre Methoden an die Instanzen der Klasse zu binden
### Module erweitern, heisst ihre Mothden an die Klasse selbst zu binden



### Callbacks werden ausgeführt, wenn ein Modul eingebunden oder erweitert wird

