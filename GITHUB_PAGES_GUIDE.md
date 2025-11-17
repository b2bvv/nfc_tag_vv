# Размещение сайта на GitHub Pages (бесплатно)

## Шаг 1: Создание репозитория на GitHub

1. Зайдите на [GitHub.com](https://github.com) и войдите в аккаунт (или создайте новый)
2. Нажмите кнопку **"New"** или **"+"** → **"New repository"**
3. Заполните данные:
   - **Repository name**: например, `nfc-vv-products` (любое имя)
   - **Description**: опционально
   - **Visibility**: выберите **Public** (для бесплатного GitHub Pages нужен публичный репозиторий)
   - **НЕ** добавляйте README, .gitignore или лицензию (мы добавим файлы сами)
4. Нажмите **"Create repository"**

## Шаг 2: Установка Git (если еще не установлен)

### Windows:
1. Скачайте Git с [git-scm.com](https://git-scm.com/download/win)
2. Установите с настройками по умолчанию

### Проверка установки:
Откройте командную строку или PowerShell и выполните:
```bash
git --version
```

## Шаг 3: Инициализация Git в вашей папке проекта

1. Откройте командную строку или PowerShell
2. Перейдите в папку проекта:
```bash
cd C:\Users\Вкусвилл\Desktop\nfc_vv
```

3. Инициализируйте Git:
```bash
git init
```

4. Добавьте все файлы:
```bash
git add .
```

5. Сделайте первый коммит:
```bash
git commit -m "Initial commit: product landing pages"
```

## Шаг 4: Подключение к GitHub репозиторию

1. Скопируйте URL вашего репозитория (например: `https://github.com/ваш-username/nfc-vv-products.git`)

2. Добавьте remote:
```bash
git remote add origin https://github.com/ваш-username/nfc-vv-products.git
```

3. Переименуйте ветку в `main` (если нужно):
```bash
git branch -M main
```

4. Отправьте файлы на GitHub:
```bash
git push -u origin main
```

Вас попросят ввести логин и пароль GitHub (или токен доступа).

## Шаг 5: Включение GitHub Pages

1. На странице вашего репозитория на GitHub перейдите в **Settings**
2. В левом меню найдите раздел **Pages**
3. В разделе **Source** выберите:
   - **Branch**: `main`
   - **Folder**: `/ (root)`
4. Нажмите **Save**

## Шаг 6: Получение URL вашего сайта

После сохранения настроек ваш сайт будет доступен по адресу:

```
https://ваш-username.github.io/nfc-vv-products/
```

Например:
```
https://vkusvill.github.io/nfc-vv-products/
```

**Важно**: Изменения могут появиться через 1-5 минут после публикации.

## Шаг 7: Настройка красивых URL для товаров

GitHub Pages не поддерживает серверные правила переписывания URL, но мы можем использовать JavaScript routing.

### Вариант А: Использование hash routing (простой)

Измените ссылки на товары, чтобы использовать hash:

```
https://ваш-username.github.io/nfc-vv-products/#pu-erh-tea
https://ваш-username.github.io/nfc-vv-products/#protein-cream-tubes
```

Обновите `global.js` для поддержки hash:

```javascript
function getCurrentProductId() {
  // Try to get product ID from hash (e.g., #pu-erh-tea)
  const hash = window.location.hash.replace('#', '');
  if (hash) {
    return hash;
  }
  
  // Try to get product ID from URL path
  const path = window.location.pathname;
  const pathParts = path.split('/').filter(part => part && part !== 'index.html');
  
  if (pathParts.length > 0) {
    const productIdFromPath = pathParts[pathParts.length - 1];
    if (productIdFromPath && !productIdFromPath.includes('.')) {
      return productIdFromPath;
    }
  }
  
  // Try to get product ID from URL parameter
  const urlParams = new URLSearchParams(window.location.search);
  const productId = urlParams.get('product');
  if (productId) {
    return productId;
  }
  
  // Default to first product
  return productsData?.products?.[0]?.id || 'pu-erh-tea';
}
```

### Вариант Б: Использование 404.html для обработки маршрутов (РЕКОМЕНДУЕТСЯ)

Этот вариант позволяет использовать красивые URL без hash.

1. Создайте файл `404.html` в корне проекта (скопируйте содержимое `index.html`)

2. Добавьте в начало `<head>` файла `404.html` скрипт:

```html
<script>
  // Redirect to index.html with product parameter
  const path = window.location.pathname;
  const pathParts = path.split('/').filter(part => part && part !== '');
  
  if (pathParts.length > 0) {
    const lastPart = pathParts[pathParts.length - 1];
    // If it's not a file (no extension), treat it as product ID
    if (lastPart && !lastPart.includes('.')) {
      window.location.href = '/nfc-vv-products/index.html?product=' + lastPart;
    }
  }
</script>
```

3. Обновите `index.html` - добавьте в начало `<head>`:

```html
<script>
  // Handle product routing
  const path = window.location.pathname;
  const pathParts = path.split('/').filter(part => part && part !== '' && part !== 'index.html');
  
  if (pathParts.length > 0) {
    const lastPart = pathParts[pathParts.length - 1];
    if (lastPart && !lastPart.includes('.')) {
      // Add product parameter if not present
      if (!window.location.search.includes('product=')) {
        window.location.search = '?product=' + lastPart;
      }
    }
  }
</script>
```

## Шаг 8: Обновление файлов на GitHub

После любых изменений в файлах:

1. Добавьте изменения:
```bash
git add .
```

2. Сделайте коммит:
```bash
git commit -m "Update: add product routing"
```

3. Отправьте на GitHub:
```bash
git push
```

Изменения появятся на сайте через 1-5 минут.

## Шаг 9: Настройка кастомного домена (опционально)

Если у вас есть свой домен:

1. В настройках репозитория → **Pages** → **Custom domain**
2. Введите ваш домен (например: `products.vkusvill.ru`)
3. Настройте DNS записи у регистратора домена:
   - **Тип**: CNAME
   - **Имя**: `products` (или `www`)
   - **Значение**: `ваш-username.github.io`
4. Подождите распространения DNS (5-30 минут)

## Примеры URL после настройки

### С параметром (работает сразу):
```
https://ваш-username.github.io/nfc-vv-products/index.html?product=pu-erh-tea
https://ваш-username.github.io/nfc-vv-products/index.html?product=protein-cream-tubes
```

### С hash (после обновления кода):
```
https://ваш-username.github.io/nfc-vv-products/#pu-erh-tea
https://ваш-username.github.io/nfc-vv-products/#protein-cream-tubes
```

### Красивые URL (после настройки 404.html):
```
https://ваш-username.github.io/nfc-vv-products/pu-erh-tea
https://ваш-username.github.io/nfc-vv-products/protein-cream-tubes
```

## Структура файлов в репозитории

```
nfc-vv-products/
├── index.html
├── 404.html (для обработки маршрутов)
├── global.js
├── global.css
├── products.json
├── README.md (опционально)
├── images/
│   └── ... (все изображения)
├── fonts/
│   └── ... (все шрифты)
├── video/
│   └── ... (все видео)
├── image_preview/
│   └── ... (все превью)
└── image_block/
    └── ... (все блоки изображений)
```

## Важные замечания

1. **Размер файлов**: GitHub Pages бесплатен, но репозиторий ограничен 100 МБ. Если видео большие, рассмотрите использование внешнего хранилища.

2. **Публичность**: Репозиторий должен быть **Public** для бесплатного GitHub Pages.

3. **HTTPS**: GitHub Pages автоматически предоставляет HTTPS.

4. **Обновления**: После каждого `git push` изменения появляются через 1-5 минут.

5. **Ограничения**: 
   - 100 ГБ трафика в месяц
   - 100 сборок в час
   - 10 сборок в час для одного репозитория

## Быстрая команда для обновления

Создайте файл `update.bat` в папке проекта:

```batch
@echo off
git add .
git commit -m "Update site"
git push
echo Site updated! Wait 1-5 minutes for changes to appear.
pause
```

Теперь просто запускайте `update.bat` для обновления сайта.

## Решение проблем

### Сайт не обновляется:
- Подождите 5 минут
- Очистите кэш браузера (Ctrl+F5)
- Проверьте, что файлы загружены в репозиторий

### 404 ошибка:
- Убедитесь, что `index.html` находится в корне репозитория
- Проверьте настройки Pages (branch: main, folder: /)

### JavaScript не работает:
- Проверьте консоль браузера (F12)
- Убедитесь, что пути к файлам правильные (относительные пути)

## Преимущества GitHub Pages

✅ **Бесплатно** - полностью бесплатный хостинг  
✅ **HTTPS** - автоматический SSL сертификат  
✅ **CDN** - быстрая загрузка по всему миру  
✅ **Простота** - легко обновлять через Git  
✅ **Надежность** - инфраструктура GitHub  
✅ **Версионирование** - история всех изменений  

