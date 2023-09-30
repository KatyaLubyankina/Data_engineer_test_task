### Задание 1
У вас SQL база с таблицами магазина, который существует много лет:
1) Users(userId, age)
2) Purchases (purchaseId, userId, itemId, date)
3) Items (itemId, price).

Напишите SQL запросы для расчета следующих метрик:

А) какую сумму в среднем в месяц тратит:
- пользователи в возрастном диапазоне от 18 до 25 лет включительно
- пользователи в возрастном диапазоне от 26 до 35 лет включительно
Б) в каком месяце года выручка от пользователей в возрастном диапазоне 35+ самая большая
В) какой товар обеспечивает дает наибольший вклад в выручку за последний год
Г) топ-3 товаров по выручке и их доля в общей выручке за любой год

### Решение 1
Решение каждого пункта представлено в отдельном файле Task.sql. Для просмотра решения можно клонировать репозиторий.
```Shell
git clone https://github.com/KatyaLubyankina/Data_engineer_test_task.git
```
Перейти в директорию с репозиторием.
```
cd Data_engineer_test_task
```
### Комментарии к задаче 1
1. Все решения представлены в виде готовых SQL запросов.
2. В таблицах я выбрала следующие форматы
- date - DATE
- price - DECIMAL(12,2)
Остальное - INTEGER.
3. В задании Г можно по-разному воспринимать условия. Я нашла за каждый год топ-3 товара по выручке.
### Задание 2
С сайта dzen news (https://dzen.ru/news) необходимо
собрать краткий текст и названия всех статей за последний месяц (на момент выполнения) с ключевым словом "игра".
Затем для полученных статей необходимо рассчитать топ-50 наиболее частотных слов и представить их в виде word (tag) cloud.
Данное задание необходимо выполнить с помощью python.
Для представления в виде word cloud можно использовать уже существующие библиотеки.

### Решение 2
Решение тестового задания находится в файле wordcloud.py в репозитории с первой задачей.
Для запуска решения можно клонировать репозиторий, если это не было сделано в первой задаче.
```Shell
git clone https://github.com/KatyaLubyankina/Data_engineer_test_task.git
```
Перейти в директорию с репозиторием.
```
cd Data_engineer_test_task
```
Перед запуском необходимо установить библиотеки из requirements.txt командой
```Shell
pip install -r requirements.txt
```
Теперь можно запускать решение и увидеть wordcloud.
```Shell
python dzenwordcloud.py
```
### Комментарии к задаче 2
В задании необходимо было рассмотреть все публикации на сайте за последний месяц, однако на данном сайте представлены только свежие статьи по данной рубрике (максимум несколько дней назад), поэтому фильтр на дату не был поставлен. 
Не было возможности на сайте hh задать вопрос по этому поводу без отправки решения.
