# mageia-palemoon:private
[Образ Docker для безопасного веб-серфинга](https://drive.google.com/drive/folders/1ekXmN1QdEJDFFnj_dWf0ATGKFK4nVMo7?usp=sharing)  

*Примечание: для быстрого изготовления и запуска использовался [DockerManager](https://github.com/AKotov-dev/docker-manager)*


**Изготовление образа mageia-palemoon:private**
1. ПКМ (таблица образов) -> Создать образ из Dockerfile
2. Указать Новый образ: `mageia-palemoon:tmp`
3. Вставить содержимое [Dockerfile](https://github.com/AKotov-dev/mageia-palemoon-private/blob/main/Dockerfile) и нажать Ок:
4. Создан образ `mageia-palemoon:tmp`
+ двойной клик, вставить команду: `--env="DISPLAY" --net=host --device=/dev/dri`
+ откроется браузер Palemoon из контейнера, установить в нём
+ прокси socks5: `127.0.0.1`, порт `9050`
+ DNS через прокси socks5
+ другие настройки, например стартовую страницу или темы + аддоны, очистить историю и закрыть браузер
5. ПКМ (таблица контейнеров) на `mageia-palemoon:tmp` -> Создать образ `mageia-palemoon:private`
6. Запустить образ `mageia-palemoon:private`
+ двойной клик, вставить команду: `--rm --env="DISPLAY" --net=host --device=/dev/dri`
+ и нажать Ok

*Результат: приватное окно в интернет + безопасность + изоляция от основной ОС.*

**Дополнительные примеры запуска**
1. Из терминала (su): `docker run --rm --env="DISPLAY" --net=host --device=/dev/dri mageia-palemoon:private`
2. С Ярлыка `Меню-Интернет-PaleMoon-Private (Docker)`; требуется установка [лаунчера](https://github.com/AKotov-dev/mageia-palemoon-private/tree/main/palemoon-private-launcher)
