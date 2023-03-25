# maating

<br>
<br>

## 1. Lancer l'application

\- Pour lancer l'application depuis un émulateur :</br>
```
cd ./frontend
flutter run
```
les requêtes sont envoyées en local au back via l'adresse http://10.0.2.2:4000

<br>

\- Pour lancer l'application depuis un téléphone physique :</br>
```
cd ./frontend
flutter run --dart-define="BACK_ENV=remote" 
```
les requêtes sont envoyées au back via l'adresse https://maating-api.up.railway.app
> :warning: la version du back disponible à cette adresse est celle de la branch main

<br>

## 2. Exécution des tests

### Front
\- Pour exécuter les tests d'intégration :<br>
```
cd ./frontend
flutter test integration_test
```

\- Pour exécuter les tests unitaires :<br>
```
cd ./frontend
flutter test test
```

### Back
\- Pour exécuter les tests unitaires :<br>
```
cd ./backend
npm test
```

<br>
<br>
<br>
<br>

:soccer:

