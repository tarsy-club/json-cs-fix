# json cs fix #

Сортитует структуру корневого `composer.json` по ключам, по алфавиту.

Чтобы воспользоваться им через композер нужно в `composer.json` в секцию `scripts` или `scripts-dev` добавить 

```json
{
   "json:fix": "json-cs-fix.sh"
}
```

и запустить

```bash
composer run json:fix
```

в аргументах к вызову команды можно добавить путь до произвольного json файла 

```bash
composer run json:fix other.json
```
