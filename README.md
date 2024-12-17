## Авторы
1. **Имайкин Егор Евгеньевич**, [im_egorrrr](https://t.me/im_egorrrr)
2. **Лебедев Никита Александрович**, [nikit_lebedev](https://t.me/nikit_lebedev)
3. **Труфанов Дмитрий Михайлович**, [dimi3_tru](https://t.me/dimi3_tru)
4. **Смирнов Арсений Сергеевич**, [ars_kko](https://t.me/ars_kko)

Группа мФТиАД231

Из Дз 3:

Во время выполнения 3дз были обнаружены недочеты во 2дз, поэтому использовал сырые данные из таблиц первой дз (в дальнейшем реализуем на 2дз).

Был поднят airflow, собраны витрины в presentation, настроено их автоматическое обновление ежедневно после полуночи.

Чтобы запустить:
1) docker-compose up
  
2) В airflow http://localhost:8080 (airflow, airflow) добавить подключение posgres_master


Дз 4:

- Был обновлен файл docker-compose.yml для работы с инструментом Grafana
- Был создан файл для заполнения таблиц нашей базы данных по реализованной в 3 дз структуре
- Были созданы 2 дэшборда в Grafana

Чтобы запустить:
1) Из нашей папки -> docker-compose up -d

2) docker cp generate_data.sql postgres_master:/tmp/generate_data.sql (файл для записи данных в БД отправляем в докер)

3) docker exec -it postgres_master psql -U postgres -d postgres -f /tmp/generate_data.sql (выполняем скрипт из файла)

4) Переходим по ссылке http://localhost:3000 для просмотра дэшбордов

Видео-презентация результатов по ссылке: https://disk.yandex.ru/d/TdUM00QG4cKcNw
