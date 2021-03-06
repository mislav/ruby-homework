# Разпарчетосване

Из [третото предизвикателство](/challenges/3):

> Понеже ви казахме, че Monkey patching-а е нещо, което трябва да се избягва
> по принцип, решихме отново да ви накараме да го приложите. :-)

С цел да не ви става навик, отново ви даваме Monkey patching :-)

Дефинирайте метод `Enumerable#split_up`, който приема следните keyword аргументи:

* `length:` - задължителен.
* `step:` - по подразбиране равен на стойността на параметъра `length`.
* `pad:` - по подразбиране празен списък.

Връща `Array`, съдържащ списъци (парчета) от по `length` елемента всеки:

    1.upto(10).split_up(length: 3)
    => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]

Ако `step` е подаден, то елементите за всяко следващо парче започват да се
взимат от позиция със стъпка `step`. По подразбиране `step` е равно на `length`:

    1.upto(10).split_up(length: 2, step: 4)
    => [[1, 2], [5, 6], [9, 10]]

Ако се подаде списък `pad`, то елементите му се използват за плънка към
последното парче, ако не му достигат елементи. В случай, че в `pad` няма
достатъчно елементи, се връща парче с по-малко от `length` елемента:

    1.upto(10).split_up(length: 3, pad: [:a, :b, :c])
    => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, :a, :b]]

### Детайли

* Ако `pad` не е подаден и последното парче е с по-малко от `length` елемента,
то парчето остава както си е.

        1.upto(10).split_up(length: 2, step: 3)
        => [[1, 2], [4, 5], [7, 8], [10]]

* Методът трябва да работи и ако му бъде подаден блок, като на блока се
`yield`-ва всяко парче от резултатната последователност. В този случай, върнатата
стойност от `split_up` не се променя по никакъв начин, освен ако съзнателно не
мутирате `yield`-нато парче в блока. Например, ако го извикаме
по следния начин:

        1.upto(5).split_up(length: 2) { |slice| puts 'Got ' + slice.inspect }

    Ще очакваме целият израз да изведе на екрана следното, като след това
    върне `[[1, 2], [3, 4], [5]]`:

        Got [1, 2]
        Got [3, 4]
        Got [5]

* Понеже е в `Enumerable`, методът ще се вика върху колекции. Ще тестваме за
хеш и списък.

* Методът няма да се вика с `length` > `step`.

### Още примери

    1.upto(10).split_up(length: 2, step: 3, pad: [:a, :b, :c])
    => [[1, 2], [4, 5], [7, 8], [10, :a]]

    1.upto(10).split_up(length: 2)
    => [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]]

    { one: 1, two: 2, three: 3, four: 4 }.split_up(length: 2)
    => [[[:one, 1], [:two, 2]], [[:three, 3], [:four, 4]]]
