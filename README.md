# mageia9-palemoon:private
Docker image for secure web surfing.  
*Примечание: Для быстрого изготовления и запуска образа используйте [DockerManager](https://github.com/AKotov-dev/docker-manager).*


**Изготовление образа mageia9-palemoon:private**
1. ПКМ (таблица образов) -> Создать образ из Dockerfile
2. Указать Новый образ: `mageia9-palemoon:tmp`
3. Вставить содержимое [Dockerfile](https://github.com/AKotov-dev/mageia9-palemoon-private/blob/main/Dockerfile) и нажать Ок:
4. Создан образ `mageia9-palemoon:tmp`
+ двойной клик, вставить команду: `--env="DISPLAY" --net=host --device=/dev/dri`
+ откроется браузер Palemoon из контейнера, установить в нём
+ прокси socks5: `127.0.0.1`, порт `9050`
+ DNS через прокси socks5
+ другие настройки, например стартовую страницу или темы + аддоны, очистить историю и закрыть браузер
5. ПКМ (таблица контейнеров) на `mageia9-palemoon:tmp` -> Создать образ `mageia9-palemoon:private`
6. Запустить образ `mageia9-palemoon:private`
+ двойной клик, вставить команду: `--rm --env="DISPLAY" --net=host --device=/dev/dri`
+ и нажать Ok

*Результат: приватное окно в интернет + безопасность + изоляция от основной ОС.*

**Примеры запуска**
1. Из терминала (su): `docker run --rm --env="DISPLAY" --net=host --device=/dev/dri mageia9-palemoon:private`
3. Из DockerManager (см. выше)
4. С Ярлыка `Меню-Интернет-Palemoon-Private (Docker)`; требуется установка [лаунчера](https://github.com/AKotov-dev/mageia9-palemoon-private/tree/main/palemoon-private-launcher)
