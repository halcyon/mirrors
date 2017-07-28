
# Едноредовите коментари започват със знака диез.

#### Стриктен режим и предупреждения

use strict;
use warnings;

# Силно препоръчително е всички скриптове и модули да включват тези редове.
# strict спира компилацията в случай на необявени предварително променливи.
# warnings показва предупредителни съобщения в случай на често допускани грешки,
# например използване на променливи без стойност в низове.

#### Типове променливи в Perl

# Променливите започват със съответен знак (sigil - от латински sigillum ),
# който представлява символ, указващ типа на променливата. Името на самата
# променлива започва с буква или знак за подчертаване (_), следван от какъвто и
# да е брой букви, цифри или знаци за подчертаване. Забележете, че ако напишете
# 'use utf8;' (без кавичките), можете да използвате всякакви букви за имена на
# променливите, включително и български.

### Perl има три главни типа променливи: $scalar (скалар), @array (масив), and %hash (хеш).

## Скалари
#  Скаларът представлява единична стойност:
my $animal = "camel";
my $answer = 42;
use utf8;
my $животно = 'камила';

# Стойностите на скаларите могат да бъдат низове, цели числа или числа с
# плаваща запетая (десетични дроби). Perl автоматично ги ползва и превръща от
# един тип стойност в друга, според както е необходимо.

## Масиви
#  Масивът представлява списък от стойности:
my @animals = ("камила", "llama", "owl");
my @numbers = (23, 42, 69);
my @mixed   = ("camel", 42, 1.23);

# Елементите на масива се достъпват като се използват квадратни скоби и $,
# който указва каква стойност ще бъде върната (скалар).
my $second = $animals[1];

## Хешове
#  Хешът представлява набор от двойки ключ/стойност:

my %fruit_color = ("ябълка", "червена", "banana", "yellow");

# Може да използвате празно пространство и оператора "=>" (тлъста запетая),
# за да ги изложите по-прегледно:

%fruit_color = (
  ябълка  => "червена",
  banana => "yellow",
);

# Елементите (стойностите) от хеша се достъпват чрез използване на ключовете.
# Ключовете се ограждат с фигурни скоби и се поставя $ пред името на хеша.
my $color = $fruit_color{ябълка};

# Скаларите, масивите и хешовете са документирани по-пълно в perldata.
# На командния ред напишете (без кавичките) 'perldoc perldata'.

#### Указатели (Референции)

# По-сложни типове данни могат да бъдат създавани чрез използване на указатели,
# които ви позволяват да изграждате масиви и хешове в други масиви и хешове.

my $array_ref = \@array;
my $hash_ref = \%hash;
my @array_of_arrays = (\@array1, \@array2, \@array3);

# Също така можете да създавате безименни масиви и хешове, към които сочат само
# указатели.

my $fruits = ["apple", "banana"];
my $colors = {apple => "red", banana => "yellow"};

# Можете да достигате до безименните структури като поставяте отпред съответния
# знак на структурата, която искате да достъпите (дереферирате).

my @fruits_array = @$fruits;
my %colors_hash = %$colors;

# Можете да използвате оператора стрелка (->), за да достигнете до отделна
# скаларна стойност.

my $first = $array_ref->[0];
my $value = $hash_ref->{banana};

# Вижте perlreftut и perlref, където ще намерите по-задълбочена документация за
# указателите (референциите).

#### Условни изрази и цикли

# В Perl ще срещнете повечето от обичайните изрази за условия и обхождане (цикли).

if ($var) {
  ...
} elsif ($var eq 'bar') {
  ...
} else {
  ...
}

unless (условие) {
  ...
}
# Това е друг, по-четим вариант на "if (!условие)"

# Perl-овския начин след-условие
print "Yow!" if $zippy;
print "Нямаме банани" unless $bananas;

#  докато
while (условие) {
  ...
}


# цикли for и повторение
for (my $i = 0; $i < $max; $i++) {
  print "index is $i";
}

for (my $i = 0; $i < @elements; $i++) {
  print "Current element is " . $elements[$i];
}

for my $element (@elements) {
  print $element;
}

# мълчаливо - използва се подразбиращата се променлива $_.
for (@elements) {
  print;
}

# Отново Perl-овския начин след-
print for @elements;

# отпечатване на стойностите чрез обхождане ключовете на указател към хеш
print $hash_ref->{$_} for keys %$hash_ref;

#### Регулярни (обикновени) изрази

# Поддръжката на регулярни изрази  е залеганала дълбоко в Perl. Задълбочена
# документация ще намерите в perlrequick, perlretut и на други места.
# Но ето накратко:

# Просто съвпадение
if (/foo/)       { ... }  # истина ако $_ съдържа "foo"
if ($x =~ /foo/) { ... }  # истина ако $x съдържа "foo"

# Просто заместване

$x =~ s/foo/bar/;         # замества foo с bar в $x
$x =~ s/foo/bar/g;        # Замества ВСИЧКИ ПОЯВИ на foo с bar в $x


#### Файлове и Вход/Изход (I/O)

# Можете да отворите файл за въвеждане на данни в него или за извеждане на
# данни от него като използвате функцията "open()".

open(my $in,  "<",  "input.txt")  or die "Не мога да отворя input.txt: $!";
open(my $out, ">",  "output.txt") or die "Can't open output.txt: $!";
open(my $log, ">>", "my.log")     or die "Can't open my.log: $!";

# Можете да четете от отворен файлов манипулатор като използвате оператора
# "<>". В скаларен контекст той чете по един ред от файла наведнъж, а в списъчен
# контекст изчита всички редове от файла наведнъж като присвоява всеки ред на
# масива:

my $line  = <$in>;
my @lines = <$in>;

#### Подпрограми (функции)

# Да се пишат подпрограми е лесно:

sub logger {
  my $logmessage = shift;

  open my $logfile, ">>", "my.log" or die "Could not open my.log: $!";

  print $logfile $logmessage;
}

# Сега можем да ползваме подпрограмата като всяка друга вградена функция:

logger("Имаме подпрограма, която пише във файл-отчет!");

#### Модули

# Модулът е набор от програмен код на Perl, обикновено подпрограми, който може
# да бъде използван в друг програмен код на Perl. Обикновено се съхранява във
# файл с разширение .pm, така че perl (програмата) да може лесно да го разпознае.

# В MyModule.pm
package MyModule;
use strict;
use warnings;

sub trim {
  my $string = shift;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string;
}

1;

# От другаде:

use MyModule;
MyModule::trim($string);

# Чрез модула Exporter може да направите функциите си износни, така че други
# програми да могат да ги внасят (импортират).
# Такива функции се използват така:

use MyModule 'trim';
trim($string);

# Много Perl-модули могат да се свалят от CPAN (http://www.cpan.org/). Те
# притежават редица полезни свойства, които ще ви помогнат да си свършите работа
# без да откривате колелото. Голям брой известни модули като Exporter са включени
# в дистрибуцията на самия Perl. Вижте perlmod  за повече подробности, свързани с
# модулите в Perl.

#### Обекти

# Обектите в Perl са просто референции, които знаят на кой клас (пакет)
# принадлежат. По този начин методите (подпрограми), които се извикват срещу
# тях могат да бъдат намерени в съответния клас. За да се случи това, в
# конструкторите (обикновено new) се използва вградената функция
# bless. Ако използвате обаче модули като Moose или Moo, няма да ви се налага
# сами да извиквате bless (ще видите малко по-долу).

package MyCounter;
use strict;
use warnings;

sub new {
  my $class = shift;
  my $self = {count => 0};
  return bless $self, $class;
}

sub count {
  my $self = shift;
  return $self->{count};
}

sub increment {
  my $self = shift;
  $self->{count}++;
}

1;

# Методите могат да се извикват на клас или на обект като се използва оператора 
# стрелка (->).

use MyCounter;
my $counter = MyCounter->new;
print $counter->count, "\n"; # 0
$counter->increment;
print $counter->count, "\n"; # 1

# Модулите Moose и Moo от CPAN  ви помагат леснот да създавате класове. Те
# предоставят готов конструктор (new) и прост синтаксис за деклариране на
# свойства на обектите (attributes). Този клас може да се използва по същия начин
# като предишния по-горе.

package MyCounter;
use Moo; # внася strict и warnings

has 'count' => (is => 'rwp', default => 0, init_arg => undef);

sub increment {
  my $self = shift;
  $self->_set_count($self->count + 1);
}

1;

# Обектно-ориентираното програмиране е разгледано по-задълбочено в perlootut,
# а изпълнението му на ниско ниво в Perl е обяснено в perlobj.
