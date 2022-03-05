# akotovdev/mageia-palemoon:private
Образ Docker для безопасного веб-серфинга.  

*Примечание: для быстрого изготовления использовался [DockerManager](https://github.com/AKotov-dev/docker-manager)*  
  
Имя в DockerHub: `akotovdev/mageia-palemoon:private`  
Не забудьте включить пользователя в группу `docker`: `usermod -aG docker $LOGNAME && reboot`
  
**Изготовление образа akotovdev/mageia-palemoon:private**
1. ПКМ (таблица образов) -> Создать образ из Dockerfile
2. Указать Новый образ: `akotovdev/mageia-palemoon:tmp`
3. Вставить содержимое [Dockerfile](https://github.com/AKotov-dev/mageia-palemoon-private/blob/main/Dockerfile) и нажать Ок:
4. Создан образ `akotovdev/mageia-palemoon:tmp`
+ двойной клик, вставить команду: `--env="DISPLAY" --net=host --device=/dev/dri`
+ откроется браузер PaleMoon из контейнера, установить в нём
+ прокси socks5: `127.0.0.1`, порт `9050`
+ DNS через прокси socks5
+ другие настройки, например стартовую страницу или темы + аддоны, очистить историю и закрыть браузер
5. ПКМ (таблица контейнеров) на `akotovdev/mageia-palemoon:tmp` -> Создать образ `akotovdev/mageia-palemoon:private`
6. Запустить образ `akotovdev/mageia-palemoon:private`
+ двойной клик, вставить команду: `--rm --env="DISPLAY" --net=host --device=/dev/dri`
+ и нажать Ok

*Результат: приватное окно в интернет + безопасность + изоляция от основной ОС.*

**Дополнительные примеры загрузки/запуска**
1. Из терминала под юзером: `docker run --rm --env="DISPLAY" --net=host --device=/dev/dri akotovdev/mageia-palemoon:private`
2. С Ярлыка `Меню-Интернет-PaleMoon-Private (Docker)`; требуется установка [лаунчера](https://github.com/AKotov-dev/mageia-palemoon-private/tree/main/palemoon-private-launcher)
