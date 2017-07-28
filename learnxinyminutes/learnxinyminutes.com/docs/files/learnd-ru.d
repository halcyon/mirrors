
// Welcome to D! Это однострочный комментарий

/* многострочный
   комментарий  */

/+
    // вложенные комментарии

    /* еще вложенные
       комментарии */

    /+
        // мало уровней вложенности? Их может быть сколько угодно.
    +/
+/

/*
    Имя модуля. Каждый файл с исходным кодом на D — модуль.
    Если имя не указано явно, то предполагается, что оно совпадает с именем
    файла. Например, для файла "test.d" имя модуля будет "test", если явно
    не указать другое
 */
module app;

// импорт модуля. Std — пространство имен стандартной библиотеки (Phobos)
import std.stdio;

// можно импортировать только нужные части, не обязательно модуль целиком
import std.exception : enforce;

// точка входа в программу — функция main, аналогично C/C++
void main()
{
    writeln("Hello, world!");
}



/*** типы и переменные ***/

int a; // объявление переменной типа int (32 бита)
float b = 12.34; // тип с плавающей точкой
double c = 56.78; // тип с плавающей точкой (64 бита)

/*
    Численные типы в D, за исключением типов с плавающей точкой и типов
    комплексных чисел, могут быть беззнаковыми.
    В этом случае название типа начинается с префикса "u"
*/
uint d = 10; ulong e = 11;
bool b = true; // логический тип
char d = 'd';  // UTF-символ, 8 бит. D поддерживает UTF "из коробки"
wchar e = 'é';   // символ UTF-16
dchar f;       // и даже UTF-32, если он вам зачем-то понадобится

string s = "для строк есть отдельный тип, это не просто массив char-ов из Си";
wstring ws = "поскольку у нас есть wchar, должен быть и  wstring";
dstring ds = "...и dstring, конечно";

string кириллица = "Имена переменных должны быть в Unicode, но не обязательно на латинице.";

typeof(a) b = 6; // typeof возвращает тип своего выражения.
                 // В результате, b имеет такой же тип, как и a

// Тип переменной, помеченной ключевым словом auto,
// присваивается компилятором исходя из значения этой переменной
auto x = 1;              // Например, тип этой переменной будет int.
auto y = 1.1;            // этой — double
auto z = "Zed is dead!"; // а этой — string

int[3] arr = [1, 2, 3]; // простой одномерный массив с фиксированным размером
int[] arr2 = [1, 2, 3, 4]; // динамический массив
int[string] aa = ["key1": 5, "key2": 6]; // ассоциативный массив

/*
   Строки и массивы в D — встроенные типы. Для их использования не нужно
   подключать ни внешние, ни даже стандартную библиотеку, хотя в последней
   есть множество дополнительных инструментов для работы с ними.
 */
immutable int ia = 10;  // неизменяемый тип,
                        // обозначается ключевым словом immutable
ia += 1;                // — вызовет ошибку на этапе компиляции

// перечислимый (enumerable) тип,
// более правильный способ работы с константами в D
enum myConsts = { Const1, Const2, Const3 };

// свойства типов
writeln("Имя типа               : ", int.stringof); // int
writeln("Размер в байтах        : ", int.sizeof);   // 4
writeln("Минимальное значение   : ", int.min);      // -2147483648
writeln("Максимальное значение : ", int.max);      // 2147483647
writeln("Начальное значение     : ", int.init);     // 0. Это значение,
                                                    // присвоенное по умолчанию

// На самом деле типов в D больше, но все мы здесь описывать не будем,
// иначе не уложимся в Y минут.



/*** Приведение типов ***/

// to!(имя типа)(выражение) - для большинства конверсий
import std.conv : to; // функция "to" - часть стандартной библиотеки, а не языка
double d = -1.75;
short s = to!short(d); // s = -1

/*
   cast - если вы знаете, что делаете. Кроме того, это единственный способ
   преобразования типов-указателей в "обычные" и наоборот
*/
void* v;
int* p = cast(int*)v;

// Для собственного удобства можно создавать псевдонимы
// для различных встроенных объектов
alias int newInt; // теперь можно обращаться к newInt так, как будто бы это int
newInt a = 5;

alias newInt = int; // так тоже допустимо
alias uint[2] pair; // дать псевдоним можно даже сложным структурам данных



/*** Операторы ***/

int x = 10; // присваивание
x = x + 1;  // 11
x -= 2;     // 9
x++;        // 10
++x;        // 11
x *= 2;     // 22
x /= 2;     // 11
x = x ^^ 2; // 121 (возведение в степень)
x ^^= 2;    // 1331 (то же самое)

string str1 = "Hello";
string str2 = ", world!";
string hw = str1 ~ str2; // Конкатенация строк

int[] arr = [1, 2, 3];
arr ~= 4; // [1, 2, 3, 4] - добавление элемента в конец массива



/*** Логика и сравнения ***/

int x = 0; int y = 1;

x == y;         // false
x > y;          // false
x < y;          // true
x >= y;         // false
x != y;         // true. ! — логическое "не"
x > 0 || x < 1; // true. || — логическое "или"
x > 0 && x < 1; // false && — логическое "и"
x ^ y           // true; ^ - xor (исключающее "или")

// Тернарный оператор
auto y = (x > 10) ? 1 : 0; // если x больше 10, то y равен 1,
                           // в противном случае y равен нулю


/***  Управляющие конструкции  ***/

// if - абсолютно привычен
if (a == 1) {
    // ..
} else if (a == 2) {
    // ..
} else {
    // ..
}

// switch
switch (a) {
    case 1:
        // делаем что-нибудь
        break;
    case 2:
        // делаем что-нибудь другое
        break;
    case 3:
        // делаем что-нибудь еще
        break;
    default:
        // default обязателен, без него будет ошибка компиляции
        break;
}

// в D есть констукция "final switch". Она не может содержать секцию "defaul"
// и применяется, когда все перечисляемые в switch варианты должны быть
// обработаны явным образом

int dieValue = 1;
final switch (dieValue) {
    case 1:
        writeln("You won");
        break;

    case 2, 3, 4, 5:
        writeln("It's a draw");
        break;

    case 6:
        writeln("I won");
        break;
}

// while
while (a > 10) {
    // ..
    if (number == 42) {
        break;
    }
}

while (true) {
    // бесконечный цикл
}

// do-while
do {
    // ..
} while (a == 10);

// for
for (int number = 1; number < 11; ++number) {
    writeln(number); // все абсолютно стандартно
}

for ( ; ; ) {
    // секции могут быть пустыми. Это бесконечный цикл в стиле Си
}

// foreach - универсальный и самый "правильный" цикл в D
foreach (element; array) {
    writeln(element); // для простых массивов
}

foreach (key, val; aa) {
    writeln(key, ": ", val); // для ассоциативных массивов
}

foreach (c; "hello") {
    writeln(c); // hello. Поскольку строки - это вариант массива,
                // foreach применим и к ним
}

foreach (number; 10..15) {
    writeln(number); // численные интервалы можно указывать явным образом
                     // этот цикл выведет значения с 10 по 14, но не 15,
                     // поскольку диапазон не включает в себя верхнюю границу
}

// foreach_reverse - в обратную сторону
auto container = [1, 2, 3];
foreach_reverse (element; container) {
    writefln("%s ", element); // 3, 2, 1
}

// foreach в массивах и им подобных структурах не меняет сами структуры
int[] a = [1, 2 ,3 ,4 ,5];
foreach (elem; array) {
    elem *= 2; // сам массив останется неизменным
}

writeln(a); // вывод: [1, 2, 3, 4, 5] Т.е изменений нет

// добавление ref приведет к тому, что массив будет изменяться
foreach (ref elem; array) {
    elem *= 2;
}

writeln(a); // [2, 4, 6, 8, 10]

// foreach умеет рассчитывать индексы элементов
int[] a = [1, 2, 3, 4, 5];
foreach (ind, elem; array) {
    writeln(ind, " ", elem); // через ind - доступен индекс элемента,
                             // а через elem - сам элемент
}



/*** Функции ***/

test(42); // Что, вот так сразу? Разве мы где-то уже объявили эту функцию?

// Нет, вот она. Это не Си, здесь объявление функции не обязательно должно быть
// до первого вызова
int test(int argument) {
    return argument * 2;
}


// В D используется единый синтаксис вызова функций
// (UFCS, Uniform Function Call Syntax), поэтому так тоже можно:
int var = 42.test();

// и даже так, если у функции нет аргументов:
int var2 = 42.test;

// можно выстраивать цепочки:
int var3 = 42.test.test;

/*
    Аргументы в функцию передаются по значению (т.е. функция работает не с
    оригинальными значениями, переданными ей, а с их локальными копиями.
    Исключение составляют объекты классов, которые передаются по ссылке.
    Кроме того, любой параметр можно передать в функцию по ссылке с помощью
    ключевого слова "ref"
*/
int var = 10;

void fn1(int arg) {
    arg += 1;
}

void fn2(ref int arg) {
    arg += 1;
}

fn1(var); // var все еще = 10
fn2(var); // теперь var = 11

// Возвращаемое значение тоже может быть auto,
// если его можно "угадать" из контекста
auto add(int x, int y) {
    return x + y;
}

auto z = add(x, y); // тип int - компилятор вывел его автоматически

// Значения аргументов по умолчанию
float linearFunction(float k, float x, float b = 1)
{
    return k * x + b;
}

auto linear1 = linearFunction(0.5, 2, 3); // все аргументы используются
auto linear2 = linearFunction(0.5, 2);    // один аргумент пропущен, но в функции
                                          // он все равно использован и равен 1

// допускается описание вложенных функций
float quarter(float x) {
    float doubled(float y) {
        return y * y;
    }

    return doubled(doubled(x));
}

// функции с переменным числом аргументов
int sum(int[] a...)
{
    int s = 0;
    foreach (elem; a) {
        s += elem;
    }
    return s;
}

auto sum1 = sum(1);
auto sum2 = sum(1,2,3,4);

/*
   модификатор "in" перед аргументами функций говорит о том, что функция имеет
    право их только просматривать. При попытке модификации такого аргумента
    внутри функции - получите ошибку
*/
float printFloat(in float a)
{
    writeln(a);
}
printFloat(a); // использование таких функций - самое обычное

// модификатор "out" позволяет вернуть из функции несколько результатов
// без посредства глобальных переменных или массивов
uint remMod(uint a, uint b, out uint modulus)
{
    uint remainder = a / b;
    modulus = a % b;
    return remainder;
}

uint modulus;                   // пока в этой переменной ноль
uint rem = remMod(5, 2, modulus); // наша "хитрая" функция, и теперь
                                // в modulus - остаток от деления
writeln(rem, " ", modulus);     // вывод: 2 1



/*** Структуры, классы, базовое ООП ***/

// Объявление структуры. Структуры почти как в Си
struct MyStruct {
    int a;
    float b;

    void multiply() {
        return a * b;
    }
}

MyStruct str1; // Объявление переменной с типом MyStruct
str1.a = 10;   // Обращение к полю
str1.b = 20;
auto result = str1.multiply();
MyStruct str2 = {4, 8}          // Объявление + инициализация  в стиле Си
auto str3 = MyStruct(5, 10);    // Объявление + инициализация  в стиле D


// области видимости полей и методов - 3 способа задания
struct MyStruct2 {
    public int a;

    private:
        float b;
        bool c;

    protected {
        float multiply() {
            return a * b;
        }
    }
    /*
        в дополнение к знакомым public, private и protected, в D есть еще
        область видимости "package". Поля и методы с этим атрибутом будут
        доступны изо всех модулей, включенных в "пакет" (package), но не
        за его пределами. package - это "папка", в которой может храниться
        несколько модулей. Например, в "import.std.stdio", "std" - это
        package, в котором есть модуль stdio (и еще множество других)
    */
    package:
        string d;

    /* помимо этого, имеется еще один модификатор - export, который позволяет
    использовать объявленный с ним идентификатор даже вне самой программы !
    */
    export:
         string description;
}

// Конструкторы и деструкторы
struct MyStruct3 {
    this() { // конструктор. Для структур его не обязательно указывать явно,
             // в этом случае пустой конструктор добавляется компилятором
        writeln("Hello, world!");
    }


    // а вот это конструкция - одна из интересных идиом и представляет собой
    // конструктор копирования, т.е конструктор, возвращающий копию структуры.
    // Работает только в структурах.
    this(this)
    {
        return this;
    }

    ~this() { // деструктор, также необязателен
        writeln("Awww!");
    }
}

// Объявление простейшего класса
class MyClass {
    int a;  // в D по умолчанию данные-члены являются public
    float b;
}

auto mc = new MyClass(); // ...и создание его экземпляра
auto mc2 = new MyClass; // ... тоже сработает

// Конструктор
class MyClass2 {
    int a;
    float b;

    this(int a, float b) {
        this.a = a; // ключевое слово "this" - ссылка на объект класса
        this.b = b;
    }
}

auto mc2 = new MyClass2(1, 2.3);

// Классы могут быть вложенными
class Outer
{
    int m;

    class Inner
    {
        int foo()
        {
            return m; // можно обращаться к полям "внешнего" класса
        }
    }
}

// наследование
class Base {
    int a = 1;
    float b = 2.34;


    // это статический метод, т.е метод который можно вызывать, обращаясь
    // к классу напрямую, а не через создание экземпляра объекта
    static void multiply(int x, int y)
    {
        writeln(x * y);
    }
}

Base.multiply(2, 5); // используем статический метод. Результат: 10

class Derived : Base {
    string c = "Поле класса - наследника";


    // override означает то, что наследник предоставит свою реализацию метода,
    // переопределив метод базового класса
    override static void multiply(int x, int y)
    {
        super.multiply(x, y);  // super - это ссылка на класс-предок, или базовый класс
        writeln(x * y * 2);
    }
}

auto mc3 = new Derived();
writeln(mc3.a); // 1
writeln(mc3.b); // 2.34
writeln(mc3.c); // Поле класса - наследника

// Финальный класс, наследовать от него нельзя
// кроме того, модификатор final работает не только для классов, но и для методов
// и даже для модулей !
final class FC {
    int a;
}

class Derived : FC { // это вызовет ошибку
    float b;
}

// Абстрактный класс не может быть истанциирован, но может иметь наследников
abstract class AC {
    int a;
}

auto ac = new AC(); // это вызовет ошибку

class Implementation : AC {
    float b;

     // final перед методом нефинального класса означает запрет возможности
     // переопределения метода
    final void test()
    {
       writeln("test passed !");
    }
}

auto impl = new Implementation(); // ОК



/*** Примеси (mixins) ***/

// В D можно вставлять код как строку, если эта строка известна на этапе
// компиляции. Например:
void main() {
   mixin(`writeln("Hello World!");`);
}

// еще пример
string print(string s) {
   return `writeln("` ~ s ~ `");`;
}

void main() {
   mixin (print("str1"));
   mixin (print("str2"));
}



/*** Шаблоны ***/

/*
    Шаблон функции. Эта функция принимает аргументы разных типов, которые
    подставляются вместо T на этапе компиляции. "T" - это не специальный
    символ, а просто буква. Вместо "T" может быть любое слово, кроме ключевого.
 */
void print(T)(T value) {
   writefln("%s", value);
}

void main() {
   print(42);     // В одну и ту же функцию передается: целое
   print(1.2);    // ...число с плавающей точкой,
   print("test"); // ...строка
}

// "Шаблонных" параметров может быть сколько угодно
void print(T1, T2)(T1 value1, T2 value2) {
   writefln(" %s %s", value1, value2);
}

void main() {
   print(42, "Test");
   print(1.2, 33);
}

// Шаблон класса
class Stack(T)
{
    private:
        T[] elements;

    public:
        void push(T element) {
            elements ~= element;
        }

        void pop() {
            --elements.length;
        }

        T top() const @property {
            return elements[$ - 1];
        }

        size_t length() const @property {
            return elements.length;
        }
}

void main() {
    /*
        восклицательный знак - признак шаблона. В данном случае мы создаем
        класс и указываем, что "шаблонное" поле будет иметь тип string
    */
   auto stack = new Stack!string;

   stack.push("Test1");
   stack.push("Test2");

   writeln(stack.top);
   writeln(stack.length);

   stack.pop;
   writeln(stack.top);
   writeln(stack.length);
}



/*** Диапазоны (ranges) ***/

/*
   Диапазоны - это абстракция, которая позволяет легко использовать разные
   алгоритмы с разными структурами данных. Вместо того, чтобы определять свои
   уникальные алгоритмы для каждой структуры, мы можем просто указать для нее
   несколько единообразных функций, определяющих, _как_ мы получаем доступ
   к элементам контейнера, вместо того, чтобы описывать внутреннее устройство
   этого контейнера. Сложно? На самом деле не очень.

    Простейший вид диапазона - Input Range. Для того, чтобы превратить любой
    контейнер в Input Range, достаточно реализовать для него 3 метода:
    - empty - проверяет, пуст ли контейнер
    - front - дает доступ к первому элементу контейнера
    - popFront - удаляет из контейнера первый элемент
*/
struct Student
{
    string name;
    int number;
    string toString() {
        return format("%s(%s)", name, number);
    }
}

struct School
{
    Student[] students;
}

struct StudentRange
{
    Student[] students;

    this(School school) {
        this.students = school.students;
    }

    bool empty() {
        return students.length == 0;
    }

    Student front() {
        return students[0];
    }

    void popFront() {
        students = students[1 .. $];
    }
}

void main(){
    auto school = School([
            Student("Mike", 1),
            Student("John", 2) ,
            Student("Dan", 3)
    ]);
    auto range = StudentRange(school);
    writeln(range);                     // [Mike(1), John(2), Dan(3)]
    writeln(school.students.length);    // 3
    writeln(range.front());             // Mike(1)
    range.popFront();
    writeln(range.empty());             // false
    writeln(range);                     // [John(2), Dan(3)]
}
/*
   Смысл в том, что нам не так уж важно внутреннее устройство контейнера, если
   у нас есть унифицированные методы доступа к его элементам.
   Кроме Input Range в D есть и другие типы диапазонов, которые требуют
   реализации большего числа методов, зато дают больше контроля. Это большая
   тема и мы не будем в подробностях освещать ее здесь.

   Диапазоны - это важная часть D, они используются в нем повсеместно.
*/
